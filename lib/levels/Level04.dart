import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level04 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(
        atPosition: Vector2(
            50, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 10)));

    super.onLoad();
  }
}
