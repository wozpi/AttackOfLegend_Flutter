import 'dart:io';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  if (kIsWeb || !Platform.isAndroid || !Platform.isIOS) {
    runApp(GameWidget(
        game: LegendGameWidget(
            camera:
                CameraComponent.withFixedResolution(width: 932, height: 430))));
  } else {
    runApp(GameWidget(game: LegendGameWidget()));
  }
}
