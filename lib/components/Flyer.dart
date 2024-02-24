import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/main.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Flyer extends BodyComponent with ContactCallbacks, CollisionCallbacks {
  final Vector2 atPosition;
  final Vector2 withDirection;
  final double power;
  double radius;
  Flyer(
      {required this.radius,
      required this.atPosition,
      required this.withDirection,
      this.power = 1});
  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.dynamic
      ..allowSleep = false
      ..fixedRotation = false
      ..angularDamping = 1
      ..gravityScale = Vector2(1, 1)
      ..position = atPosition;

    final flyerBody = world.createBody(bodyDef);

    final shape = CircleShape()..radius = radius * 2;

    debugMode = false;
    final fixtureDef = FixtureDef(shape)
      ..restitution = .2
      ..friction = 1
      ..density = 100;
    flyerBody.createFixture(fixtureDef);
    flyerBody.applyForce(withDirection * 100000 * max(1, power));
    flyerBody.setAwake(true);
    flyerBody.userData = this;
    return flyerBody;
  }

  @override
  Future<void> onLoad() async {
    // game.word.add();
    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load("characters/flier.png")))
      ..anchor = Anchor.center
      ..size = Vector2(1, 1) * radius * 2);

    return super.onLoad();
  }

  @override
  void beginContact(Object other, Contact contact) {
    // if (co)
    // print("beginContact ?????????: ${other}");
    // _sprite?.scale = Vector2(3, 3);
    if (other is Bat) {
      other.removeFromParent();
    }
    super.beginContact(other, contact);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("object");
    super.onCollision(intersectionPoints, other);
  }
}
