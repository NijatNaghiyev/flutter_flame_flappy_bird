import 'package:flame/components.dart';
import 'package:flutter_flame_flappy_bird/enum/bird_movement.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBird> {
  Bird();

  @override
  Future<void> onLoad() async {
    final downFlap = await gameRef.loadSprite(Assets.imagesBirdDownflap);
    final middleFlap = await gameRef.loadSprite(Assets.imagesBirdMidflap);
    final upFlap = await gameRef.loadSprite(Assets.imagesBirdUpflap);

    size = Vector2(50, 40);
    position = Vector2(50, (gameRef.size.y - Config.groundHeight) / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.down: downFlap,
      BirdMovement.middle: middleFlap,
      BirdMovement.up: upFlap,
    };
  }
}
