import 'package:desktop_tennis_score/entities.dart';
import 'package:desktop_tennis_score/pages/score_page.dart';
import 'package:desktop_tennis_score/widgets/half_tile.dart';
import 'package:flutter/material.dart';

class CreatePlayers extends StatefulWidget {
  const CreatePlayers({super.key});

  @override
  State<CreatePlayers> createState() => _CreatePlayersState();
}

class _CreatePlayersState extends State<CreatePlayers> {
  final _leftPlayer = Player(name: 'Зеленый', color: Colors.green);
  final _rightPlayer = Player(name: 'Красный', color: Colors.red);

  _changeLeftName(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _leftPlayer.name = text;
      }
    });
  }

  _changeRightName(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _rightPlayer.name = text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Введите имена игроков:'),
        ),
        body: Row(
          children: [
            HalfTile(
              color: Colors.green,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Зеленый'),
                      keyboardType: TextInputType.name,
                      onChanged: _changeLeftName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontSize: MediaQuery.sizeOf(context).height / 9),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
            HalfTile(
              color: Colors.red,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Красный'),
                      keyboardType: TextInputType.name,
                      onChanged: _changeRightName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontSize: MediaQuery.sizeOf(context).height / 9),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScorePage(
                leftPlayer: _leftPlayer,
                rightPlayer: _rightPlayer,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 40,
          ),
        ));
  }
}
