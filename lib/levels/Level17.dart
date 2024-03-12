import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/objects/Obstruct.dart';

class Level17 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(
        atPosition: Vector2(61, 10),
        pathMove: [
          Vector2(61, 10),
          Vector2(canvasSize.x - 10, canvasSize.y - 10),
          Vector2(canvasSize.x / 2, (canvasSize.y / 2) - 6),
          Vector2(canvasSize.x / 2, 15),
          Vector2(canvasSize.x - 8, (canvasSize.y / 2) - 10)
        ],
        isSmooth: false,
        speedFly: 45));

    initBat(
        Bat(atPosition: Vector2((canvasSize.x / 2) + 10, (canvasSize.y) - 10)));

    add(Obstruct(
        atPosition: Vector2(30, canvasSize.y - 5),
        numberObstacle: 4,
        angleRoation: 0));
    super.onLoad();
  }
}
