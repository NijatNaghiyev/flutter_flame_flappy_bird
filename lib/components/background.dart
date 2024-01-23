import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBird> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load('background.png');
    size = gameRef.size;
    sprite = Sprite(background);
    return super.onLoad();
  }
}
