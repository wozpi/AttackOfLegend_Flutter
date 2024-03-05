import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class MagicHat extends BodyComponent {
  MagicHat({required this.atPosition}) : super(priority: 4);
  Vector2 atPosition;
  FixtureDef? _fixtureDef;
  @override
  Body createBody() {
    final shape = PolygonShape()
      ..set([
        Vector2(0.3, 0.3),
        Vector2(1.5, 0.8),
        Vector2(1.5, 4),
        Vector2(5.5, 4),
        Vector2(5.5, 0.8),
        Vector2(2.5, -4),
        // Vector2(6.8, 0.3),
        // Vector2(2.5, 0.9)
      ]);
    _fixtureDef = FixtureDef(shape,
        userData: this, density: 0, restitution: 0, friction: 0);
    bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: atPosition,
    )..type = BodyType.kinematic;

    return world.createBody(bodyDef!)..createFixture(_fixtureDef!);
  }

  @override
  void onMount() {
    _fixtureDef?.isSensor = false;
    print("fixtureDe!f: $_fixtureDef");

    super.onMount();
  }

  @override
  void update(double dt) {
    bodyDef?.position = Vector2(1, 0) * dt * 3;
    children.query<BlockMagicHat>().forEach((element) {
      element.moveSmooth(dt);
    });
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    _fixtureDef?.isSensor = false;
    print("fixtureDef: $_fixtureDef");
    bodyDef?.position = Vector2.zero();
    var imgBodyHat = await Flame.images.load("environment/body_hat.png");
    var radioBody = imgBodyHat.height / imgBodyHat.width;
    var bodyHat = SpriteComponent(sprite: Sprite(imgBodyHat))
      ..size = Vector2(7, 7 * radioBody)
      ..priority = -4
      ..setAlpha(0);
    add(bodyHat);

    var imgHeaderHat = await Flame.images.load("environment/header_hat.png");
    var radioHeader = imgHeaderHat.height / imgHeaderHat.width;
    var headerHat = SpriteComponent(sprite: Sprite(imgHeaderHat))
      ..size = Vector2(7, 7 * radioHeader)
      ..priority = 4
      ..setAlpha(0);
    add(headerHat);

    add(BlockMagicHat(
        atStart: Vector2(0.3, 0.3),
        atEnd: Vector2(1.5, 0.8),
        atPosition: Vector2(15, 30)));

    add(BlockMagicHat(
        atStart: Vector2(1.5, 0.8),
        atEnd: Vector2(1.5, 4),
        atPosition: Vector2(15, 30)));

    add(BlockMagicHat(
        atStart: Vector2(1.5, 4),
        atEnd: Vector2(5.5, 4),
        atPosition: Vector2(15, 30)));

    add(BlockMagicHat(
        atStart: Vector2(5.5, 4),
        atEnd: Vector2(5.5, 0.8),
        atPosition: Vector2(15, 30)));

    add(BlockMagicHat(
        atStart: Vector2(5.5, 0.8),
        atEnd: Vector2(6.8, 0.3),
        atPosition: Vector2(15, 30)));

    return super.onLoad();
  }
}

class BlockMagicHat extends BodyComponent {
  Vector2 atStart;
  Vector2 atEnd;
  Vector2 atPosition;
  BlockMagicHat(
      {required this.atStart, required this.atEnd, required this.atPosition});
  void moveSmooth(double dt) {
    bodyDef?.linearVelocity = Vector2(1, 0) * 2;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsEdge(atStart, atEnd);
    final fixtureDef = FixtureDef(shape,
        userData: this, density: 0, restitution: 0, friction: 0);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: atPosition,
    )..type = BodyType.kinematic;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawLine(
        // Offset(atStart.x - atPosition.x, atStart.x - atPosition.y),
        // Offset(atEnd.x - atPosition.x, atEnd.x - atPosition.y),
        Offset(atStart.x + atPosition.x, atStart.y + atPosition.y),
        Offset(atEnd.x, atEnd.y),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 0.1);

    super.render(canvas);
  }
}
