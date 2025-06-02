import 'package:desktop_tennis_score/pages/create_players.dart';
import 'package:desktop_tennis_score/widgets/black_button.dart';
import 'package:desktop_tennis_score/widgets/modal_settings_sheet.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Теннис Табло'),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: ColoredBox(
                  color: Colors.green,
                  child: SizedBox.expand(),
                ),
              ),
              Flexible(
                flex: 1,
                child: ColoredBox(
                  color: Colors.red,
                  child: SizedBox.expand(),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlackButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePlayers())),
                    height: height / 20,
                    text: 'Начать матч'),
                // BlackButton(
                //   onPressed: () {},
                //   height: height / 20,
                //   text: 'Статистика',
                // ),
                BlackButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      // enableDrag: false,
                      builder: (context) => ModalSettingsSheet()),
                  height: height / 20,
                  text: 'Настройки',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
