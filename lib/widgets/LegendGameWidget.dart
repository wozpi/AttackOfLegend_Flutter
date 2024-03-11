import 'dart:async';
import 'package:attack_of_legend/common/AudioGame.dart';
import 'package:attack_of_legend/common/Contain.dart';
import 'package:attack_of_legend/components/Toolbar.dart';
import 'package:attack_of_legend/world/HomeScene.dart';
import 'package:attack_of_legend/world/LevelScene.dart';
import 'package:attack_of_legend/world/PlayGameScene.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/flame_forge2d.dart' as forge_2d;
import 'package:shared_preferences/shared_preferences.dart';
import '../popups/SettingsPopup.dart';

class LegendGameWidget extends Forge2DGame
    with HasCollisionDetection, LongPressDetector {
  LegendGameWidget({CameraComponent? camera})
      : super(zoom: 10, gravity: Vector2(0, 980), cameraComponent: camera);
  @override
  FutureOr<void> onLoad() {
    camera.viewfinder.anchor = Anchor.topLeft;
    world = LegendWorld();
    return super.onLoad();
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    (world as LegendWorld?)?.onLongPressEnd();
    super.onLongPressEnd(info);
  }
}

class LegendWorld extends forge_2d.Forge2DWorld
    with HasGameRef<LegendGameWidget>, TapCallbacks {
  Component? _scene;
  ToolBar? _toolBar;
  AudioGame? _audioManager;
  void onLongPressEnd() {
    if (_scene is PlayGameScene) {
      (_scene as PlayGameScene?)?.onPressedUp();
    }
  }

  void updateNumberFlier(int count) {
    _toolBar?.updateNumberFlier(count);
  }

  void enterNextPlayGameScene({int? atLevel}) async {
    _toolBar?.enableBackButton();
    _toolBar?.enableFrameFlier(true);
    if (atLevel == null) {
      final pref = await SharedPreferences.getInstance();
      int currentLevel = pref.getInt(Contain.heroLevel) ?? 1;
      changeScene(PlayGameScene(atLevel: currentLevel));
    } else {
      changeScene(PlayGameScene(atLevel: atLevel));
    }
  }

  void reloadPlayGameScene() async {
    _toolBar?.enableBackButton();
    _toolBar?.enableFrameFlier(true);

    final pref = await SharedPreferences.getInstance();
    int currentLevel = pref.getInt(Contain.heroLevel) ?? 1;
    changeScene(PlayGameScene(atLevel: currentLevel));
  }

  void showSettingPopup() async {
    final pref = await SharedPreferences.getInstance();
    bool canPlayMusic = pref.getBool(Contain.playMusic) ?? true;
    bool canPlaySound = pref.getBool(Contain.playSound) ?? true;
    bool canVibrate = pref.getBool(Contain.playVibrate) ?? false;
    add(SettingPopup(
        isTurnOnMusic: canPlayMusic,
        isTurnOnSound: canPlaySound,
        isTurnOnVibrate: canVibrate,
        onToogleChange: (tag, isToogle) async {
          final pref = await SharedPreferences.getInstance();
          switch (tag) {
            case 'MUSIC':
              if (isToogle) {
                _audioManager?.startBgmMusic();
              } else {
                _audioManager?.stopBgmMusic();
              }
              _audioManager?.canPlayMusic = isToogle;
              pref.setBool(Contain.playMusic, isToogle);
              break;
            case 'SOUND':
              _audioManager?.canPlaySound = isToogle;
              pref.setBool(Contain.playSound, isToogle);
              break;
            case 'VIBRATE':
              _audioManager?.canVibrate = isToogle;
              pref.setBool(Contain.playVibrate, isToogle);
              break;
            default:
          }
        }));
  }

  void enterPlayGameScene(int level) {
    _toolBar?.enableBackButton();
    _toolBar?.enableFrameFlier(true);
    changeScene(PlayGameScene(atLevel: level));
  }

  void enterHomeScene() async {
    _toolBar?.enableSettingButton();
    _toolBar?.enableFrameFlier(false);

    final pref = await SharedPreferences.getInstance();
    int currentLevel = pref.getInt(Contain.heroLevel) ?? 1;

    changeScene(HomeScene(
        onPlay: () {
          enterPlayGameScene(currentLevel);
        },
        onLevel: enterLevelScene));
  }

  void enterLevelScene() {
    _toolBar?.enableBackButton();
    _toolBar?.enableFrameFlier(false);
    changeScene(LevelScene());
  }

  void completeGame(int nextLevel) async {
    final pref = await SharedPreferences.getInstance();
    int currentLevel = pref.getInt(Contain.heroLevel) ?? 1;
    if (nextLevel > currentLevel) {
      pref.setInt(Contain.heroLevel, nextLevel);
    }
  }

  void changeScene(Component scene) {
    var sceneHolder = _scene;
    _scene = scene;
    add(_scene!);

    if (sceneHolder != null) {
      remove(sceneHolder);
      gameRef.camera.viewport.removeAll(gameRef.camera.viewport.children);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_scene is PlayGameScene) {
      (_scene as PlayGameScene?)?.onPressedDown();
    }
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (_scene is PlayGameScene) {
      (_scene as PlayGameScene?)?.onPressedUp();
    }
    super.onTapUp(event);
  }

  void onShootSFX() {
    _audioManager?.firer();
  }

  void onExploreSFX() {
    _audioManager?.explore();
  }

  void onFlierDeadSFX() {
    _audioManager?.popAudio();
  }

  void onBatDeadSFX() {
    _audioManager?.batDead();
  }

  void onComlete() {
    _audioManager?.onComlete();
  }

  void onFail() {
    _audioManager?.onFail();
  }

  @override
  FutureOr<void> onLoad() async {
    await Flame.images.load("fx/Flier.png");
    await Flame.images.load("fx/Bat_Fx.png");
    await Flame.images.load("characters/flier/flier.png");
    await Flame.images.load("characters/flier/eyes.png");

    await Flame.images.load("tree/dead_tree_01.png");
    await Flame.images.load("tree/dead_tree_02.png");
    await Flame.images.load("tree/dead_tree_03.png");
    await Flame.images.load("tree/dead_tree_04.png");

    await Flame.images.load("tree/flower.png");
    await Flame.images.load("tree/grass.png");
    await Flame.images.load("tree/leaf_tree1_01.png");
    await Flame.images.load("tree/leaf_tree1_02.png");
    await Flame.images.load("tree/leaf_tree1_03.png");

    await Flame.images.load("tree/leaf_tree2_01.png");
    await Flame.images.load("tree/leaf_tree2_02.png");
    await Flame.images.load("tree/leaf_tree2_03.png");
    await Flame.images.load("tree/leaf_tree3_01.png");

    _toolBar = ToolBar()..priority = 10;
    add(_toolBar!);
    enterHomeScene();
    final pref = await SharedPreferences.getInstance();
    bool canPlayMusic = pref.getBool(Contain.playMusic) ?? true;
    bool canPlaySound = pref.getBool(Contain.playSound) ?? true;
    bool canVibrate = pref.getBool(Contain.playVibrate) ?? false;

    _audioManager = AudioGame(
        canPlayMusic: canPlayMusic,
        canPlaySound: canPlaySound,
        canVibrate: canVibrate);
    add(_audioManager!);
    return super.onLoad();
  }
}
