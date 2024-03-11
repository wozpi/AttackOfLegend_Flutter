import 'dart:async';

import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';

import '../scenes/PlayGameScene.dart';

class LegendLevel extends PositionComponent with HasGameRef<LegendGameWidget> {
  final List<Bat> _listBats = [];
  int totalBat = 0;

  @override
  FutureOr<void> onLoad() {
    totalBat = _listBats.length;
    super.onLoad();
  }

  int numberBatAlive() {
    return _listBats.length;
  }

  void initBat(Bat bat) {
    _listBats.add(bat);
    add(bat);
  }

  void onFlierAttackBat(Bat bat) {
    _listBats.remove(bat);
  }

  void needCreatFlyer(Vector2 atPosition) {
    if (parent is PlayGameScene) {
      (parent as PlayGameScene).needCreatFlyer(atPosition);
    }
  }
}
