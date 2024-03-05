import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level31 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    initBat(Bat(
        atPosition: Vector2(61, 10),
        pathMove: [
          Vector2(61, 10),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) - 10,
              (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 10),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) / 2) - 6),
          Vector2((gameRef.size.x / gameRef.camera.viewfinder.zoom) - 8,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) / 2) - 10)
        ],
        isSmooth: false,
        speedFly: 45));

    initBat(Bat(
        atPosition: Vector2(
            ((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 10,
            ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 10)));
  }
}
