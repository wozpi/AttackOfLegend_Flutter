import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

class ToogleView extends SpriteComponent
    with TapCallbacks, HasGameRef, TapCallbacks {
  final Function onToogle;
  SpriteComponent? _slotOn;
  SpriteComponent? _knob;
  String tag;
  bool isToogle = false;
  ToogleView(
      {required this.isToogle, required this.tag, required this.onToogle});
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    var slotbaseImg = await Flame.images.load('popup/SliderOff.png');
    sprite = Sprite(slotbaseImg);
    size = Vector2(6, 6 * slotbaseImg.height / slotbaseImg.width);
    anchor = Anchor.centerLeft;

    var slotOnImg = await Flame.images.load('popup/SliderOn.png');
    _slotOn = SpriteComponent(sprite: Sprite(slotOnImg))
      ..size = Vector2(6, 6 * slotOnImg.height / slotOnImg.width)
      ..position = Vector2(3, 1.3)
      ..opacity = isToogle ? 1 : 0
      ..anchor = Anchor.center;
    add(_slotOn!);

    var knobImg = await Flame.images.load('popup/SliderButton.png');
    _knob = SpriteComponent(sprite: Sprite(knobImg))
      ..size = Vector2(3, 3 * knobImg.height / knobImg.width)
      ..position = isToogle ? Vector2(5, 1.4) : Vector2(1, 1.4)
      ..anchor = Anchor.center;
    add(_knob!);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    isToogle = !isToogle;
    if (isToogle) {
      _knob?.add(MoveEffect.to(Vector2(5, 1.4),
          EffectController(duration: 0.5, curve: Curves.bounceOut)));

      _slotOn?.add(OpacityEffect.to(
          255, EffectController(duration: 0.5, curve: Curves.easeInOut)));
    } else {
      _knob?.add(MoveEffect.to(Vector2(1, 1.4),
          EffectController(duration: 0.5, curve: Curves.bounceOut)));
      _slotOn?.add(OpacityEffect.to(
          0, EffectController(duration: 0.5, curve: Curves.easeInOut)));
    }

    onToogle(tag, isToogle);
    super.onTapUp(event);
  }
}
