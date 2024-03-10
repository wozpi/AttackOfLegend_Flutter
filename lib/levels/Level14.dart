import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level14 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(
        atPosition: Vector2(90, 15),
        pathMove: [
          Vector2(90, 15),
          Vector2(30, 11),
          Vector2(25, 23),
          Vector2(70, 21),
          Vector2(50, 15),
          Vector2(70, 13),
          Vector2(90, 23),
        ],
        isSmooth: true,
        speedFly: 20));

    initBat(Bat(
        atPosition: Vector2(25, 25),
        pathMove: [
          Vector2(25, 25),
          Vector2(20, 11),
          Vector2(40, 26),
          Vector2(70, 24),
          Vector2(90, 21),
          Vector2(45, 13),
          Vector2(20, -15),
          Vector2(70, 10),
        ],
        isSmooth: true,
        speedFly: 20));

    initBat(Bat(
        atPosition: Vector2(15, 25),
        pathMove: [
          Vector2(15, 25),
          Vector2(25, 20),
          Vector2(23, 20),
          Vector2(70, 30),
          Vector2(40, 21),
          Vector2(90, 24),
          Vector2(40, 5),
          Vector2(80, 10),
        ],
        isSmooth: true,
        speedFly: 20));
    super.onLoad();
  }
}
