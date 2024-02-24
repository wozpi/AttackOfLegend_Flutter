import 'dart:async';

import 'package:attack_of_legend/components/Tiles.dart';
import 'package:flame/components.dart';

class Ground extends PositionComponent with HasGameRef {
  double sizeTiles = 7;
  @override
  FutureOr<void> onLoad() {
    for (var i = 0; i < 20; i++) {
      game.world
          .add(Tiles(atPosition: Vector2(i * sizeTiles, 0), size: sizeTiles));
    }

    // debugMode = true;
    return super.onLoad();
  }
}
