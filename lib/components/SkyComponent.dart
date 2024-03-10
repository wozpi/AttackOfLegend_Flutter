import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import 'CloudComponent.dart';

class SkyComponent extends Component with HasGameRef {
  List<String> pathClouds = [
    'environment/cloud1.png',
    'environment/cloud2.png',
    'environment/cloud3.png',
    'environment/cloud4.png',
    'environment/cloud5.png',
    'environment/cloud6.png',
    'environment/cloud7.png',
    'environment/cloud8.png'
  ];
  @override
  FutureOr<void> onLoad() async {
    for (var element in pathClouds) {
      await Flame.images.load(element);
    }

    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(0, Random().nextDouble() * 10 + 5));

    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(10, Random().nextDouble() * 10 + 5));

    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(20, Random().nextDouble() * 10 + 5));

    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(50, Random().nextDouble() * 10 + 5));

    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(70, Random().nextDouble() * 10 + 5));
    print('load bbasdasdasd');
    return super.onLoad();
  }

  void randomClouds() {
    add(takeRandomCloud(pathClouds[Random().nextInt(pathClouds.length)])
      ..position = Vector2(0, Random().nextDouble() * 10 + 5));
  }

  CloudComponent takeRandomCloud(String path) {
    return CloudComponent(
        path: path,
        withSize: Random().nextDouble() * 13 + 7,
        onDead: randomClouds);
  }
}
