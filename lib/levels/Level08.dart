import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level08 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    initBat(Bat(
        atPosition: Vector2(
            30, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 13)));

    initBat(Bat(atPosition: Vector2(45, 20)));

    initBat(Bat(
        atPosition: Vector2(
            60, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 10)));

    initBat(Bat(atPosition: Vector2(75, 15)));
  }
}
