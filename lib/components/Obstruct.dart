import 'dart:async';
import 'package:attack_of_legend/components/Obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Obstruct extends BodyComponent {
  Vector2 atPosition;
  int numberObstacle;
  double width;
  double angleRoation;
  Obstruct(
      {required this.atPosition,
      required this.numberObstacle,
      this.width = 3,
      this.angleRoation = 0});
  @override
  Body createBody() {
    double halfWidth = width / 2;
    final fixtureDef = FixtureDef(
        PolygonShape()
          ..setAsBox(halfWidth, halfWidth * numberObstacle,
              Vector2(atPosition.x, atPosition.y), angleRoation),
        userData: this,
        density: 0,
        restitution: 0,
        friction: 1);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2(0, -halfWidth * numberObstacle),
    );
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    add(Obstacle(
        numberObstacle: numberObstacle,
        widthObstacle: width,
        headerPath: 'environment/tileBlue_header.png',
        bodyPath: 'environment/tileBlue_body.png')
      ..anchor = Anchor.center
      ..angle = angleRoation
      ..position = atPosition);
    return super.onLoad();
  }
}
