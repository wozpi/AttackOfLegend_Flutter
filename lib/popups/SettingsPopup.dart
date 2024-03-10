import 'dart:async';
import 'dart:math';
import 'package:attack_of_legend/components/LegendIconButton.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import '../components/ToggleView.dart';

class SettingPopup extends PositionComponent with HasGameRef<LegendGameWidget> {
  bool isTurnOnMusic;
  bool isTurnOnSound;
  bool isTurnOnVibrate;
  final Function onToogleChange;
  SettingPopup(
      {required this.isTurnOnMusic,
      required this.isTurnOnSound,
      required this.isTurnOnVibrate,
      required this.onToogleChange})
      : super(priority: 50);
  final _paint = Paint()..color = Colors.black54;

  @override
  FutureOr<void> onLoad() async {
    var imgPannel = await Flame.images.load("popup/PannelRoll.png");
    Vector2 gameSize = gameRef.size / gameRef.camera.viewfinder.zoom;
    double miniumSize = min(30, gameSize.y * 0.8);
    Vector2 sizePanne =
        Vector2(miniumSize * imgPannel.size.x / imgPannel.size.y, miniumSize);

    var pannelPopup = SpriteComponent(sprite: Sprite(imgPannel))
      ..position = Vector2(gameSize.x / 2, gameSize.y / 2)
      ..scale = Vector2.zero()
      ..anchor = Anchor.center
      ..center = gameSize / 2
      ..size = sizePanne;
    add(pannelPopup);

    var imgRibbon = await Flame.images.load("popup/ribbon.png");
    pannelPopup.add(SpriteComponent(sprite: Sprite(imgRibbon))
      ..position = Vector2(sizePanne.x / 2, 0)
      ..anchor = Anchor.center
      ..size = Vector2(20, 20 * imgRibbon.height / imgRibbon.width));

    pannelPopup.add(
        takePoolLabelView('Settings', textColor: Colors.white, fontSize: 2)
          ..position = Vector2(sizePanne.x / 2, -1));

    pannelPopup.add(LegendIconButton(
        icon: 'popup/BtnClose.png',
        onPressed: () {
          pannelPopup.add(ScaleEffect.to(
            Vector2.zero(),
            EffectController(duration: 0.2, curve: Curves.easeInBack),
            onComplete: () {
              removeFromParent();
            },
          ));
        })
      ..size = Vector2(6, 6)
      ..position = Vector2((sizePanne.x) - 0.7, 0));

    pannelPopup.add(takeToggleView('Music', isTurnOnMusic, 'MUSIC')
      ..anchor = Anchor.center
      ..position = Vector2(sizePanne.x / 2, (sizePanne.y / 2) - 6));

    pannelPopup.add(takeToggleView('Sound', isTurnOnSound, 'SOUND')
      ..anchor = Anchor.center
      ..position = Vector2(sizePanne.x / 2, (sizePanne.y / 2) - 6 + 5));

    pannelPopup.add(takeToggleView('Vibrate', isTurnOnVibrate, 'VIBRATE')
      ..anchor = Anchor.center
      ..position = Vector2(sizePanne.x / 2, (sizePanne.y / 2) - 6 + 10));

    var imgLine = await Flame.images.load("popup/Line.png");
    pannelPopup.add(SpriteComponent(sprite: Sprite(imgLine))
      ..position =
          Vector2(sizePanne.x / 2, ((sizePanne.y / 2) + sizePanne.y / 2) - 6)
      ..anchor = Anchor.center
      ..size = Vector2(20, 20 * imgLine.height / imgLine.width));

    pannelPopup.add(takePoolLabelView('V.1.0.1', fontSize: 2)
      ..position =
          Vector2(sizePanne.x / 2, ((sizePanne.y / 2) + sizePanne.y / 2) - 3));

    pannelPopup.add(ScaleEffect.to(
      Vector2.all(1),
      EffectController(duration: 0.2, curve: Curves.easeInOut),
    ));
    return super.onLoad();
  }

  PositionComponent takeToggleView(String text, bool isToogle, String tag) {
    var containerToggle = PositionComponent();
    containerToggle.add(takePoolLabelView(text)
      ..position = Vector2(-8, 0)
      ..anchor = Anchor.center);
    containerToggle.add(
        ToogleView(isToogle: isToogle, tag: tag, onToogle: onToogleListener)
          ..position = Vector2(5, 0.4)
          ..anchor = Anchor.center);
    return containerToggle;
  }

  TextComponent takePoolLabelView(String text,
      {double fontSize = 1.5, Color textColor = const Color(0xFF824d30)}) {
    return TextComponent(text: text)
      ..anchor = Anchor.center
      ..textRenderer = TextPaint(
          style: TextStyle(
              color: textColor, fontSize: fontSize, fontFamily: 'SubTitle'));
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y), _paint);
    super.render(canvas);
  }

  void onToogleListener(String tag, bool isToogle) {
    onToogleChange(tag, isToogle);
  }
}
