import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level11 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(
        atPosition: Vector2(40, 20),
        pathMove: [Vector2(40, 20), Vector2(90, 25), Vector2(60, 21)],
        isSmooth: true,
        speedFly: 15));
    super.onLoad();
  }
}
