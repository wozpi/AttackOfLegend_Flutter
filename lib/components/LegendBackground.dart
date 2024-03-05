import 'package:attack_of_legend/components/Background.dart';
import 'package:attack_of_legend/components/Tiles.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart' as forge_2d;
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LegendBackground {
  double sizeTiles = 5;
  double sizeBackground = 45;
  Component parent;
  Vector2 screenSize;
  LegendBackground({required this.parent, required this.screenSize});

  void onLoad() {
    // final boundaries = createBoundaries(gameRef);
    // addAll(boundaries);
    // Add ground
    for (var i = 0; i < 20; i++) {
      parent.add(Background(
          atPosition:
              Vector2(i * sizeBackground, screenSize.y - sizeBackground / 2))
        ..size = Vector2.all(sizeBackground));
    }
    // Add ground
    for (var i = 0; i < 20; i++) {
      parent.add(Tiles(
          atPosition: Vector2(i * sizeTiles, screenSize.y - sizeTiles / 2),
          size: sizeTiles));
    }
  }
}

List<Wall> createBoundaries(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();
  final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomLeft = visibleRect.bottomLeft.toVector2();

  return [
    Wall(topLeft, topRight, strokeWidth: strokeWidth),
    Wall(topRight, bottomRight, strokeWidth: strokeWidth),
    Wall(bottomLeft, bottomRight, strokeWidth: strokeWidth),
    Wall(topLeft, bottomLeft, strokeWidth: strokeWidth),
  ];
}

class Wall extends forge_2d.BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;

  Wall(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  forge_2d.Body createBody() {
    final shape = forge_2d.EdgeShape()..set(start, end);
    final fixtureDef = forge_2d.FixtureDef(shape, friction: 1, density: 40000);
    final bodyDef = forge_2d.BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;

    // debugMode = true;
    debugColor = Colors.yellow;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
