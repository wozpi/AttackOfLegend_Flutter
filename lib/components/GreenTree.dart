import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

import 'Tree.dart';

class GreenTree extends Tree {
  double posX;
  double groupScale;

  SpriteComponent? grassComponent;
  SpriteComponent? rabbitComponent;
  GreenTree({required this.posX, this.groupScale = 1})
      : super(
            pathDeadTree: 'tree/dead_tree_03.png',
            pathFoliages: [
              'tree/leaf_tree1_03.png',
              'tree/leaf_tree2_03.png',
              'tree/dead_tree_04.png',
              'tree/flower.png'
            ],
            positionFoliages: [
              Vector2(0, -1),
              Vector2(0, -3.5),
              Vector2(-4, -3.5),
              Vector2(-1, -2.3),
            ],
            byScales: [0.6, 1, 0.4, 1.1],
            positionX: posX,
            offsetPriority: 0,
            byGroupScale: groupScale);

  @override
  FutureOr<void> onLoad() async {
    await Flame.images.load('tree/grass.png');
    await Flame.images.load('tree/rabbit.png');
    return super.onLoad();
  }

  @override
  void allDone() async {
    var imgGlass = Flame.images.fromCache('tree/grass.png');
    grassComponent = SpriteComponent(sprite: Sprite(imgGlass))
      ..add(ScaleEffect.to(Vector2(1, 1),
          EffectController(duration: 1, curve: Curves.easeInOut)))
      ..size = Vector2(2, 2 * imgGlass.width / imgGlass.height)
      ..priority = 7
      ..scale = Vector2(1, 0)
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(2.2, 3) * groupScale;

    add(grassComponent!);

    await Future.delayed(const Duration(seconds: 1));
    var imgRabbit = Flame.images.fromCache('tree/rabbit.png');
    rabbitComponent = SpriteComponent(sprite: Sprite(imgRabbit))
      ..size = Vector2(2, 2 * imgGlass.width / imgGlass.height)
      ..priority = 6
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(2.2, 3) * groupScale
      ..add(MoveByEffect(
          Vector2(0, -3),
          EffectController(
              duration: 0.5,
              reverseDuration: 0.5,
              infinite: true,
              startDelay: 1,
              alternate: true,
              curve: Curves.easeInOut)));

    add(rabbitComponent!);
    super.allDone();
  }

  @override
  void resetTree() {
    grassComponent?.add(OpacityEffect.to(
        0, EffectController(duration: 1, curve: Curves.easeInBack))
      ..add(ScaleEffect.to(
        Vector2.zero(),
        EffectController(duration: 1, curve: Curves.easeInOut),
        onComplete: () {
          grassComponent?.removeFromParent();
        },
      )));

    rabbitComponent?.add(OpacityEffect.to(
        0, EffectController(duration: 1, curve: Curves.easeInBack))
      ..add(ScaleEffect.to(
        Vector2.zero(),
        EffectController(duration: 1, curve: Curves.easeInOut),
        onComplete: () {
          rabbitComponent?.removeFromParent();
        },
      )));
    super.resetTree();
  }
}
