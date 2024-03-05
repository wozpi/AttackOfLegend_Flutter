import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class LevelMetal extends SpriteComponent with TapCallbacks {
  double maxWith;
  int? level;
  final Function onPressed;
  LevelMetal({required this.maxWith, required this.onPressed, this.level});

  @override
  FutureOr<void> onLoad() async {
    var iconButton = await Flame.images.load(
        level == null ? 'levels/metal_gray.png' : 'levels/metal_blue.png');
    sprite = Sprite(iconButton);
    size = Vector2(maxWith, maxWith * iconButton.height / iconButton.width);
    anchor = Anchor.centerLeft;

    if (level == null) {
      double sizeBat = max(size.x, size.y) * 0.5;
      var iconHintBat = await Flame.images.load('levels/bat_hint.png');
      add(SpriteComponent(sprite: Sprite(iconHintBat))
        ..position = size / 2
        ..size =
            Vector2(sizeBat, sizeBat * iconHintBat.height / iconHintBat.width)
        ..anchor = Anchor.center);
    } else {
      add(TextComponent(
        anchor: Anchor.center,
        text: _getFormatLevel(level!),
        // anchor: Anchor.center,
        textRenderer: TextPaint(
            style: const TextStyle(
          color: Colors.white,
          fontSize: 2.5,
          fontFamily: 'SubTitle',
        )),
      )
        ..position = Vector2(size.x / 2, (size.y / 2) - 0.5)
        ..anchor = Anchor.center);
    }

    return super.onLoad();
  }

  String _getFormatLevel(int level) {
    if (level > 9) {
      return level.toString();
    } else {
      return '0$level';
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed(level);
    super.onTapUp(event);
  }
}
