import 'dart:async';
import 'package:attack_of_legend/components/Obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BounceObstruct extends BodyComponent {
  Vector2 atPosition;
  int numberObstacle;
  double width;
  double angleRoation;
  double speedRotation;
  Obstacle? _obstacle;
  BounceObstruct(
      {required this.atPosition,
      required this.numberObstacle,
      this.width = 3,
      this.angleRoation = 0,
      this.speedRotation = 0});
  @override
  Body createBody() {
    double halfWidth = width / 2;
    final shape = PolygonShape()
      ..setAsBox(
          halfWidth, halfWidth * numberObstacle, Vector2.zero(), angleRoation);
    final fixtureDef = FixtureDef(shape,
        userData: this, density: 0, restitution: 1, friction: 0);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: atPosition,
    )..type = BodyType.kinematic;
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    _obstacle = Obstacle(
        numberObstacle: numberObstacle,
        widthObstacle: width,
        headerPath: 'environment/tileBounce.png',
        bodyPath: 'environment/tileBounce.png')
      ..anchor = Anchor.center
      ..position = Vector2.zero()
      ..angle = angleRoation;
    add(_obstacle!);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    body.angularVelocity = speedRotation;
    super.update(dt);
  }
}
