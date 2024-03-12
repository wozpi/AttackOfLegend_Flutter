import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/objects/Obstruct.dart';

class Level16 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(61, 10)));

    initBat(
        Bat(atPosition: Vector2((canvasSize.x / 2) + 10, (canvasSize.y) - 10)));

    add(Obstruct(
        atPosition: Vector2(25, canvasSize.y - 5),
        numberObstacle: 3,
        angleRoation: 0));
    super.onLoad();
  }
}
