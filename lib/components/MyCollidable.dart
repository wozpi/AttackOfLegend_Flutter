import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyCollidable extends PositionComponent
    with HasGameReference<LegendGameWidget>, CollisionCallbacks {
  MyCollidable({super.position})
      : super(size: Vector2.all(30), anchor: Anchor.center);

  late Vector2 velocity;
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    velocity = -position
      ..scaleTo(50);
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   position.add(velocity * dt);
  // }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    hitbox.paint.color = _collisionColor;
    if (other is ScreenHitbox) {
      removeFromParent();
      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      hitbox.paint.color = _defaultColor;
    }
  }
}
