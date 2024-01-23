import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

import '../enum/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBird> {
  Pipe({required this.height, required this.pipePosition});

  @override
  final double height;

  final PipePosition pipePosition;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Assets.imagesPipe);
    final pipeRotated = await Flame.images.load(Assets.imagesPipeRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
    }
  }
}
