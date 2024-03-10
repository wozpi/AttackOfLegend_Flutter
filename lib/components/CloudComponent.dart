import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';

class CloudComponent extends SpriteComponent with HasGameRef {
  String path;
  double withSize;
  Function() onDead;
  CloudComponent(
      {required this.path, required this.withSize, required this.onDead});

  @override
  FutureOr<void> onLoad() {
    Vector2 gameScreen = gameRef.size / gameRef.camera.viewfinder.zoom;
    var imgCloud = Flame.images.fromCache('environment/cloud1.png');
    sprite = Sprite(imgCloud);
    size = Vector2(withSize, withSize * imgCloud.height / imgCloud.width);
    var time = (gameScreen.x + withSize - x) / 0.8;
    add(MoveEffect.to(
        Vector2(gameScreen.x + withSize, y), EffectController(duration: time),
        onComplete: onDead));
    return super.onLoad();
  }
}
