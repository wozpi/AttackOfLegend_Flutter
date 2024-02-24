import 'dart:math';

import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Background extends SpriteComponent {
  Background(
      {required this.atPosition, required this.width, required this.height});
  Vector2 atPosition;
  double width;
  double height;

  // Paint randomPaint() => PaintExtension.random(withAlpha: 0.9, base: 100);

  // @override
  // Body createBody() {
  //   final fixtureDef = FixtureDef(
  //       PolygonShape()..setAsBox(size / 2, size / 2, atPosition, 0),
  //       userData: this,
  //       friction: 0.3);
  //   final bodyDef = BodyDef(
  //     userData: this, // To be able to determine object in collision
  //     position: Vector2.zero(),
  //   );
  //   // paint.strokeWidth = 70;

  //   // debugMode = true;
  //   return world.createBody(bodyDef)..createFixture(fixtureDef);
  // }

  // @override
  // void renderCircle(Canvas canvas, Offset center, double radius) {
  //   super.renderCircle(canvas, center, radius);
  //   final lineRotation = Offset(0, radius);
  //   canvas.drawLine(center, center + lineRotation, _blue);
  // }

  @override
  Future<void> onLoad() async {
    size = Vector2(width, height);
    sprite =
        Sprite(await Flame.images.load('background/background_castles.png'));
    anchor = Anchor.center;
    position = atPosition;
    // add(SpriteComponent(
    //     sprite: Sprite(
    //         await Flame.images.load('background/background_castles.png')))
    //   // ..size = Vector2(10, 10)
    //   ..anchor = Anchor.center
    //   ..position = atPosition);
    return super.onLoad();
  }
}
