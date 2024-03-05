import 'dart:async';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import '../components/LegendBackground.dart';
import '../components/LegendButton.dart';

class HomeScene extends Component with HasGameRef<LegendGameWidget> {
  final VoidCallback onPlay;
  final VoidCallback onLevel;
  HomeScene({required this.onPlay, required this.onLevel});
  double sizeTiles = 5;
  double sizeBackground = 45;
  @override
  FutureOr<void> onLoad() async {
    LegendBackground(
            parent: this,
            screenSize: gameRef.size / gameRef.camera.viewfinder.zoom)
        .onLoad();

    Vector2 gameWorldSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    var imgHeaderLeft = await Flame.images.load("home/Floor_left_mask.png");
    add(SpriteComponent(sprite: Sprite(imgHeaderLeft))
      ..size = Vector2(
          gameWorldSize.y * imgHeaderLeft.size.x / imgHeaderLeft.size.y,
          gameWorldSize.y)
      ..priority = 10);

    var imgHeaderRight = await Flame.images.load("home/Floor_right_mask.png");
    add(SpriteComponent(sprite: Sprite(imgHeaderRight))
      ..position = Vector2(gameWorldSize.x, 0)
      ..anchor = Anchor.topRight
      ..priority = 10
      ..size = Vector2(
          gameWorldSize.y * imgHeaderRight.size.x / imgHeaderRight.size.y,
          gameWorldSize.y));

    var imgBrandLogo = await Flame.images.load("home/img_brand.png");
    add(SpriteComponent(sprite: Sprite(imgBrandLogo))
      ..position = Vector2(gameRef.size.x / 20, 14)
      ..anchor = Anchor.center
      ..size = Vector2(15 * imgBrandLogo.size.x / imgBrandLogo.size.y, 15));

    add(LegendButton(
      path: 'hub/button_green.png',
      title: 'Play',
      onPressed: () {
        onPlay();
      },
    )..position = Vector2(gameRef.size.x / 20, (gameRef.size.y / 20) + 5));

    add(LegendIconButton(
        icon: 'levels/level_btn.png',
        onPressed: () {
          (gameRef.world as LegendWorld).enterLevelScene();
        })
      ..size = Vector2(6, 6 * (230 / 178))
      ..priority = 20
      ..position =
          Vector2(5, (gameRef.size.y / gameRef.camera.viewfinder.zoom) - 5));

    return super.onLoad();
  }
}
