import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class LegendIconButton extends SpriteComponent with TapCallbacks, HasGameRef {
  final VoidCallback onPressed;
  final String icon;

  LegendIconButton({required this.icon, required this.onPressed});

  @override
  FutureOr<void> onLoad() async {
    var iconButton = await Flame.images.load(icon);
    sprite = Sprite(iconButton);

    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed();
    super.onTapUp(event);
  }
}
