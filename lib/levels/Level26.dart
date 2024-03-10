import 'dart:async';
import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';
import '../components/MagicHat.dart';
import '../components/Obstruct.dart';

class Level26 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(45, canvasSize.y - 8)));

    add(MagicHat(
        atPosition: Vector2(15, canvasSize.y - 11),
        positionConnect: Vector2(45, canvasSize.y - 13),
        onMoveFlyer: (Vector2 atPosition) {
          needCreatFlyer(atPosition);
        }));

    add(Obstruct(
        atPosition: Vector2(40, canvasSize.y - 5),
        numberObstacle: 5,
        angleRoation: 0));

    add(Obstruct(
        atPosition: Vector2(47, (canvasSize.y)),
        numberObstacle: 13,
        angleRoation: -pi / 2));
    super.onLoad();
  }
}
