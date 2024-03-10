import 'dart:async';
import 'dart:math';
import 'package:attack_of_legend/components/Flyer.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class MagicHat extends PositionComponent {
  Function? onMoveFlyer;
  MagicHat(
      {required this.atPosition,
      this.onMoveFlyer,
      this.withBlock = true,
      this.positionConnect})
      : super(priority: 4);
  Vector2 atPosition;
  Vector2? positionConnect;
  bool withBlock;
  MagicHat? _connectHat;
  @override
  Future<void> onLoad() async {
    position = atPosition;
    var imgBodyHat = await Flame.images.load("environment/body_hat.png");
    var radioBody = imgBodyHat.height / imgBodyHat.width;
    var bodyHat = SpriteComponent(sprite: Sprite(imgBodyHat))
      ..size = Vector2(7, 7 * radioBody)
      ..priority = -4
      ..anchor = Anchor.center
      ..setAlpha(255);
    add(bodyHat);

    var imgHeaderHat = await Flame.images.load("environment/header_hat.png");
    var radioHeader = imgHeaderHat.height / imgHeaderHat.width;
    var headerHat = SpriteComponent(sprite: Sprite(imgHeaderHat))
      ..size = Vector2(7, 7 * radioHeader)
      ..priority = 4
      ..position = Vector2(0, -2)
      ..anchor = Anchor.center
      ..setAlpha(255);
    add(headerHat);

    if (withBlock) {
      add(BlockMagicHat(
          atStart: Vector2(-1.8, -1.7),
          atEnd: Vector2(1.8, -1.7),
          atPosition: atPosition,
          isSensor: true));

      add(BlockMagicHat(
          atStart: Vector2(-3.5, -2.2),
          atEnd: Vector2(-2, -1.8),
          atPosition: atPosition));

      add(BlockMagicHat(
          atStart: Vector2(-2, -1.8),
          atEnd: Vector2(-2, 2),
          atPosition: atPosition));

      add(BlockMagicHat(
          atStart: Vector2(-2, 2),
          atEnd: Vector2(2, 2),
          atPosition: atPosition));

      add(BlockMagicHat(
          atStart: Vector2(2, 2),
          atEnd: Vector2(2, -1.8),
          atPosition: atPosition));

      add(BlockMagicHat(
          atStart: Vector2(2, -1.8),
          atEnd: Vector2(3.5, -2.2),
          atPosition: atPosition));
    }

    if (positionConnect != null) {
      _connectHat = MagicHat(atPosition: positionConnect!, withBlock: false)
        ..angle = pi;

      parent?.add(_connectHat!);
    }
    return super.onLoad();
  }

  void onMoveFlyerToConnect() {
    if (positionConnect != null) {
      onMoveFlyer?.call(positionConnect!);
    }
  }
}

class BlockMagicHat extends BodyComponent with ContactCallbacks {
  Vector2 atStart;
  Vector2 atEnd;
  Vector2 atPosition;
  bool isSensor;
  BlockMagicHat(
      {required this.atStart,
      required this.atEnd,
      required this.atPosition,
      this.isSensor = false})
      : super(key: ComponentKey.unique());
  void moveSmooth(double dt) {
    bodyDef?.linearVelocity = Vector2(1, 0) * 2;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsEdge(atStart, atEnd);
    final fixtureDef = FixtureDef(shape,
        userData: this,
        density: 0,
        restitution: 0,
        friction: 0,
        isSensor: isSensor);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: atPosition,
    )..type = BodyType.kinematic;
    debugMode = true;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  Flyer? _flyerMove;

  @override
  void beginContact(Object other, Contact contact) async {
    if (isSensor) {
      if (other is Flyer && _flyerMove != other) {
        _flyerMove = other;
        (parent as MagicHat).onMoveFlyerToConnect();
        other.removeFromParent();
      }
    }
    super.beginContact(other, contact);
  }

  // @override
  // void render(Canvas canvas) {
  //   canvas.drawLine(
  //       Offset(atStart.x, atStart.y) + Offset(atPosition.x, atPosition.y),
  //       Offset(atEnd.x, atEnd.y) + Offset(atPosition.x, atPosition.y),
  //       Paint()..color = Colors.red);
  //   super.render(canvas);
  // }
}
