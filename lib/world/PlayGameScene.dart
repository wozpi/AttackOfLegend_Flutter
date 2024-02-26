import 'dart:async';
import 'package:attack_of_legend/components/BigHero.dart';
import 'package:attack_of_legend/components/LegendBackground.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import '../components/Bat.dart';
import '../components/Flyer.dart';
import '../widgets/LegendGameWidget.dart';

class PlayGameScene extends Component
    with HasGameRef<LegendGameWidget>, HasCollisionDetection {
  PowerProgressBar? _powerProgressBar;

  BigHero? _hero;
  int directionPowerProgress = 1;
  double power = 0;

  bool isStartTakePower = false;

  final maxShoot = 5;
  var _totalShoot = 0;

  @override
  FutureOr<void> onLoad() async {
    add(LegendBackground());
    _hero = BigHero();
    add(_hero!);

    add(Bat());

    double offsetY = gameRef.size.y / gameRef.camera.viewfinder.zoom;
    _powerProgressBar = PowerProgressBar()
      ..anchor = Anchor.topLeft
      ..position = Vector2(4, offsetY - 3.5);
    add(_powerProgressBar!);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isStartTakePower) {
      if (power > 100) {
        directionPowerProgress = -1;
      } else {
        if (power <= 0) {
          directionPowerProgress = 1;
        }
      }

      takePower(directionPowerProgress * dt * 35);
    }
    super.update(dt);
  }

  void resetPower() {
    power = 0;
    _powerProgressBar?.updateLabel(power);
  }

  void takePower(dame) {
    power += dame;
    _powerProgressBar?.updateLabel(power);
  }

  void onPressedDown() {
    if (canShoot()) {
      resetPower();
      isStartTakePower = true;
      _hero?.goingToAim();
    }
  }

  void onPressedUp() {
    if (isStartTakePower) {
      isStartTakePower = false;
      if (_hero != null) {
        add(Flyer(
            radius: 1.1,
            atPosition: _hero!.atShoot(),
            withDirection: _hero!.getDirection(),
            onDead: onFlierDead,
            onAttackBat: onFlierAttackBat,
            power: power));
      }
      _hero?.releaseAim();
      resetPower();
      _totalShoot += 1;
      (gameRef.world as LegendWorld).updateNumberFlier(maxShoot - _totalShoot);
    }
  }

  bool canShoot() {
    return _totalShoot < maxShoot;
  }

  void onFlierDead() {}

  void onFlierAttackBat() {}
}

class PowerProgressBar extends PositionComponent
    with HasGameRef<LegendGameWidget> {
  final Paint _paint = Paint();
  TextComponent? _powerLabel;
  double _power = 0.0;
  void updateLabel(double power) {
    _power = power;
    _powerLabel?.text = "${power.round()}%";
  }

  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
        sprite:
            Sprite(await Flame.images.load("characters/hero/icon_flame.png")))
      ..position = Vector2(0, 1)
      ..size = Vector2(2.6, 2.6)
      ..anchor = Anchor.center);

    _powerLabel = TextComponent(
      text: "",
      size: Vector2(100, 2),
      position: Vector2(position.x + 17 / 2, position.y + 0.8),
      anchor: Anchor.center,
      textRenderer: TextPaint(
          style: const TextStyle(
        fontFamily: 'SubTitle',
        color: Colors.white,
        fontSize: 1.0,
      )),
    );
    gameRef.world.add(_powerLabel!);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(const Offset(0, 1), 1.7,
        _paint..color = const Color.fromARGB(255, 255, 255, 255));
    canvas.drawRRect(RRect.fromLTRBR(0, 0, 15, 2, Radius.circular(5)),
        _paint..color = const Color.fromARGB(255, 255, 255, 255));
    canvas.drawRRect(RRect.fromLTRBR(2, 0.2, 15 - 0.2, 1.8, Radius.circular(5)),
        _paint..color = Color.fromARGB(97, 255, 0, 0));

    double totalProgress = ((13 - 0.2) * _power / 100) + 2;
    canvas.drawRRect(
        RRect.fromLTRBR(2, 0.2, totalProgress, 1.8, Radius.circular(5)),
        _paint..color = const Color.fromARGB(255, 255, 0, 0));
    super.render(canvas);
  }
}
