import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

class Level03 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    initBat(Bat(atPosition: Vector2(50, 14)));
  }
}
