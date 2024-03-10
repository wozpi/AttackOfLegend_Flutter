import 'dart:async';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../components/LegendButton.dart';
import '../components/LegendIconButton.dart';

class DefeatPopup extends PositionComponent with HasGameRef<LegendGameWidget> {
  final VoidCallback onRestart;
  final VoidCallback onGoHome;

  DefeatPopup({required this.onRestart, required this.onGoHome})
      : super(priority: 50);
  final _paint = Paint()..color = Colors.black54;

  @override
  FutureOr<void> onLoad() async {
    var imgBrandLogo = await Flame.images.load("popup/defeat_logo.png");

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

    add(LegendIconButton(
        icon: 'popup/btn_retry.png',
        onPressed: () {
          onRestart();
          removeFromParent();
        })
      ..size = Vector2(5, 5)
      ..position =
          Vector2((gameRef.size.x / 20) - 6, (gameRef.size.y / 20) + 5));

    add(LegendButton(
      path: 'popup/orange_btn.png',
      title: 'Home',
      onPressed: () {
        onGoHome();
      },
    )..position =
        Vector2((gameRef.size.x / 20) + 6, (gameRef.size.y / 20) + 5));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y), _paint);
    super.render(canvas);
  }
}
