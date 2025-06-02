import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();
  final AudioCache _cache = AudioCache(prefix: 'assets/');
  final SharedPreferences _prefs;

  // Звуки
  AssetSource? _gongSound;
  AssetSource? _fanfareSound;
  bool _isGongEnabled = true;
  bool _isFanfareEnabled = true;

  List<AssetSource>? _scoreSounds;

  set gongStatus(bool value) {
    _isGongEnabled = value;
    _prefs.setBool('gongSound', value);
  }

  set fanfareStatus(bool value) {
    _isFanfareEnabled = value;
    _prefs.setBool('fanfareSound', value);
  }

  bool get getFanfareStatus => _isFanfareEnabled;
  bool get getGongStatus => _isGongEnabled;

  SoundService(this._prefs);

  Future<void> init() async {
    log('init SounsService');
    // Загружаем настройки
    _isGongEnabled = _prefs.getBool('gongSound') ?? true;
    _isFanfareEnabled = _prefs.getBool('fanfareSound') ?? true;

    // Инициализируем источники
    _gongSound = AssetSource('sounds/gong.mp3');
    _fanfareSound = AssetSource('sounds/win.mp3');

    // Предзагрузка звуков в кэш
    // await Future.wait([
    //   _cache.load('sounds/gong.mp3'),
    //   _cache.load('sounds/win.mp3'),
    // ]);

    await _cache.load('sounds/gong.mp3');
    await _cache.load('sounds/win.mp3');

    // for (int i in [0, 1, 2]) {
    //   _cache.load('sounds/$i.mp3');
    // }
  }

  Future<void> playScore(int one, int two) async {
    await _player.play(AssetSource('sounds/begin/$one.mp3'));
    await _player.onPlayerComplete.first;
    await _player.play(AssetSource('sounds/end/$two.mp3'));
  }

  Future<void> playEqual() async {
    await _player.play(AssetSource('sounds/equal.mp3'));
  }

  Future<void> playLess() async {
    await _player.play(AssetSource('sounds/less.mp3'));
  }

  Future<void> playMore() async {
    await _player.play(AssetSource('sounds/more.mp3'));
  }

  Future<void> playGong() async {
    if (!_isGongEnabled || _gongSound == null) return;
    await _player.play(_gongSound!);
  }

  Future<void> playFanfare() async {
    if (!_isFanfareEnabled || _fanfareSound == null) return;
    await _player.play(_fanfareSound!);
  }

  void dispose() {
    _player.dispose();
  }
}
