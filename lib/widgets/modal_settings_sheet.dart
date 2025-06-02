import 'package:audioplayers/audioplayers.dart';
import 'package:desktop_tennis_score/pages/menu_page.dart';
import 'package:desktop_tennis_score/services/sound_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModalSettingsSheet extends StatefulWidget {
  const ModalSettingsSheet({
    super.key,
  });

  @override
  State<ModalSettingsSheet> createState() => _ModalSettingsSheetState();
}

class _ModalSettingsSheetState extends State<ModalSettingsSheet> {
  // bool _voiceScoreSound = true;

  late final SoundService _soundService;

  @override
  void initState() {
    super.initState();
    _soundService = GetIt.I<SoundService>();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        height: MediaQuery.of(context).size.height * 0.9, // % экрана
        child: Column(
          children: [
            Text('Настройки', style: textTheme.headlineSmall),
            Divider(),
            SwitchListTile(
              title: Text(
                'Звук  «Гонг»  при старте матча',
                style: textTheme.bodyMedium,
              ),
              dense: true,
              activeTrackColor: Colors.blue,
              value: _soundService.getGongStatus, ////////
              onChanged: (bool value) {
                setState(() {
                  _soundService.gongStatus = value;
                  _soundService.playGong();
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Звук  «Фанфары»  в конце матча',
                style: textTheme.bodyMedium,
              ),
              dense: true,
              activeTrackColor: Colors.blue,
              value: _soundService.getFanfareStatus,
              onChanged: (bool value) {
                setState(() {
                  _soundService.fanfareStatus = value;
                  _soundService.playFanfare();
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Голосовое озвучивание счёта (В разработке)',
                style: textTheme.bodyMedium,
              ),
              dense: true,

              activeTrackColor: Colors.blue,
              // value: _voiceScoreSound,
              value: false,
              onChanged: null,
              // (bool value) {
              //   setState(() {
              //     _voiceScoreSound = value;
              //   });
              // },
            ),
          ],
        ),
      ),
    );
  }
}
