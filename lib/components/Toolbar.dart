import 'dart:async';

import 'package:attack_of_legend/components/FrameFlier.dart';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';

class ToolBar extends PositionComponent with HasGameRef<LegendGameWidget> {
  FrameFlier? _frameFlier;
  LegendIconButton? _settingButton;
  LegendIconButton? _backButton;
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
    enableSettingButton();

    return super.onLoad();
  }

  void enableSettingButton() {
    _backButton?.removeFromParent();
    if (_settingButton != null) {
      add(_settingButton!);
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
    _settingButton?.removeFromParent();
    if (_backButton != null) {
      add(_backButton!);
    }
  }

  void updateNumberFlier(int count) {
    _frameFlier?.updateNumberFlier(count);
  }
}
