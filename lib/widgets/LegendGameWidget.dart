import 'dart:async';

import 'package:attack_of_legend/components/Toolbar.dart';
import 'package:attack_of_legend/world/HomeScene.dart';
import 'package:attack_of_legend/world/PlayGameScene.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/flame_forge2d.dart' as forge_2d;

class LegendGameWidget extends Forge2DGame
    with HasCollisionDetection, LongPressDetector {
  LegendGameWidget({CameraComponent? camera})
      : super(zoom: 10, gravity: Vector2(0, 98), cameraComponent: camera);
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
  void onLongPressEnd() {
    if (_scene is PlayGameScene) {
      (_scene as PlayGameScene?)?.onPressedUp();
    }
  }

  void updateNumberFlier(int count) {
    _toolBar?.updateNumberFlier(count);
  }

  void enterPlayGameScene() {
    _toolBar?.enableBackButton();
    changeScene(PlayGameScene());
  }

  void enterHomeScene() {
    _toolBar?.enableSettingButton();
    changeScene(HomeScene());
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

  @override
  FutureOr<void> onLoad() async {
    await Flame.images.load("fx/Flier.png");
    await Flame.images.load("fx/Bat_Fx.png");
    await Flame.images.load("characters/flier/flier.png");
    await Flame.images.load("characters/flier/eyes.png");

    _toolBar = ToolBar()..priority = 10;
    add(_toolBar!);
    enterHomeScene();

    return super.onLoad();
  }
}
