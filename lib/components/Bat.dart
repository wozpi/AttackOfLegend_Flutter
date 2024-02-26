import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Bat extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.static
      ..allowSleep = false
      ..fixedRotation = false
      ..angularDamping = 1
      ..gravityScale = Vector2(1, 1)
      ..position = Vector2(10, 23);

    final flyerBody = world.createBody(bodyDef);

    final shape = CircleShape()..radius = 1;

    final fixtureDef = FixtureDef(shape)
      ..restitution = .8
      ..friction = 0.5
      ..isSensor = true
      ..density = 0;
    flyerBody.createFixture(fixtureDef);
    flyerBody.applyForce(Vector2(1, -0.2) * 1000000);
    flyerBody.setAwake(true);
    flyerBody.userData = this;
    renderBody = false;
    return flyerBody;
  }

  @override
  Future<void> onLoad() async {
    add(BatBody());
    return super.onLoad();
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

    return super.onLoad();
  }
}
