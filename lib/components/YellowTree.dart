import 'package:flame/game.dart';

import 'Tree.dart';

class YellowTree extends Tree {
  double posX;
  double groupScale;
  YellowTree({required this.posX, this.groupScale = 1})
      : super(
            pathFoliages: ['tree/leaf_tree1_02.png', 'tree/leaf_tree2_02.png'],
            positionFoliages: [Vector2(0, -1), Vector2(0, -3.5)],
            byScales: [0.6, 1],
            positionX: posX,
            offsetPriority: 0,
            byGroupScale: groupScale);
}
