import 'dart:async';

import 'package:attack_of_legend/components/FrameFlier.dart';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';

class ToolBar extends PositionComponent with HasGameRef<LegendGameWidget> {
  FrameFlier? _frameFlier;
  LegendIconButton? _settingButton;
  LegendIconButton? _backButton;
  LegendIconButton? _toogleMusic;
  bool isReadyTurnOfMusic;
  ToolBar({this.isReadyTurnOfMusic = false});
  @override
  FutureOr<void> onLoad() {
    _backButton = LegendIconButton(
        icon: 'hub/back_btn.png',
        onPressed: () {
          (gameRef.world as LegendWorld).enterHomeScene();
        })
      ..position = Vector2(4, 3.5)
      ..size = Vector2(4, 4)
      ..anchor = Anchor.center;

    _settingButton = LegendIconButton(
        icon: 'hub/settings_btn.png',
        onPressed: () {
          (gameRef.world as LegendWorld).showSettingPopup();
        })
      ..position = Vector2(4, 3.5)
      ..size = Vector2(4, 4)
      ..anchor = Anchor.center;

//Show button enable music background for web
    if (kIsWeb) {
      _toogleMusic = LegendIconButton(
          icon: isReadyTurnOfMusic
              ? 'hub/turn_off_music.png'
              : 'hub/turn_on_music.png',
          onPressed: () async {
            isReadyTurnOfMusic = !isReadyTurnOfMusic;
            _toogleMusic!.sprite = (Sprite(await Flame.images.load(
                isReadyTurnOfMusic
                    ? 'hub/turn_on_music.png'
                    : 'hub/turn_off_music.png')));
            _toogleMusic!.removeFromParent();
            _toogleMusic = null;
            (gameRef.world as LegendWorld).tryToogleMusic(isReadyTurnOfMusic);
          })
        ..position =
            Vector2((gameRef.size / gameRef.camera.viewfinder.zoom).x - 4, 3.5)
        ..size = Vector2(4, 4)
        ..anchor = Anchor.center;
    }
    enableSettingButton();

    return super.onLoad();
  }

  void enableSettingButton() {
    _backButton?.removeFromParent();
    if (_settingButton != null) {
      add(_settingButton!);
    }
    if (_toogleMusic != null) {
      add(_toogleMusic!);
    }
  }

  void enableFrameFlier(bool isShow) {
    if (isShow) {
      if (_frameFlier == null) {
        Vector2 gameWorldSize = gameRef.size / gameRef.camera.viewfinder.zoom;
        _frameFlier = FrameFlier()
          ..position = Vector2(gameWorldSize.x - 10, 1)
          ..anchor = Anchor.center;
        add(_frameFlier!);
      }
    } else {
      _frameFlier?.removeFromParent();
      _frameFlier = null;
    }
  }

  void enableBackButton() {
    _toogleMusic?.removeFromParent();
    _settingButton?.removeFromParent();
    if (_backButton != null) {
      add(_backButton!);
    }
  }

  void updateNumberFlier(int count) {
    _frameFlier?.updateNumberFlier(count);
  }
}
