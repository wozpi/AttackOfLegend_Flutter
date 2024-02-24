import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:attack_of_legend/components/Cannon.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

class BigHero extends PositionComponent with HasGameRef<LegendGameWidget> {
  Cannon? _cannon;
  @override
  FutureOr<void> onLoad() async {
    _cannon = Cannon();
    add(_cannon!);

    position =
        Vector2(4, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 7.5);

    Image imgBagCannon = await Flame.images.load("characters/hero/bag.png");
    Vector2 originBagSize = imgBagCannon.size / 10;
    add(SpriteComponent(sprite: Sprite(imgBagCannon))
      ..anchor = Anchor.center
      ..position = Vector2(-0.2, 1.2)
      ..size = Vector2(2, 2 * originBagSize.y / originBagSize.x));

    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load("characters/hero/hero.png")))
      ..position = Vector2(0, 0.55)
      ..size = Vector2(5, 5)
      ..anchor = Anchor.center);

    return super.onLoad();
  }

  void goingToAim() {
    _cannon?.anim();
  }

  double getAngleCannon() {
    return _cannon?.getAngleDegress() ?? 0.0;
  }

  void releaseAim() {
    _cannon?.release();
  }

  Vector2 getDirection() {
    return _cannon?.getDirection() ?? Vector2.zero();
  }

  Vector2 atShoot() {
    return _cannon?.atShoot() ?? Vector2.zero();
  }
}
