import 'dart:async';

import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/BigBoss.dart';

class Level29 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    var bigBoss = (BigBoss(
      speedDefense: 4,
      atPosition: Vector2(
          ((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 10,
          ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 20),
    ));
    initBat(bigBoss);

    super.onLoad();
  }
}
