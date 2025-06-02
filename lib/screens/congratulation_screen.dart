import 'package:desktop_tennis_score/entities.dart';
import 'package:desktop_tennis_score/widgets/black_button.dart';
import 'package:flutter/material.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({
    super.key,
    required this.winner,
    required this.playAgainFunction,
  });

  final Player winner;
  final void Function() playAgainFunction;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Победил:'),
      ),
      body: GestureDetector(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: winner.color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: height / 9),
                ),
                SizedBox(height: width / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlackButton(
                      text: 'Завершить игру',
                      onPressed: () => Navigator.pop(context),
                      height: height / 30,
                      textColor: Color.fromARGB(255, 255, 220, 220),
                    ),
                    SizedBox(width: 50),
                    BlackButton(
                      text: 'Играть дальше',
                      onPressed: playAgainFunction,
                      height: height / 30,
                      textColor: Color.fromARGB(255, 220, 255, 220),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
