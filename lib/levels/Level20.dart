import 'dart:async';
import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/objects/Obstruct.dart';

class Level20 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(45, (canvasSize.y) / 2)));

    add(Obstruct(
        atPosition: Vector2(30, canvasSize.y - 5),
        numberObstacle: 5,
        angleRoation: 0));

    add(Obstruct(
        atPosition: Vector2(30, 15), numberObstacle: 5, angleRoation: pi));
    super.onLoad();
  }
}
