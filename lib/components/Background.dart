import 'dart:math';

import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Background extends SpriteComponent {
  Background(
      {required this.atPosition, required this.width, required this.height});
  Vector2 atPosition;
  double width;
  double height;
  @override
  Future<void> onLoad() async {
    size = Vector2(width, height);
    sprite =
        Sprite(await Flame.images.load('background/background_castles.png'));
    anchor = Anchor.center;
    position = atPosition;
    return super.onLoad();
  }
}
