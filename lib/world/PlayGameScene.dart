import 'dart:async';
import 'package:attack_of_legend/common/LevelManager.dart';
import 'package:attack_of_legend/components/BigHero.dart';
import 'package:attack_of_legend/components/GreenTree.dart';
import 'package:attack_of_legend/levels/LegendLevel.dart';
import 'package:attack_of_legend/popups/DefeatPopup.dart';
import 'package:attack_of_legend/popups/WinPopup.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import '../components/Bat.dart';
import '../components/Flyer.dart';
import '../components/GrayTree.dart';
import '../components/LegendBackground.dart';
import '../components/Tree.dart';
import '../components/YellowTree.dart';
import '../widgets/LegendGameWidget.dart';

enum StateGame { onReady, playing, defeat, won }

class PlayGameScene extends Component
    with HasGameRef<LegendGameWidget>, HasCollisionDetection {
  PlayGameScene({this.atLevel = 1});
  int atLevel;
  StateGame _stateGame = StateGame.onReady;
  PowerProgressBar? _powerProgressBar;

  BigHero? _hero;
  int directionPowerProgress = 1;
  double power = 0;

  bool isStartTakePower = false;

  final maxShoot = 5;
  var _totalShoot = 0;
  LegendLevel? _currentLevel;

  List<Tree> grouTrees = [];
  @override
  FutureOr<void> onLoad() async {
    LegendBackground(
            parent: this,
            screenSize: gameRef.size / gameRef.camera.viewfinder.zoom)
        .onLoad();
    _hero = BigHero();
    add(_hero!);

    createTrees();
    double offsetY = gameRef.size.y / gameRef.camera.viewfinder.zoom;
    _powerProgressBar = PowerProgressBar()
      ..anchor = Anchor.topLeft
      ..position = Vector2(4, offsetY - 3.5);
    add(_powerProgressBar!);

    _currentLevel = LevelManager().takeLevel(atLevel);
    add(_currentLevel!);

    _stateGame = StateGame.playing;
    return super.onLoad();
  }

  void createTrees() async {
    grouTrees.add(GrayTree(posX: 67, groupScale: 1.5));
    grouTrees.add(YellowTree(posX: 66, groupScale: 0.5));
    grouTrees.add(GrayTree(posX: 62, groupScale: 1.1));
    grouTrees.add(GreenTree(posX: 55, groupScale: 1.5));

    for (var element in grouTrees) {
      add(element);
    }

    Vector2 cameraSize = gameRef.size / gameRef.camera.viewfinder.zoom;

    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load('tree/fence.png')))
      ..size = Vector2(4, 4 * 155 / 207)
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(61, cameraSize.y - 5));

    add(SpriteComponent(
        sprite: Sprite(await Flame.images.load('tree/up_sign.png')))
      ..size = Vector2(2.5, 2.5 * 92 / 84)
      ..anchor = Anchor.bottomCenter
      ..position = Vector2(40, cameraSize.y - 5));
  }

  void updatePercenterGamePlayer(double per) {
    for (var element in grouTrees) {
      element.updatePercenter(per);
    }
  }

  void _resetTrees() {
    for (var element in grouTrees) {
      element.resetTree();
    }
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

      takePower(directionPowerProgress * dt * 65);
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
        _currentLevel?.add(Flyer(
            radius: 1.1,
            atPosition: _hero!.atShoot(),
            withDirection: _hero!.getDirection(),
            onDead: onFlierDead,
            onAttackBat: onFlierAttackBat,
            power: power));
      }
      (gameRef.world as LegendWorld).onShootSFX();
      _hero?.releaseAim();
      resetPower();
      _totalShoot += 1;
      (gameRef.world as LegendWorld).updateNumberFlier(maxShoot - _totalShoot);
    }
  }

  void needCreatFlyer(Vector2 atPosition) async {
    Flyer newFlyer = Flyer(
        radius: 1.1,
        atPosition: atPosition.clone(),
        withDirection: Vector2.zero(),
        onDead: onFlierDead,
        onAttackBat: onFlierAttackBat,
        power: 0);
    _currentLevel?.add(newFlyer);
  }

  bool canShoot() {
    return _totalShoot < maxShoot;
  }

  void onFlierDead() {
    (gameRef.world as LegendWorld).onFlierDeadSFX();
    if (!canShoot()) {
      repairForFinishGame(StateGame.defeat);
    }
  }

  void onFlierAttackBat(Bat bat) {
    if (_currentLevel != null) {
      _currentLevel?.onFlierAttackBat(bat);
      (gameRef.world as LegendWorld).onBatDeadSFX();
      updatePercenterGamePlayer(
          (_currentLevel!.totalBat - _currentLevel!.numberBatAlive()) *
              1.0 /
              _currentLevel!.totalBat);
      if (_currentLevel!.numberBatAlive() <= 0) {
        repairForFinishGame(StateGame.won);
      }
    }
  }

  void repairForFinishGame(StateGame state, {int duration = 3}) async {
    if (_stateGame == StateGame.playing) {
      _stateGame = state;
      await Future.delayed(Duration(seconds: duration));
      if (_stateGame == StateGame.defeat) {
        (gameRef.world as LegendWorld).onFail();
        _resetTrees();
        add(DefeatPopup(
          onRestart: () {
            _restartGame();
          },
          onGoHome: () {
            (gameRef.world as LegendWorld).enterHomeScene();
          },
        ));
      } else {
        (gameRef.world as LegendWorld).completeGame(atLevel + 1);
        (gameRef.world as LegendWorld).onComlete();
        add(WinPopup(
          onRestart: () {
            _restartGame();
          },
          onNext: () {
            // update level
            (gameRef.world as LegendWorld)
                .enterNextPlayGameScene(atLevel: atLevel + 1);
          },
        ));
      }
    }
  }

  void _restartGame() {
    _totalShoot = 0;
    (gameRef.world as LegendWorld).updateNumberFlier(maxShoot - _totalShoot);
    _stateGame = StateGame.playing;
    _currentLevel?.removeFromParent();
    _currentLevel = LevelManager().takeLevel(atLevel);
    _resetTrees();
    add(_currentLevel!);
  }
}

class PowerProgressBar extends PositionComponent
    with HasGameRef<LegendGameWidget> {
  PowerProgressBar() : super(priority: 10);
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
    canvas.drawRRect(RRect.fromLTRBR(0, 0, 15, 2, const Radius.circular(5)),
        _paint..color = const Color.fromARGB(255, 255, 255, 255));
    canvas.drawRRect(
        RRect.fromLTRBR(2, 0.2, 15 - 0.2, 1.8, const Radius.circular(5)),
        _paint..color = const Color.fromARGB(97, 255, 0, 0));

    double totalProgress = ((13 - 0.2) * _power / 100) + 2;
    canvas.drawRRect(
        RRect.fromLTRBR(2, 0.2, totalProgress, 1.8, const Radius.circular(5)),
        _paint..color = const Color.fromARGB(255, 255, 0, 0));
    super.render(canvas);
  }
}
