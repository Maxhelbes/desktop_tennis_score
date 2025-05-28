import 'package:desktop_tennis_score/entities.dart';
import 'package:desktop_tennis_score/pages/create_players.dart';
import 'package:desktop_tennis_score/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final leftPlayer = Player(name: 'Зеленый', color: Colors.green);
final rightPlayer = Player(name: 'Красный', color: Colors.red);

void main() {
  // WakelockPlus.toggle(enable: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dont turn off screen
    WakelockPlus.enable();
    // horizontal only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Теннис-Табло",
      theme: theme,
      home: CreatePlayers(),
      // ScorePage(
      //   leftPlayer: leftPlayer,
      //   rightPlayer: rightPlayer,
      // ),
    );
  }
}
