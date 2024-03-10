import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/animation.dart';

class Tree extends PositionComponent with HasGameRef {
  String pathDeadTree;
  double positionX;
  List<String> pathFoliages;
  List<Vector2> positionFoliages;
  List<double> byScales;
  double byGroupScale;
  int offsetPriority;
  List<SpriteComponent> foliages = [];
  List<SpriteComponent> foliagesGoingEffect = [];
  bool isDone = false;
  Tree(
      {required this.pathFoliages,
      required this.positionFoliages,
      required this.byScales,
      required this.positionX,
      this.offsetPriority = 1,
      this.byGroupScale = 1,
      this.pathDeadTree = 'tree/dead_tree_01.png'});
  @override
  FutureOr<void> onLoad() async {
    double heightTree = 6;
    Vector2 cameraSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    position =
        Vector2(positionX, cameraSize.y - 5 - (heightTree / 2) * byGroupScale);
    Image imgTree = await Flame.images.load(pathDeadTree);
    Vector2 originDeadTreeSize = imgTree.size / 10;

    add(SpriteComponent(sprite: Sprite(imgTree))
      ..anchor = Anchor.center
      ..priority = 1
      ..position = Vector2.zero()
      ..size = Vector2(heightTree * originDeadTreeSize.x / originDeadTreeSize.y,
              heightTree) *
          byGroupScale);

    for (var i = 0; i < pathFoliages.length; i++) {
      addFoliage(pathFoliages[i], positionFoliages[i], 5 * byScales[i],
          i + offsetPriority);
    }
  }

  void addFoliage(
      String path, Vector2 atPosition, double size, int priorityTree) {
    Image imgTree = Flame.images.fromCache(path);
    Vector2 originImg = imgTree.size / 10;
    var foliage = SpriteComponent(sprite: Sprite(imgTree))
      ..anchor = Anchor.center
      ..position = atPosition * byGroupScale
      ..priority = priorityTree
      ..setAlpha(0)
      ..scale = Vector2.zero()
      ..size = Vector2(size * originImg.x / originImg.y, size) * byGroupScale;
    foliages.add(foliage);
    add(foliage);
  }

  void updatePercenter(double percenter) {
    if (percenter >= 1 && !isDone) {
      allDone();
      isDone = true;
    }

    var to = (foliages.length * percenter).round();
    for (var i = 0; i < min(to, foliages.length); i++) {
      SpriteComponent elementTree = foliages[i];
      if (elementTree.getAlpha() == 0 &&
          !foliagesGoingEffect.contains(elementTree)) {
        elementTree.add(OpacityEffect.to(
            255, EffectController(duration: 2, curve: Curves.easeInBack))
          ..add(ScaleEffect.to(Vector2.all(1),
              EffectController(duration: 2, curve: Curves.easeInOut))));

        foliagesGoingEffect.add(elementTree);
      }
    }
  }

  void resetTree() {
    isDone = false;

    for (var i = 0; i < foliages.length; i++) {
      SpriteComponent elementTree = foliages[i];
      if (elementTree.getAlpha() != 0) {
        elementTree.add(OpacityEffect.to(
            0, EffectController(duration: 2, curve: Curves.easeInBack))
          ..add(ScaleEffect.to(Vector2.zero(),
              EffectController(duration: 2, curve: Curves.easeInOut))));
      }
    }

    foliagesGoingEffect.clear();
  }

  void allDone() {}
}
