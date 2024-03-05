import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class MagicHat1 extends PositionComponent {
  MagicHat1() : super(priority: 4);
  @override
  FutureOr<void> onLoad() async {
    var imgBodyHat = await Flame.images.load("environment/body_hat.png");
    var radioBody = imgBodyHat.height / imgBodyHat.width;
    var bodyHat = SpriteComponent(sprite: Sprite(imgBodyHat))
      ..size = Vector2(7, 7 * radioBody)
      ..priority = -4
      ..setAlpha(255);
    add(bodyHat);

    var imgHeaderHat = await Flame.images.load("environment/header_hat.png");
    var radioHeader = imgHeaderHat.height / imgHeaderHat.width;
    var headerHat = SpriteComponent(sprite: Sprite(imgHeaderHat))
      ..size = Vector2(7, 7 * radioHeader)
      ..priority = 4
      ..setAlpha(255);
    add(headerHat);

    add(BlockMagicHat(
        atStart: Vector2(0.3, 0.3),
        atEnd: Vector2(1.5, 0.8),
        atPosition: Vector2(15, 30),
        anchorComponent: this));

    add(BlockMagicHat(
        atStart: Vector2(1.5, 0.8),
        atEnd: Vector2(1.5, 4),
        atPosition: Vector2(15, 30),
        anchorComponent: this));

    add(BlockMagicHat(
        atStart: Vector2(1.5, 4),
        atEnd: Vector2(5.5, 4),
        atPosition: Vector2(15, 30),
        anchorComponent: this));

    add(BlockMagicHat(
        atStart: Vector2(5.5, 4),
        atEnd: Vector2(5.5, 0.8),
        atPosition: Vector2(15, 30),
        anchorComponent: this));

    add(BlockMagicHat(
        atStart: Vector2(5.5, 0.8),
        atEnd: Vector2(6.8, 0.3),
        atPosition: Vector2(15, 30),
        anchorComponent: this));

    add(MoveAlongPathEffect(
        Path()
          ..lineTo(15, 0)
          ..lineTo(45, 0),
        EffectController(
          duration: 4,
          reverseDuration: 4,
          infinite: true,
        )));
    return super.onLoad();
  }
}

class BlockMagicHat extends BodyComponent {
  Vector2 atStart;
  Vector2 atEnd;
  Vector2 atPosition;
  PositionComponent anchorComponent;
  BlockMagicHat(
      {required this.atStart,
      required this.atEnd,
      required this.atPosition,
      required this.anchorComponent});
  @override
  Body createBody() {
    final shape = PolygonShape()..setAsEdge(atStart, atEnd);
    final fixtureDef = FixtureDef(shape,
        userData: this, density: 0, restitution: 0, friction: 0);
    bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: atPosition,
    )..type = BodyType.kinematic;
    return world.createBody(bodyDef!)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    bodyDef?.position = anchorComponent.position;
    super.update(dt);
  }
}
