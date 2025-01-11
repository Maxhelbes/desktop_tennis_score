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
      theme: theme,
      home: CreatePlayers(),
      // ScorePage(
      //   leftPlayer: leftPlayer,
      //   rightPlayer: rightPlayer,
      // ),
    );
  }
}






// class CongratulationsPage extends StatelessWidget {
//   const CongratulationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final winner = Player(name: '123', color: Colors.deepPurple);
//     final playAgainFunction = () {};

//     return CongratulationScreen(
//         winner: winner, playAgainFunction: playAgainFunction);
//   }
// }


// class ChooseTurnPage extends StatelessWidget {
//   const ChooseTurnPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final leftPlayer = Player(name: 'Никуткин', color: Colors.green);
//     final rightPlayer = Player(name: 'Холобаев', color: Colors.red);

//     return ChooseTurnScreen(
//       leftPlayer: leftPlayer,
//       rightPlayer: rightPlayer,
//       leftTap: () {},
//       rightTap: () {},
//     );
//   }
// }