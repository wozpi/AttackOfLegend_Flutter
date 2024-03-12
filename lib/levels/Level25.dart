import 'dart:async';
import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/objects/BounceObstruct.dart';
import '../components/objects/Obstruct.dart';

class Level25 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(10, (canvasSize.y / 2) - 4)));
    add(BounceObstruct(
        atPosition: Vector2(35, (canvasSize.y / 2)),
        numberObstacle: 7,
        speedRotation: 0.7));

    add(Obstruct(
        atPosition: Vector2(3 * 4 / 2, (canvasSize.y / 2) + (3 * 4 / 2) + 2),
        numberObstacle: 4,
        angleRoation: pi / 2));
    super.onLoad();
  }
}
