import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level05 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(atPosition: Vector2(60, 15)));

    initBat(Bat(
        atPosition: Vector2(
            30, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 15)));
    super.onLoad();
  }
}
