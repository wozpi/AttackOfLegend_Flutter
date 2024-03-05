import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Obstacle extends PositionComponent {
  int numberObstacle;
  double widthObstacle;
  String headerPath;
  String bodyPath;
  Obstacle(
      {required this.numberObstacle,
      required this.widthObstacle,
      required this.headerPath,
      required this.bodyPath});

  @override
  FutureOr<void> onLoad() async {
    var headerObstacle = await Flame.images.load(headerPath);
    var bodyObstacle = await Flame.images.load(bodyPath);

    for (var i = 0; i < numberObstacle; i++) {
      add(SpriteComponent(
          sprite: Sprite(i == 0 ? headerObstacle : bodyObstacle))
        ..size = Vector2.all(widthObstacle)
        ..anchor = Anchor.center
        ..priority = 0
        ..setAlpha(50)
        ..position = Vector2(
            0,
            ((-numberObstacle ~/ 2) * widthObstacle) +
                widthObstacle * i +
                (numberObstacle % 2 == 0 ? widthObstacle / 2 : 0)));
    }
    return super.onLoad();
  }
}
