import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:attack_of_legend/levels/Level01.dart';

import '../levels/Level02.dart';
import '../levels/Level03.dart';
import '../levels/Level04.dart';
import '../levels/Level05.dart';
import '../levels/Level06.dart';
import '../levels/Level07.dart';
import '../levels/Level08.dart';
import '../levels/Level09.dart';
import '../levels/Level10.dart';
import '../levels/Level11.dart';
import '../levels/Level12.dart';
import '../levels/Level13.dart';
import '../levels/Level14.dart';
import '../levels/Level15.dart';
import '../levels/Level16.dart';
import '../levels/Level17.dart';
import '../levels/Level18.dart';
import '../levels/Level19.dart';
import '../levels/Level20.dart';
import '../levels/Level21.dart';
import '../levels/Level22.dart';
import '../levels/Level23.dart';
import '../levels/Level24.dart';
import '../levels/Level25.dart';
import '../levels/Level26.dart';
import '../levels/Level27.dart';
import '../levels/Level28.dart';
import '../levels/Level29.dart';
import '../levels/Level30.dart';
import '../levels/Level31.dart';

class LevelManager {
  static final LevelManager _instance = LevelManager._internal();
  factory LevelManager() {
    return _instance;
  }
  LevelManager._internal() {
    // initialization logic
  }
  LegendLevel takeLevel(int index) {
    switch (index) {
      case 0:
        return Level01();
      case 1:
        return Level02();
      case 2:
        return Level03();
      case 3:
        return Level04();
      case 4:
        return Level05();
      case 5:
        return Level06();
      case 6:
        return Level07();
      case 7:
        return Level08();
      case 8:
        return Level09();
      case 9:
        return Level10();
      case 10:
        return Level11();
      case 11:
        return Level12();
      case 12:
        return Level13();
      case 13:
        return Level14();
      case 14:
        return Level15();
      case 15:
        return Level16();
      case 16:
        return Level17();
      case 17:
        return Level18();
      case 18:
        return Level19();
      case 19:
        return Level20();
      case 20:
        return Level21();
      case 21:
        return Level22();
      case 22:
        return Level23();
      case 23:
        return Level24();
      case 24:
        return Level25();
      case 25:
        return Level26();
      case 26:
        return Level27();
      case 27:
        return Level28();
      case 28:
        return Level29();
      case 29:
        return Level30();
      case 30:
        return Level31();
      default:
        return Level01();
    }
  }
}
