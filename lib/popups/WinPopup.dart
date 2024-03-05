import 'dart:async';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../components/LegendButton.dart';
import '../components/LegendIconButton.dart';

class WinPopup extends PositionComponent
    with TapCallbacks, HasGameRef<LegendGameWidget> {
  final VoidCallback onRestart;
  final VoidCallback onGoHome;

  WinPopup({required this.onRestart, required this.onGoHome})
      : super(priority: 20);
  final _paint = Paint()..color = Colors.black54;

  @override
  FutureOr<void> onLoad() async {
    var imgBrandLogo = await Flame.images.load("popup/victory_logo.png");

    add(SpriteComponent(sprite: Sprite(imgBrandLogo))
      ..position = Vector2(gameRef.size.x / 20, 14)
      ..anchor = Anchor.center
      ..size = Vector2(8 * imgBrandLogo.size.x / imgBrandLogo.size.y, 8));

    add(TextComponent(text: "Ride from every fail")
      ..anchor = Anchor.center
      ..position = Vector2(gameRef.size.x / 20, 19)
      ..textRenderer = TextPaint(
          style: const TextStyle(
              color: Colors.white, fontSize: 2.5, fontFamily: 'SubTitle')));

    add(LegendIconButton(icon: 'popup/btn_retry.png', onPressed: () {})
      ..size = Vector2(5, 5)
      ..position =
          Vector2((gameRef.size.x / 20) - 6, (gameRef.size.y / 20) + 5));

    add(LegendButton(
      path: 'popup/btn_green.png',
      title: 'Home',
      onPressed: () {
        (gameRef.world as LegendWorld).enterNextPlayGameScene();
      },
    )..position =
        Vector2((gameRef.size.x / 20) + 6, (gameRef.size.y / 20) + 5));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTRB(0, 0, gameRef.size.x, gameRef.size.y), _paint);
    super.render(canvas);
  }
}
