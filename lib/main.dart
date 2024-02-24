import 'dart:async';

import 'package:attack_of_legend/components/Ball.dart';
import 'package:attack_of_legend/components/Flyer.dart';
import 'package:attack_of_legend/player.dart';
import 'package:attack_of_legend/widgets/LegendGameWidget.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:forge2d/src/dynamics/body.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: LegendGameWidget()));
}

const TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 2);

class CompositionExample extends Forge2DGame {
  static const description = '''
    This example shows how to compose a `BodyComponent` together with a normal
    Flame component. Click the ball to see the number increment.
  ''';

  CompositionExample() : super(zoom: 20, gravity: Vector2(0, 10.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final boundaries = createBoundaries(this);
    world.addAll(boundaries);
    world.add(TappableText(Vector2(0, 5)));
    world.add(TappableBall(Vector2.zero()));
  }
}

class TappableText extends TextComponent with TapCallbacks {
  TappableText(Vector2 position)
      : super(
          text: 'A normal tappable Flame component',
          textRenderer: TextPaint(style: _textStyle),
          position: position,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final scaleEffect = ScaleEffect.by(
      Vector2.all(1.1),
      EffectController(
        duration: 0.7,
        alternate: true,
        infinite: true,
      ),
    );
    add(scaleEffect);
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(
      MoveEffect.by(
        Vector2.all(5),
        EffectController(
          speed: 5,
          alternate: true,
        ),
      ),
    );
  }
}

class TappableBall extends Ball with TapCallbacks {
  late final TextComponent textComponent;
  int counter = 0;
  late final TextPaint _textPaint;

  TappableBall(super.position) {
    originalPaint = Paint()..color = Colors.amber;
    paint = originalPaint;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _textPaint = TextPaint(style: _textStyle);
    textComponent = TextComponent(
      text: counter.toString(),
      textRenderer: _textPaint,
    );
    add(textComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    textComponent.text = counter.toString();
  }

  @override
  bool onTapDown(_) {
    counter++;
    body.applyLinearImpulse(Vector2(1, -1) * 300);
    paint = randomPaint();
    return false;
  }
}

List<Wall> createBoundaries(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();
  final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomLeft = visibleRect.bottomLeft.toVector2();

  return [
    Wall(topLeft, topRight, strokeWidth: strokeWidth),
    Wall(topRight, bottomRight, strokeWidth: strokeWidth),
    Wall(bottomLeft, bottomRight, strokeWidth: strokeWidth),
    Wall(topLeft, bottomLeft, strokeWidth: strokeWidth),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;

  Wall(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 1, density: 40000);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;

    // debugMode = true;
    debugColor = Colors.yellow;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class HeroGame extends Forge2DGame with LongPressDetector, TapDetector {
  HeroGame() : super(gravity: Vector2(0, 98), zoom: 20);
  SpriteComponent player = SpriteComponent();

  Flyer? _flyer;
  @override
  FutureOr<void> onLoad() async {
    // final playerImage = await images.load('hero.png');

    // player
    //   ..sprite = await loadSprite("hero.png")
    //   ..size = Vector2(200, 200);
    super.onLoad();
    // player.position = Vector2(100, 100);
    // world.add(Player(position: Vector2(100, 100), radius: 100));
    // world.add(Hero());
    // _flyer = Flyer(position: Vector2.zero(), radius: 20.0);
    // world.add(_flyer!);
    // return super.onLoad();
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.green;
  }

  @override
  void onTapDown(TapDownInfo info) {
    // TODO: implement onTapDown
    super.onTapDown(info);
    // _flyer?.body.applyForce(Vector2(1, -1) * 19 * 1000000);
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    print("onLongPressEnd");
    super.onLongPressEnd(info);
  }
}

// class AB extends BodyComponent {}

// class Hero extends SpriteComponent with HasGameRef<HeroGame> {
//   // Hero() : super(priority: 1);
//   @override
//   FutureOr<void> onLoad() async {
//     sprite = Sprite(await Flame.images.load("hero.png"));
//     print(sprite?.image);
//     size = Vector2(80, 80);
//     anchor = Anchor.center;
//     // position = -gameRef.size / 2;
//     print(gameRef.camera.viewport.size);
//     // size = gameRef.size;
//     // position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
//   }
// }
