import 'dart:async';
import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/BounceObstruct.dart';
import '../components/Obstruct.dart';

class Level24 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(10, (canvasSize.y / 2) - 5)));
    add(BounceObstruct(
        atPosition: Vector2(35, (canvasSize.y - 10)),
        numberObstacle: 10,
        angleRoation: 0));

    add(Obstruct(
        atPosition: Vector2(3 * 6 / 2, (canvasSize.y / 2) + (3 * 6 / 2) + 2),
        numberObstacle: 6,
        angleRoation: pi / 2));
    super.onLoad();
  }
}
