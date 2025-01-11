import 'package:desktop_tennis_score/entities.dart';
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ColoredBox(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Завершить игру',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 220, 220),
                                      fontSize: height / 30),
                                )),
                          )),
                    ),
                    SizedBox(width: 50),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ColoredBox(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                                onPressed: playAgainFunction,
                                child: Text(
                                  'Играть дальше',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 220, 255, 220),
                                    fontSize: height / 30,
                                  ),
                                )),
                          )),
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
