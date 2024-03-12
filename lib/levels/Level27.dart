import 'dart:async';
import 'dart:math';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/objects/MagicHat.dart';
import '../components/objects/Obstruct.dart';

class Level27 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    Vector2 canvasSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    initBat(Bat(atPosition: Vector2(45, canvasSize.y - 10)));

    add(MagicHat(
        atPosition: Vector2(75, canvasSize.y - 11),
        positionConnect: Vector2(45, canvasSize.y - 15),
        onMoveFlyer: (Vector2 atPosition) {
          needCreatFlyer(atPosition);
        }));

    add(Obstruct(
        atPosition: Vector2(40, canvasSize.y - 5),
        numberObstacle: 5,
        angleRoation: 0));

    add(Obstruct(
        atPosition: Vector2(45, (canvasSize.y - 11)),
        numberObstacle: 7,
        angleRoation: -pi / 2));
    super.onLoad();
  }
}
