import 'dart:async';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/BigBoss.dart';

class Level30 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    var bigBoss = (BigBoss(
        atPosition: Vector2(
            ((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 10,
            ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 15),
        pathMove: [
          Vector2(((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 10,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 15),
          Vector2(((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 12,
              ((gameRef.size.y / gameRef.camera.viewfinder.zoom) - 20)),
        ]));
    initBat(bigBoss);

    initBat(BigBoss(
      atPosition:
          Vector2(((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2), 10),
    ));
    super.onLoad();
  }
}
