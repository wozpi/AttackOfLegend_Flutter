import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level09 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    initBat(Bat(
        atPosition: Vector2(40, 10),
        pathMove: [
          Vector2(40, 10),
          Vector2(50, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 10),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) - 10,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) / 2) - 6)
        ],
        isSmooth: false,
        speedFly: 45));
    super.onLoad();
  }
}
