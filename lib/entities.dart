import 'package:flutter/material.dart';

class Player {
  Player({
    required this.name,
    required this.color,
  });

  Player.clone(Player newPlayer)
      : this(name: newPlayer.name, color: newPlayer.color);

  String name;
  MaterialColor color;
  int score = 0;
  int globalScore = 0;

  void incrementScore() => score++;
  void incrementGlobalScore() => globalScore++;
}

class Referee {
  Referee();

  bool whoTurn = false;
  int turnCounter = 0;
  int turnLimit = 2;

  bool swapPlayers = false;
}
