import 'dart:async';

import 'package:attack_of_legend/components/FlyerSprite.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class FrameFlier extends PositionComponent {
  TextComponent? _textNumberFlier;
  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
        sprite:
            Sprite(await Flame.images.load("hub/bg_container_highlight.png")))
      ..size = Vector2(6, 6)
      ..anchor = Anchor.topLeft);

    add(FlyerSprite()
      ..position = Vector2(2.9, 2.6)
      ..size = Vector2(3.5, 3.5)
      ..anchor = Anchor.topLeft
      ..flipHorizontally());

    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load("hub/bg_points.png")))
      ..size = Vector2(2.3, 2.3)
      ..position = Vector2(3, 3)
      ..anchor = Anchor.topLeft);

    _textNumberFlier = TextComponent(text: "5")
      ..anchor = Anchor.center
      ..position = Vector2(4.2, 3.9)
      ..textRenderer = TextPaint(
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.white,
              fontSize: 1.8,
              fontFamily: 'SubTitle'));
    add(_textNumberFlier!);
    return super.onLoad();
  }

  void updateNumberFlier(int count) {
    _textNumberFlier?.text = count.toString();
  }
}
