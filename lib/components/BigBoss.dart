import 'dart:math';
import 'dart:ui';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart' as material;

class BigBoss extends Bat {
  Vector2 atPosition;
  List<Vector2>? pathMove;
  double speedDefense;
  BigBoss({required this.atPosition, this.speedDefense = 6, this.pathMove})
      : super(
            atPosition: atPosition,
            pathMove: pathMove,
            speedFly: 5,
            scaleUp: 2);

  @override
  void onMount() {
    _projectionShel =
        CircleShuffler(speedDefense: speedDefense, bossBody: body);
    parent?.add(_projectionShel);
    super.onMount();
  }

  late CircleShuffler _projectionShel;
  @override
  void onDead() {
    _projectionShel.dead();
    super.onDead();
  }
}

class CircleShuffler extends BodyComponent with ContactCallbacks {
  final Body bossBody;
  late final Paint _shaderPaint;
  double speedDefense;
  CircleShuffler({required this.speedDefense, required this.bossBody});
  double radiusBall = 1.7;
  int numPieces = 5;
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.kinematic,
      position: bossBody.position.clone(),
    );

    const radius = 6.0;

    final body = world.createBody(bodyDef);
    body.angularVelocity = speedDefense;
    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));

      final shape = CircleShape()
        ..radius = radiusBall
        ..position.setValues(xPos, yPos);

      final fixtureDef = FixtureDef(
        shape,
        density: 0.0,
        friction: 0,
        restitution: 0,
      );

      body.createFixture(fixtureDef);
    }

    final jointDef = RevoluteJointDef()
      ..initialize(body, bossBody, body.position);
    world.createJoint(RevoluteJoint(jointDef));
    renderBody = false;

    return body;
  }

  var angleDirection = pi / 4;
  @override
  void render(Canvas canvas) {
    const radius = 6.0;
    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));
      if (!isDead) {
        canvas.drawCircle(Offset(xPos, yPos), radiusBall, _shaderPaint);
        canvas.drawCircle(
            Offset(xPos + sin(angleDirection), yPos + cos(angleDirection)),
            radiusBall * 0.55 * cos(angleDirection),
            _shaderPaint);
      }
    }
    if (isDead) {
      body.setActive(false);
      if (angleDirection > -pi / 2) {
        for (var i = 0; i < numPieces; i++) {
          final xPos = radius * cos(2 * pi * (i / (numPieces)));
          final yPos = radius * sin(2 * pi * (i / (numPieces)));

          canvas.drawCircle(
              Offset(xPos / cos(angleDirection), yPos / cos(angleDirection)),
              radiusBall * 0.4 * cos(angleDirection),
              _shaderPaint);
        }
      } else {
        removeFromParent();
      }
    }
    if (isDead) {
      angleDirection -= 0.04;
    }
  }

  bool isDead = false;
  void dead() {
    isDead = true;
  }

  @override
  Future<void> onLoad() async {
    _shaderPaint = Paint()
      ..color = material.Colors.green
      ..shader = Gradient.radial(
        Offset.zero,
        radiusBall,
        [
          material.Colors.green,
          BasicPalette.black.color,
        ],
        null,
        TileMode.clamp,
        null,
        Offset(radiusBall / 2, radiusBall / 2),
      );

    const radius = 6.0;
    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));
      add(SpriteComponent(
          sprite: Sprite(await Flame.images.load('characters/bat/Clan.png')))
        ..position = Vector2(xPos, yPos)
        ..anchor = Anchor.center
        ..size = Vector2(1.7, 1.7));
    }

    return super.onLoad();
  }
}
