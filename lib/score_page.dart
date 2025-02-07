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
  var myState = AppState.chooseTurn;
  int _scoreGreen = 0;
  int _scoreRed = 0;
  int _turnCounter = 0;
  bool _redTurn = false;
  int _globalScoreGreen = 0;
  int _globalScoreRed = 0;
  int _turnChanger = 2;
  Player _winner = Player(name: 'Ошибка', color: Colors.cyan);
  // bool _chooseTurn = true;

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
      return true;
    }
    return false;
  }

  void _checkTurn() {
    if (_turnCounter == _turnChanger) {
      _turnCounter = 0;
      _redTurn = !_redTurn;
    }
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
  }

  void _chooseGreen() {
    setState(() {
      myState = AppState.game;
      _redTurn = false;
    });
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
          leading: const Icon(Icons.menu, color: Colors.black),
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


      // OLD CHOOSE TURN
      // return AlertDialog(
      //   title: Center(child: const Text("Первым подает?")),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: _chooseGreen,
      //       child: Container(
      //         color: Colors.green,
      //         padding: const EdgeInsets.all(14),
      //         child: const Text("Зеленый",
      //             style: TextStyle(color: Colors.white, fontSize: 40)),
      //       ),
      //     ),
      //     TextButton(
      //       onPressed: _chooseRed,
      //       child: Container(
      //         color: Colors.red,
      //         padding: const EdgeInsets.all(14),
      //         child: const Text("Красный",
      //             style: TextStyle(color: Colors.white, fontSize: 40)),
      //       ),
      //     ),
      //   ],
      // );