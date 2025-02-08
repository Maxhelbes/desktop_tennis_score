import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:desktop_tennis_score/entities.dart';
import 'package:desktop_tennis_score/screens/choose_turn_screen.dart';
import 'package:desktop_tennis_score/screens/congratulation_screen.dart';
import 'package:flutter/material.dart';

enum AppState {
  chooseTurn,
  game,
  congratulations,
}

class ScorePage extends StatefulWidget {
  ScorePage({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
  });

  Player leftPlayer;
  Player rightPlayer;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  AppState myState = AppState.chooseTurn;
  int _scoreGreen = 0;
  int _scoreRed = 0;
  int _turnCounter = 0;
  bool _redTurn = false;
  int _globalScoreGreen = 0;
  int _globalScoreRed = 0;
  int _turnChanger = 2;
  Player _winner = Player(name: 'Ошибка', color: Colors.cyan);
  List<(bool, int, int, int, int)> _scoreOrder = [];
  // (_redTurn, _scoreGreen, _scoreRed, _turnCounter, _turnChanger)

  bool _checkWin() {
    if (_scoreGreen >= 10 && _scoreRed >= 10) {
      _turnChanger = 1;
    }

    if ((_scoreGreen >= 11 || _scoreRed >= 11) &&
        ((_scoreRed - _scoreGreen).abs() >= 2)) {
      if (_scoreRed > _scoreGreen) {
        _winner = widget.rightPlayer;
      } else {
        _winner = widget.leftPlayer;
      }
      _scoreGreen = 0;
      _scoreRed = 0;
      _turnCounter = 0;
      _redTurn = false;
      _turnChanger = 2;
      myState = AppState.congratulations;
      _scoreOrder.clear();
      return true;
    }
    return false;
  }

  void _checkTurn() {
    if (_turnCounter == _turnChanger) {
      _turnCounter = 0;
      _redTurn = !_redTurn;
    }
    _scoreOrder
        .add((_redTurn, _scoreGreen, _scoreRed, _turnCounter, _turnChanger));
    print(_scoreOrder);
  }

  void _incrementGreen() {
    setState(() {
      _scoreGreen++;
      _turnCounter++;
      _checkTurn();
      if (_checkWin()) {
        _globalScoreGreen++;
      }
    });
  }

  void _incrementRed() {
    setState(() {
      _scoreRed++;
      _turnCounter++;
      _checkTurn();
      if (_checkWin()) {
        _globalScoreRed++;
      }
    });
  }

  void _chooseRed() {
    setState(() {
      myState = AppState.game;
      _redTurn = true;
    });
    _scoreOrder
        .add((_redTurn, _scoreGreen, _scoreRed, _turnCounter, _turnChanger));
    AudioPlayer().play(AssetSource('sounds/gong.mp3'));
  }

  void _chooseGreen() {
    setState(() {
      myState = AppState.game;
      _redTurn = false;
    });
    _scoreOrder
        .add((_redTurn, _scoreGreen, _scoreRed, _turnCounter, _turnChanger));
    AudioPlayer().play(AssetSource('sounds/gong.mp3'));
  }

  Text _getTitleText() {
    if (_redTurn) {
      return Text(
        'Подает: ${widget.rightPlayer.name}',
        style: TextStyle(color: widget.rightPlayer.color, fontSize: 40),
      );
    }
    return Text(
      'Подает: ${widget.leftPlayer.name}',
      style: TextStyle(color: widget.leftPlayer.color, fontSize: 40),
    );
  }

  void _playAgain() {
    setState(() {
      myState = AppState.chooseTurn;
    });
  }

  void swapPlayers() {
    setState(() {
      Player tempRight = Player.clone(widget.rightPlayer);
      widget.rightPlayer = Player.clone(widget.leftPlayer);
      widget.leftPlayer = Player.clone(tempRight);

      int bufferGreen = _globalScoreGreen;
      _globalScoreGreen = _globalScoreRed;
      _globalScoreRed = bufferGreen;
    });
  }

  bool rejectTurn() {
    bool output = false;
    setState(() {
      print(_scoreOrder);
      if (_scoreOrder.length > 1) {
        _scoreOrder.removeLast();
        _redTurn = _scoreOrder.last.$1;
        _scoreGreen = _scoreOrder.last.$2;
        _scoreRed = _scoreOrder.last.$3;
        _turnCounter = _scoreOrder.last.$4;
        _turnChanger = _scoreOrder.last.$5;
      }
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    if (myState == AppState.chooseTurn) {
      return ChooseTurnScreen(
          leftPlayer: widget.leftPlayer,
          leftTap: _chooseGreen,
          rightPlayer: widget.rightPlayer,
          rightTap: _chooseRed);
    }
    if (myState == AppState.game) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: _getTitleText(),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.restore_outlined,
              color: Colors.white,
              size: 35,
              semanticLabel: 'Отменить ход',
            ),
            onPressed: () {
              if (rejectTurn()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: const Text('Ход отменён')),
                  ),
                );
              }
            },
          ),
        ),
        body: Row(
          children: [
            ScoreTile(
              onTap: _incrementGreen,
              width: width,
              color: widget.leftPlayer.color,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  SizedBox(width: height / 12),
                  Center(
                    child: Container(
                      width: width / 3,
                      decoration: BoxDecoration(
                        color: !_redTurn ? Colors.black : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_scoreGreen',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height / 2.5,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                          child: Text(
                        '$_globalScoreGreen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 9,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                    ],
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            ScoreTile(
              onTap: _incrementRed,
              width: width,
              color: widget.rightPlayer.color,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(
                          child: Text(
                        '$_globalScoreRed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 9,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Container(
                      width: width / 3,
                      decoration: BoxDecoration(
                        color: _redTurn ? Colors.black : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_scoreRed',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height / 2.5,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: height / 12),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (myState == AppState.congratulations) {
      AudioPlayer().play(AssetSource('sounds/win.mp3'));
      swapPlayers();
      return CongratulationScreen(
          winner: _winner, playAgainFunction: _playAgain);
    }
    return Placeholder();
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({
    super.key,
    required this.onTap,
    required this.color,
    required this.width,
    required this.child,
  });

  final GestureTapCallback onTap;
  final Color color;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        height: double.infinity,
        width: width / 2,
        child: child,
      ),
    );
  }
}
