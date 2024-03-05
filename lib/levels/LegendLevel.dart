import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';

class LegendLevel extends PositionComponent with HasGameRef<LegendGameWidget> {
  final List<Bat> _listBats = [];

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
}
