import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/components/MagicHat1.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:flame/components.dart';

import '../components/MagicHat.dart';
import '../components/MagicHat2.dart';

class Level26 extends LegendLevel {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    initBat(Bat(
        atPosition: Vector2(
            ((gameRef.size.x / gameRef.camera.viewfinder.zoom) / 2) + 10,
            ((gameRef.size.y / gameRef.camera.viewfinder.zoom)) - 10)));

    var magicHat = MagicHat2(atPosition: Vector2(15, 30));
    add(magicHat);

    add(BodyMagicHat2(atPosition: Vector2(15, 30), anchorBody: magicHat));
  }
}
