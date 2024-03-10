import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:vibration/vibration.dart';

class AudioGame extends Component {
  late AudioPool batDeadPool;
  late AudioPool popPool;
  late AudioPool shootPool;

  late AudioPool completePool;
  late AudioPool failPool;

  bool canPlayMusic = false;
  bool canPlaySound = true;
  bool canVibrate = false;

  AudioGame(
      {required this.canPlayMusic,
      required this.canPlaySound,
      required this.canVibrate});

  @override
  FutureOr<void> onLoad() async {
    batDeadPool = await FlameAudio.createPool(
      'sfx/bat_dead.wav',
      minPlayers: 1,
      maxPlayers: 4,
    );

    popPool = await FlameAudio.createPool(
      'sfx/pop.wav',
      minPlayers: 1,
      maxPlayers: 4,
    );

    shootPool = await FlameAudio.createPool(
      'sfx/shoot.wav',
      minPlayers: 1,
      maxPlayers: 4,
    );

    completePool = await FlameAudio.createPool(
      'musics/complete_game.wav',
      minPlayers: 1,
      maxPlayers: 1,
    );

    failPool = await FlameAudio.createPool(
      'musics/game_over.wav',
      minPlayers: 1,
      maxPlayers: 1,
    );
    FlameAudio.bgm.initialize();
    startBgmMusic();
    return super.onLoad();
  }

  void startBgmMusic() {
    if (!FlameAudio.bgm.isPlaying && canPlayMusic) {
      // FlameAudio.bgm.play('musics/Woodland_Fantasy.mp3');
    }
  }

  void stopBgmMusic() {
    if (FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.stop();
    }
  }

  void onComlete() {
    if (canPlayMusic) {
      completePool.start();
    }
  }

  void onFail() {
    if (canPlayMusic) {
      completePool.start();
    }
  }

  void firer() {
    if (canPlaySound) {
      shootPool.start();
    }
  }

  void batDead() {
    if (canPlaySound) {
      batDeadPool.start();
    }
  }

  void popAudio() {
    if (canPlaySound) {
      popPool.start();
    }
  }

  void onVibrate() async {
    if (await Vibration.hasVibrator() == true && canVibrate) {
      Vibration.vibrate();
    }
  }
}
