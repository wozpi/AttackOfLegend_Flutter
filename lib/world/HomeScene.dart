import 'dart:async';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../components/Background.dart';
import '../components/LegendButton.dart';
import '../components/Tiles.dart';

class HomeScene extends Component with HasGameRef<LegendGameWidget> {
  double sizeTiles = 5;
  double sizeBackground = 45;
  @override
  FutureOr<void> onLoad() async {
    double offsetY = gameRef.size.y / gameRef.camera.viewfinder.zoom;
    // Add ground
    for (var i = 0; i < 20; i++) {
      add(Background(
          atPosition: Vector2(i * sizeBackground, offsetY - sizeBackground / 2),
          width: sizeBackground * 1.01,
          height: sizeBackground));
    }
    // Add ground
    for (var i = 0; i < 20; i++) {
      add(Tiles(
          atPosition: Vector2(i * sizeTiles, offsetY - sizeTiles / 2),
          size: sizeTiles));
    }

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
        (gameRef.world as LegendWorld).enterPlayGameScene();
      },
    )..position = Vector2(gameRef.size.x / 20, (gameRef.size.y / 20) + 5));

    return super.onLoad();
  }
}
