import 'package:attack_of_legend/components/Background.dart';
import 'package:attack_of_legend/components/Tiles.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'SkyComponent.dart';

class LegendBackground {
  double sizeTiles = 5;
  double sizeBackground = 45;
  Component parent;
  Vector2 screenSize;
  LegendBackground({required this.parent, required this.screenSize});

  void onLoad() {
    for (var i = 0; i < 20; i++) {
      parent.add(Background(
          atPosition:
              Vector2(i * sizeBackground, screenSize.y - sizeBackground / 2))
        ..size = Vector2.all(sizeBackground)
        ..paint = Paint());
    }
    // Add ground
    for (var i = 0; i < 20; i++) {
      parent.add(Tiles(
          atPosition: Vector2(i * sizeTiles, screenSize.y - sizeTiles / 2),
          size: sizeTiles));
    }
    parent.add(SkyComponent());
  }
}
