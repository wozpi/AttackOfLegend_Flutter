import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';

class ExploreFx extends PositionComponent {
  String pathFx;
  ExploreFx({required this.pathFx});
  @override
  FutureOr<void> onLoad() async {
    add(ParticleSystemComponent(
        particle: animationParticle(), scale: Vector2(1, 1))
      ..size = Vector2(1, 1));
    return super.onLoad();
  }

  SpriteAnimation getBoomAnimation() {
    const columns = 4;
    const rows = 2;
    const frames = columns * rows;
    final spriteImage = Flame.images.fromCache('fx/$pathFx.png');
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: spriteImage,
      columns: columns,
      rows: rows,
    );
    final sprites = List<Sprite>.generate(frames, spriteSheet.getSpriteById,
        growable: false);
    return SpriteAnimation.spriteList(sprites, stepTime: 0.1, loop: false);
  }

  Particle animationParticle() {
    return SpriteAnimationParticle(
      animation: getBoomAnimation(),
      size: Vector2(3.5, 3.5),
    );
  }
}
