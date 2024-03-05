import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Tiles extends BodyComponent {
  Tiles({required this.atPosition, required this.size}) : super(priority: 5);
  Vector2 atPosition;
  double size;

  // Paint randomPaint() => PaintExtension.random(withAlpha: 0.9, base: 100);

  @override
  Body createBody() {
    final fixtureDef = FixtureDef(
        PolygonShape()..setAsBox(size / 2, size / 2, atPosition, 0),
        userData: this,
        restitution: 0,
        friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load('background/tiles.png')))
      ..size = Vector2(size * 1.01, size)
      ..anchor = Anchor.center
      ..position = atPosition);
    return super.onLoad();
  }
}
