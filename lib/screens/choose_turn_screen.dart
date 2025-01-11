import 'package:desktop_tennis_score/entities.dart';
import 'package:desktop_tennis_score/widgets.dart';
import 'package:flutter/material.dart';

class ChooseTurnScreen extends StatelessWidget {
  const ChooseTurnScreen({
    super.key,
    required this.leftPlayer,
    required this.leftTap,
    required this.rightPlayer,
    required this.rightTap,
  });
  final Player leftPlayer;
  final GestureTapCallback leftTap;
  final Player rightPlayer;
  final GestureTapCallback rightTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Первым подает: '),
      ),
      body: Row(
        children: [
          GestureDetector(
            onTap: leftTap,
            child: HalfTile(
              color: leftPlayer.color,
              child: Center(
                child: Text(
                  leftPlayer.name,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: MediaQuery.sizeOf(context).height / 9),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: rightTap,
            child: HalfTile(
              color: rightPlayer.color,
              child: Center(
                child: Text(
                  rightPlayer.name,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: MediaQuery.sizeOf(context).height / 9),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
