import 'dart:async';
import 'dart:ui' hide TextStyle;
import 'package:attack_of_legend/components/Background.dart';
import 'package:attack_of_legend/components/Bat.dart';
import 'package:attack_of_legend/components/Flyer.dart';
import 'package:attack_of_legend/components/BigHero.dart';
import 'package:attack_of_legend/components/Tiles.dart';
import 'package:attack_of_legend/main.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame/particles.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class LegendGameWidget extends Forge2DGame
    with TapDetector, HasCollisionDetection, LongPressDetector {
  LegendGameWidget()
      : super(
          zoom: 10,
          gravity: Vector2(0, 98),
        );

  PowerProgressBar? _powerProgressBar;
  double sizeTiles = 5;
  double sizeBackground = 45;
  BigHero? _hero;
  int directionPowerProgress = 1;
  double power = 0;

  bool isStartTakePower = false;

  @override
  FutureOr<void> onLoad() {
    camera.viewfinder.anchor = Anchor.topLeft;
    final boundaries = createBoundaries(this);
    double offsetX = -size.x / camera.viewfinder.zoom;
    double offsetY = size.y / camera.viewfinder.zoom;
    world.addAll(boundaries);

    print("size: ${camera.viewfinder.anchor}");

    // Add ground
    for (var i = 0; i < 20; i++) {
      world.add(Background(
          atPosition: Vector2(i * sizeBackground, offsetY - sizeBackground / 2),
          width: sizeBackground,
          height: sizeBackground));
    }

    _hero = BigHero();
    world.add(_hero!);

    world.add(Bat());
    // Add ground
    for (var i = 0; i < 20; i++) {
      world.add(Tiles(
          atPosition: Vector2(i * sizeTiles, offsetY - sizeTiles / 2),
          size: sizeTiles));
    }

    _powerProgressBar = PowerProgressBar()
      ..anchor = Anchor.topLeft
      ..position = Vector2(4, offsetY - 3.5);
    world.add(_powerProgressBar!);

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

  @override
  void onTapDown(TapDownInfo info) {
    resetPower();
    print("onTapDown");
    isStartTakePower = true;
    _hero?.goingToAim();
    super.onTapDown(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    print("onTapUp");
    isStartTakePower = false;
    if (_hero != null) {
      world.add(Flyer(
          radius: 1.1,
          atPosition: _hero!.atShoot(),
          withDirection: _hero!.getDirection(),
          power: power));
    }
    _hero?.releaseAim();
    resetPower();
    super.onTapUp(info);
  }

  @override
  void onTapCancel() {
    print("onTapCancel");
    super.onTapCancel();
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    isStartTakePower = false;
    if (_hero != null) {
      world.add(Flyer(
          radius: 1.1,
          atPosition: _hero!.atShoot(),
          withDirection: _hero!.getDirection(),
          power: power));
    }
    _hero?.releaseAim();
    resetPower();
    super.onLongPressEnd(info);
  }

  void resetPower() {
    power = 0;
    print("reset Power");
    _powerProgressBar?.updateLabel();
  }

  void takePower(dame) {
    power += dame;
    _powerProgressBar?.updateLabel();
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Color.fromARGB(255, 207, 239, 252);
  }
}

class PowerProgressBar extends PositionComponent
    with HasGameRef<LegendGameWidget> {
  final Paint _paint = Paint();
  TextComponent? _powerLabel;

  void updateLabel() {
    _powerLabel?.text = "${gameRef.power.round()}%";
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
      text: "${(gameRef.power).round()}%",
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

    double totalProgress = ((13 - 0.2) * gameRef.power / 100) + 2;
    canvas.drawRRect(
        RRect.fromLTRBR(2, 0.2, totalProgress, 1.8, Radius.circular(5)),
        _paint..color = const Color.fromARGB(255, 255, 0, 0));
    super.render(canvas);
  }

  double offset = 1;
  @override
  void update(double dt) {
    // offset -= dt;
    // TODO: implement update
    super.update(dt);
  }
}
