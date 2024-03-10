import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BigBoss extends Bat {
  Vector2 atPosition;
  BigBoss({required this.atPosition}) : super(atPosition: atPosition);
  // @override
  // Body createBody() {
  //   bodyDef = BodyDef()
  //     ..userData = this
  //     ..type = BodyType.kinematic
  //     ..allowSleep = false
  //     ..fixedRotation = false
  //     ..angularDamping = 0
  //     ..gravityScale = Vector2(0, 0)
  //     ..position = atPosition;

  //   final flyerBody = world.createBody(bodyDef!);

  //   final shape = CircleShape()..radius = 1.1;

  //   final fixtureDef = FixtureDef(shape)
  //     ..restitution = .8
  //     ..friction = 0.5
  //     ..isSensor = true
  //     ..density = 0;
  //   flyerBody.createFixture(fixtureDef);
  //   flyerBody.applyForce(Vector2(1, -0.2) * 1000000);
  //   flyerBody.setAwake(true);
  //   flyerBody.userData = this;
  //   renderBody = false;

  //   return flyerBody;
  // }

  // @override
  // Future<void> onLoad() {
  //   add(BatBody());

  //   return super.onLoad();
  // }

  @override
  void onMount() {
    add(CircleShuffler(body));
    print('add ne');
    super.onMount();
  }
}

class CircleShuffler extends BodyComponent {
  final Body bossBody;

  CircleShuffler(this.bossBody);

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: bossBody.position.clone(),
    );
    const numPieces = 5;
    const radius = 6.0;
    final body = world.createBody(bodyDef);

    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));

      final shape = CircleShape()
        ..radius = 1.2
        ..position.setValues(xPos, yPos);

      final fixtureDef = FixtureDef(
        shape,
        density: 50.0,
        friction: 0.1,
        restitution: 0.9,
      );

      body.createFixture(fixtureDef);
    }

    final jointDef = RevoluteJointDef()
      ..initialize(body, bossBody, body.position);
    world.createJoint(RevoluteJoint(jointDef));

    return body;
  }
}
