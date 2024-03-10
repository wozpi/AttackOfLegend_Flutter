import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class FlyerSprite extends PositionComponent with HasGameRef {
  SpriteComponent? _eyeLeft;
  SpriteComponent? _eyeRight;
  Vector2 sizeEye = Vector2.zero();
  FlyerSprite() : super(key: ComponentKey.unique());
  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
        sprite: Sprite(Flame.images.fromCache("characters/flier/flier.png")),
        key: ComponentKey.unique())
      ..anchor = Anchor.center
      ..size = size);

    _eyeLeft = SpriteComponent(
        key: ComponentKey.unique(),
        sprite: Sprite(Flame.images.fromCache("characters/flier/eyes.png")))
      ..anchor = Anchor.center
      ..position = Vector2(-1 * size.x / 10, -2.5 * size.y / 10)
      ..size = size / 12;

    _eyeRight = SpriteComponent(
        key: ComponentKey.unique(),
        sprite: Sprite(Flame.images.fromCache("characters/flier/eyes.png")))
      ..anchor = Anchor.center
      ..position = Vector2(2.5 * size.x / 10, -2.5 * size.y / 10)
      ..size = size / 12;

    add(_eyeLeft!);
    add(_eyeRight!);
    add(RectangleHitbox(size: Vector2(3, 3)));
    return super.onLoad();
  }

  var timeOffset = 0.0;
  @override
  void update(double dt) {
    timeOffset += dt;
    if (timeOffset > 3) {
      _eyeLeft?.size = Vector2.zero();
      _eyeRight?.size = Vector2.zero();
      timeOffset = 0.0;
    } else {
      if (timeOffset > 0.1) {
        _eyeLeft?.size = size / 12;
        _eyeRight?.size = size / 12;
      }
    }
    super.update(dt);
  }
}
