import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level13 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(
        atPosition: Vector2(30, 20),
        pathMove: [
          Vector2(70, 25),
          Vector2(50, 21),
          Vector2(45, 7),
          Vector2(70, 21),
          Vector2(50, 21),
          Vector2(30, -13),
          Vector2(90, 23),
        ],
        isSmooth: true,
        speedFly: 25));

    initBat(Bat(
        atPosition: Vector2(30, 25),
        pathMove: [
          Vector2(30, 25),
          Vector2(50, 11),
          Vector2(40, 26),
          Vector2(70, 24),
          Vector2(90, 21),
          Vector2(30, 13),
          Vector2(20, -15),
          Vector2(80, 23),
        ],
        isSmooth: true,
        speedFly: 25));

    initBat(Bat(
        atPosition: Vector2(
            ((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 14,
            ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 12)));
    super.onLoad();
  }
}
