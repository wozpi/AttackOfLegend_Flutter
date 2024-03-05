import 'dart:async';
import 'dart:math';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/components/LevelMetal.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LevelScene extends Component with HasGameRef {
  final _paint = Paint()..color = Colors.black54;
  int _atPage = 0;
  final int _totalLevels = 32;
  final int _maxItemInRow = 6;
  // current level player was played
  final int _currentLevel = 35;
  // int _atPage = 0;
  int _totalPage = 0;

  LegendIconButton? _previewButton;
  LegendIconButton? _nextButton;
  @override
  FutureOr<void> onLoad() {
    _totalPage = (_totalLevels * 1.0 / (_maxItemInRow * 2)).ceil();

    if (gameRef.buildContext != null) {
      var safeArea = MediaQuery.of(gameRef.buildContext!).padding;
      double levelZoomCamera = gameRef.camera.viewfinder.zoom;
      double startPositionX = (safeArea.left / levelZoomCamera);

      _previewButton = LegendIconButton(
          icon: 'levels/arrow_direction.png',
          onPressed: () {
            onPressPreviewLevels();
          })
        ..position = Vector2(startPositionX + 3, gameRef.size.y / 20)
        ..flipHorizontally()
        ..size = Vector2(4, 4);
      add(_previewButton!);

      _nextButton = LegendIconButton(
          icon: 'levels/arrow_direction.png',
          onPressed: () {
            onPressNextLevels();
          })
        ..position = Vector2(
            ((gameRef.size.x - safeArea.left) / levelZoomCamera) - 3,
            gameRef.size.y / 20)
        ..size = Vector2(4, 4);
      add(_nextButton!);

      loadLevels();

      checkStateButton();
    }
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTRB(0, 0, gameRef.size.x, gameRef.size.y), _paint);
    super.render(canvas);
  }

  void loadLevels() {
    clearLevels();

    var totalTemp = (_maxItemInRow * 2);
    var fromAt = (_atPage * totalTemp);
    var toAt = (_atPage + 1) * totalTemp;
    int numberLevelCurrentPage = 0;
    if (toAt > _totalLevels) {
      numberLevelCurrentPage = (_totalLevels - fromAt);
    } else {
      numberLevelCurrentPage = totalTemp;
    }

    var numberRow = (numberLevelCurrentPage * 1.0 / _maxItemInRow);
    var safeArea = MediaQuery.of(gameRef.buildContext!).padding;

    for (var index = 0; index < numberRow; index++) {
      var totalOffset = numberLevelCurrentPage - (index * _maxItemInRow);
      var totalLevelRow = min(totalOffset, _maxItemInRow);

      for (var at = 0; at < totalLevelRow; at++) {
        var maxSizeMetalLevel =
            ((gameRef.size.x - safeArea.left - safeArea.right - 40 - 60) /
                (totalLevelRow * gameRef.camera.viewfinder.zoom));
        var sizeMetalLevel = min(8.0, maxSizeMetalLevel);
        var atLevel = (at + 1 + fromAt + (index * _maxItemInRow));
        add(LevelMetal(
            maxWith: sizeMetalLevel,
            level: atLevel <= _currentLevel ? atLevel : null,
            onPressed: onSelectLevel)
          ..position = Vector2(
              (safeArea.left / 10) +
                  2 +
                  3 +
                  ((maxSizeMetalLevel - sizeMetalLevel) / 2) +
                  maxSizeMetalLevel * at,
              (gameRef.size.y / 20) -
                  (maxSizeMetalLevel * (numberRow - 1) / 2) +
                  (maxSizeMetalLevel * index) -
                  (2 - numberRow)));
      }
    }
  }

  void clearLevels() {
    removeAll(children.where((element) => element is! LegendIconButton));
  }

  bool canMoveNextPage() {
    return _atPage < _totalPage - 1;
  }

  bool canMovePreviewPage() {
    return _atPage > 0;
  }

  void onPressPreviewLevels() {
    if (canMovePreviewPage()) {
      _atPage -= 1;
      loadLevels();
    }
    checkStateButton();
  }

  void onPressNextLevels() {
    if (canMoveNextPage()) {
      _atPage += 1;
      loadLevels();
    }

    checkStateButton();
  }

  void checkStateButton() {
    if (canMovePreviewPage()) {
      _previewButton?.setAlpha(255);
    } else {
      _previewButton?.setAlpha(50);
    }

    if (canMoveNextPage()) {
      _nextButton?.setAlpha(255);
    } else {
      _nextButton?.setAlpha(50);
    }
  }

  void onSelectLevel(int level) {
    (gameRef.world as LegendWorld).enterPlayGameScene(level - 1);
  }
}
