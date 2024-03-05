import 'dart:async';
import 'dart:ui';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class PathFollow extends PositionComponent with HasGameRef {
  Path pathMove;
  Bat target;
  PathFollow({required this.pathMove, required this.target});

  @override
  FutureOr<void> onLoad() {
    add(MoveEffect.to(Vector2(70, 15), EffectController(duration: 3)));
    // MoveAlongPathEffect(path, controller)

    // add(MovePa(pathMove, EffectController(duration: 3)));
    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   target.updatePosition(position);
  //   super.update(dt);
  // }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, 10, Paint()..color = Colors.red);
    super.render(canvas);
  }
}
