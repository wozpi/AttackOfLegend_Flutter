import 'dart:math';
import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/components/FlyerSprite.dart';
import 'package:attack_of_legend/fx/ExploreFx.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';

class Flyer extends BodyComponent with ContactCallbacks, CollisionCallbacks {
  final Vector2 atPosition;
  final Vector2 withDirection;
  final double power;
  final VoidCallback onDead;
  final VoidCallback onAttackBat;
  bool isGoingToDead = false;
  double radius;
  Flyer(
      {required this.radius,
      required this.atPosition,
      required this.withDirection,
      required this.onDead,
      required this.onAttackBat,
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
    // renderBody = false;
    final flyerBody = world.createBody(bodyDef);

    final shape = CircleShape()..radius = radius;

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
    add(FlyerSprite()
      ..position = Vector2(1, 1) * radius
      ..anchor = Anchor.center
      ..size = Vector2(1, 1) * radius * 2);

    return super.onLoad();
  }

  @override
  void beginContact(Object other, Contact contact) async {
    if (other is Bat) {
      world.add(ExploreFx(pathFx: 'Bat_Fx')..position = other.position);
      other.removeFromParent();
    } else {
      if (!isGoingToDead) {
        isGoingToDead = true;
        await Future.delayed(const Duration(seconds: 5));
        game.world.add(ExploreFx(pathFx: 'Flier')..position = position);
        removeFromParent();
      }
    }
    super.beginContact(other, contact);
  }
}