import 'dart:math';
import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/components/FlyerSprite.dart';
import 'package:attack_of_legend/components/MagicHat.dart';
import 'package:attack_of_legend/fx/ExploreFx.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';

class Flyer extends BodyComponent with ContactCallbacks {
  final Vector2 atPosition;
  final Vector2 withDirection;
  final double power;
  final VoidCallback onDead;
  final Function onAttackBat;
  bool isGoingToDead = false;
  double radius;
  Flyer(
      {required this.radius,
      required this.atPosition,
      required this.withDirection,
      required this.onDead,
      required this.onAttackBat,
      this.power = 1})
      : super(priority: 3, key: ComponentKey.unique());
  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.dynamic
      ..allowSleep = false
      ..bullet = true
      ..fixedRotation = false
      ..angularDamping = 1
      ..gravityScale = Vector2.all(3)
      ..position = atPosition;
    renderBody = false;
    final flyerBody = world.createBody(bodyDef);

    final shape = CircleShape()..radius = radius;

    debugMode = false;
    final fixtureDef = FixtureDef(shape)
      ..restitution = .2
      ..friction = 1
      ..density = 100;
    flyerBody.createFixture(fixtureDef);
    flyerBody.applyForce(withDirection * 20000 * max(1, power));
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
  void update(double dt) {
    if (position.x > game.size.x * 1.2 || position.y > game.size.y * 1.2) {
      onDead();
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void beginContact(Object other, Contact contact) async {
    if (other is Bat) {
      world.add(ExploreFx(pathFx: 'Bat_Fx')..position = other.position);
      onAttackBat(other);
      other.removeFromParent();
    } else {
      if (other != BlockMagicHat) {
        if (!isGoingToDead) {
          isGoingToDead = true;
          await Future.delayed(const Duration(seconds: 5));
          if (!isRemoved) {
            game.world.add(ExploreFx(pathFx: 'Flier')..position = position);
            onDead();
            removeFromParent();
          }
        }
      }
    }
    super.beginContact(other, contact);
  }
}
