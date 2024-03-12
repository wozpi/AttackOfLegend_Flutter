import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/components/objects/Obstruct.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level15 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;

    initBat(
        Bat(atPosition: Vector2((canvasSize.x / 2) + 10, (canvasSize.y) - 10)));

    add(Obstruct(
        atPosition: Vector2(30, canvasSize.y - 5),
        numberObstacle: 4,
        angleRoation: 0));
    super.onLoad();
  }
}
