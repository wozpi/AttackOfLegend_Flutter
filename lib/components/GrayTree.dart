import 'package:flame/game.dart';

import 'Tree.dart';

class GrayTree extends Tree {
  double posX;
  double groupScale;
  GrayTree({required this.posX, this.groupScale = 1})
      : super(pathFoliages: [
          'tree/leaf_tree2_01.png',
          'tree/leaf_tree1_01.png',
          'tree/leaf_tree3_01.png',
        ], positionFoliages: [
          Vector2(0, -2),
          Vector2(-1.7, -1),
          Vector2(1.4, -0.5),
        ], byScales: [
          1,
          0.5,
          0.5,
          1.1
        ], positionX: posX, offsetPriority: 0, byGroupScale: groupScale);
}
