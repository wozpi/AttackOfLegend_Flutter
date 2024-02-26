import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

class Cannon extends PositionComponent {
  PositionComponent? _aimShooter;
  SpriteComponent? _bodyCannon;
  PositionComponent? _shooterPosition;
  int _directionShoot = 1;
  bool isGoingToAim = false;

  @override
  FutureOr<void> onLoad() async {
    priority = -5;
    Image imgWheelBack = await Flame.images.load("characters/hero/wheel.png");
    Vector2 originWheelBackSize = imgWheelBack.size / 10;
    add(SpriteComponent(sprite: Sprite(imgWheelBack))
      ..anchor = Anchor.center
      ..priority = -1
      ..position = Vector2(2, 0.8)
      ..size = Vector2(4, 4 * originWheelBackSize.y / originWheelBackSize.x));

    _aimShooter = PositionComponent();
    add(_aimShooter!);

    Image imgBodyCannon = await Flame.images.load("characters/hero/cannon.png");
    Vector2 originBodyCannonSize = imgBodyCannon.size / 10;
    _bodyCannon = SpriteComponent(sprite: Sprite(imgBodyCannon))
      ..anchor = const Anchor(0.1, 0.37)
      ..position = Vector2(-0.3, 0)
      ..size =
          Vector2(5.5, 6 * originBodyCannonSize.y / originBodyCannonSize.x);
    _aimShooter?.add(_bodyCannon!);

    Image imgWheelFront = await Flame.images.load("characters/hero/wheel.png");
    Vector2 originWheelFrontSize = imgWheelFront.size / 10;
    add(SpriteComponent(sprite: Sprite(imgWheelFront))
      ..anchor = Anchor.center
      ..priority = -1
      ..position = Vector2(-0.8, 0.8)
      ..size = Vector2(4, 4 * originWheelFrontSize.y / originWheelFrontSize.x));

    _shooterPosition = PositionComponent(position: Vector2(5, 0.6));
    _aimShooter?.add(_shooterPosition!);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isGoingToAim) {
      if (_aimShooter != null) {}

      if (_aimShooter!.angle > radians(0)) {
        _directionShoot = -1;
      } else {
        if (_aimShooter!.angle < -radians(80)) {
          _directionShoot = 1;
        }
      }
      _aimShooter?.angle += dt * 0.5 * _directionShoot;
    }
    super.update(dt);
  }

  double getAngleDegress() {
    return degrees(_aimShooter?.angle ?? 0.0);
  }

  void anim() {
    isGoingToAim = true;
  }

  void release() {
    isGoingToAim = false;
  }

  Vector2 getDirection() {
    if (_aimShooter != null && _shooterPosition != null) {
      return Vector2(cos(_aimShooter!.angle), sin(_aimShooter!.angle))
          .normalized();
    }
    return Vector2.zero();
  }

  Vector2 atShoot() {
    return _shooterPosition?.absolutePosition ?? Vector2.zero();
  }
}
