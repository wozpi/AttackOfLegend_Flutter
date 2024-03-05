import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Bat extends BodyComponent {
  bool isSmooth;
  double speedFly;
  List<Vector2>? pathMove;
  Vector2 atPosition;
  Bat(
      {required this.atPosition,
      this.pathMove,
      this.speedFly = 15,
      this.isSmooth = true});
  @override
  Body createBody() {
    bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.kinematic
      ..allowSleep = false
      ..fixedRotation = false
      ..angularDamping = 0
      ..gravityScale = Vector2(0, 0)
      ..position = atPosition;

    final flyerBody = world.createBody(bodyDef!);

    final shape = CircleShape()..radius = 1.1;

    final fixtureDef = FixtureDef(shape)
      ..restitution = .8
      ..friction = 0.5
      ..isSensor = true
      ..density = 0;
    flyerBody.createFixture(fixtureDef);
    flyerBody.applyForce(Vector2(1, -0.2) * 1000000);
    flyerBody.setAwake(true);
    flyerBody.userData = this;
    // renderBody = false;
    // add(MoveEffect.to(Vector2.all(10), EffectController(duration: 3)));

    return flyerBody;
  }

  @override
  Future<void> onLoad() async {
    // position = atPosition;
    add(BatBody());

    return super.onLoad();
  }

  int _indexMove = 0;
  int _directionMove = 1;
  // Vector2 _directionMove = Vector2.zero();
  @override
  void update(double dt) {
    if (pathMove != null) {
      if (isSmooth) {
        moveSmooth(dt);
      } else {
        moveSnap(dt);
      }
    }
    super.update(dt);
  }

  void moveSmooth(double dt) {
    if (_indexMove < pathMove!.length && _indexMove >= 0) {
      Vector2 direction = pathMove![_indexMove] - body.position;
      body.linearVelocity = direction.normalized() * 15;
      if (pathMove![_indexMove].distanceTo(body.position) < 0.5) {
        _indexMove += _directionMove;
      }
    } else {
      _directionMove *= -1;
      _indexMove += _directionMove;
    }
  }

  double timerDelay = 4;
  void moveSnap(double dt) {
    if (timerDelay > 2.5) {
      if (_indexMove < pathMove!.length && _indexMove >= 0) {
        Vector2 direction = pathMove![_indexMove] - body.position;
        body.linearVelocity = direction.normalized() * speedFly;
        if (pathMove![_indexMove].distanceTo(body.position) < 0.5) {
          timerDelay = 0;
          body.linearVelocity = Vector2.zero();

          _indexMove += _directionMove;
        }
      } else {
        _directionMove *= -1;
        _indexMove += _directionMove;
      }
    } else {
      timerDelay += dt;
    }
  }
}

class BatBody extends PositionComponent {
  @override
  FutureOr<void> onLoad() async {
    Image imgBody = await Flame.images.load("characters/bat/body_bat.png");
    SpriteComponent bodyComponent = SpriteComponent(sprite: Sprite(imgBody));
    bodyComponent.anchor = Anchor.center;
    bodyComponent.size = Vector2(2, 2 * imgBody.size.y / imgBody.size.x);
    add(bodyComponent);

    Image imgWingLeft =
        await Flame.images.load("characters/bat/fling_left_bat.png");
    SpriteComponent spriteWingLeftComponent =
        SpriteComponent(sprite: Sprite(imgWingLeft))
          ..anchor = const Anchor(1, 1)
          ..position = Vector2(-1, 0.18)
          ..angle = tau / 10
          ..size = Vector2(1, 1 * imgWingLeft.size.y / imgWingLeft.size.x);
    add(spriteWingLeftComponent);

    spriteWingLeftComponent.add(RotateEffect.to(
        tau / -4,
        EffectController(
            duration: 0.3,
            reverseDuration: .3,
            infinite: true,
            alternate: true)));

    Image imgWingRight =
        await Flame.images.load("characters/bat/fling_right_bat.png");
    SpriteComponent spriteWingRightComponent =
        SpriteComponent(sprite: Sprite(imgWingRight))
          ..anchor = Anchor.bottomLeft
          ..position = Vector2(1, 0.18)
          ..angle = -tau / 10
          ..size = Vector2(1, 1 * imgWingRight.size.y / imgWingRight.size.x);
    add(spriteWingRightComponent);
    spriteWingRightComponent.add(RotateEffect.to(
        tau / 4,
        EffectController(
            duration: 0.3,
            reverseDuration: .3,
            infinite: true,
            alternate: true)));

    Image imgLeagLeft = await Flame.images.load("characters/bat/leag_bat.png");
    SpriteComponent spriteLeagLeftComponent =
        SpriteComponent(sprite: Sprite(imgLeagLeft))
          ..position = Vector2(-0.35, 0.37)
          ..anchor = Anchor.topCenter
          ..size = Vector2(0.5, 0.5 * imgLeagLeft.size.y / imgLeagLeft.size.x);
    add(spriteLeagLeftComponent);

    spriteLeagLeftComponent.add(RotateEffect.to(
        -tau / 15,
        EffectController(
            duration: 3, reverseDuration: 3, infinite: true, alternate: true)));

    Image imgLeagRight = await Flame.images.load("characters/bat/leag_bat.png");
    SpriteComponent spriteLeagRightComponent = SpriteComponent(
        sprite: Sprite(imgLeagRight))
      ..position = Vector2(0.35, 0.37)
      ..anchor = Anchor.topCenter
      ..size = Vector2(0.5, 0.5 * imgLeagRight.size.y / imgLeagRight.size.x);
    add(spriteLeagRightComponent);

    spriteLeagRightComponent.add(RotateEffect.to(
        -tau / 8.5,
        EffectController(
            duration: 3, reverseDuration: 3, infinite: true, alternate: true)));

    Image imgEyeLeft =
        await Flame.images.load("characters/bat/eye_left_bat.png");
    SpriteComponent spriteEyeLeftComponent =
        SpriteComponent(sprite: Sprite(imgEyeLeft))
          ..size = Vector2(0.47, 0.47 * imgEyeLeft.size.y / imgEyeLeft.size.x)
          ..position = Vector2(-0.6, 0.26)
          ..anchor = Anchor.center;
    add(spriteEyeLeftComponent);

    Image imgEyeRight =
        await Flame.images.load("characters/bat/eye_right_bat.png");
    SpriteComponent spriteEyeRightComponent =
        SpriteComponent(sprite: Sprite(imgEyeRight))
          ..anchor = Anchor.center
          ..position = Vector2(0.46, 0.36)
          ..size = Vector2(0.5, 0.5 * imgEyeRight.size.y / imgEyeRight.size.x);

    add(spriteEyeRightComponent);
    add(RectangleHitbox(size: Vector2(3, 3)));
    return super.onLoad();
  }
}
