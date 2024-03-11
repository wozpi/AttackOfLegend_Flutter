import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends SpriteComponent {
  Background({required this.atPosition});
  Vector2 atPosition;

  @override
  Future<void> onLoad() async {
    sprite =
        Sprite(Flame.images.fromCache('background/background_castles.png'));
    anchor = Anchor.center;
    position = atPosition;
    super.onLoad();
  }
}
