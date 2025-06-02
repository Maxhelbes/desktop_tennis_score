import 'package:audioplayers/audioplayers.dart';
import 'package:desktop_tennis_score/pages/menu_page.dart';
import 'package:desktop_tennis_score/services/sound_service.dart';
import 'package:desktop_tennis_score/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<SoundService>(SoundService(prefs));

  GetIt.I.registerSingleton<AudioPlayer>(AudioPlayer());

  await GetIt.I<SoundService>().init();

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
      home: MenuPage(),
    );
  }
}
