import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class LegendButton extends SpriteComponent with TapCallbacks, HasGameRef {
  String path;
  String title;
  final VoidCallback onPressed;
  LegendButton(
      {required this.path, required this.title, required this.onPressed});

  @override
  FutureOr<void> onLoad() async {
    var iconButton = await Flame.images.load(path);

    sprite = Sprite(iconButton);
    size = Vector2(16, 16 * iconButton.height / iconButton.width);
    anchor = Anchor.center;

    add(TextComponent(text: title)
      ..anchor = Anchor.center
      ..position = Vector2(8, (size.y / 2))
      ..textRenderer = TextPaint(
          style: const TextStyle(
              color: Colors.white, fontSize: 2.35, fontFamily: 'SubTitle')));

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed();
    super.onTapUp(event);
  }
}
