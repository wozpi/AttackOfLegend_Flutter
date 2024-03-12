import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../components/objects/Obstruct.dart';

class Level19 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(
        atPosition: Vector2(61, 10),
        pathMove: [
          Vector2(61, 10),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) - 10,
              (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 10),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) / 2) - 6),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) - 8,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) / 2) - 10)
        ],
        isSmooth: true,
        speedFly: 25));

    initBat(Bat(atPosition: Vector2(35, (canvasSize.y) - 10)));

    add(Obstruct(
        atPosition: Vector2(30, canvasSize.y - 5),
        numberObstacle: 4,
        angleRoation: 0));
    super.onLoad();
  }
}
