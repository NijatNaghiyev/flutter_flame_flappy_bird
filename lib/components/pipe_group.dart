import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_flame_flappy_bird/components/pipe.dart';
import 'package:flutter_flame_flappy_bird/enum/pipe_position.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';

import '../game/configuration.dart';
import '../generated/assets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBird> {
  PipeGroup();

  final _randomNumber = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightWithoutGround = gameRef.size.y - Config.groundHeight;
    final space = 130 + _randomNumber.nextDouble() * 150;
    final centerOfPipes =
        space + _randomNumber.nextDouble() * (heightWithoutGround - space);

    final bool isSoShort = (centerOfPipes + space / 2) > heightWithoutGround;

    addAll([
      Pipe(
        pipePosition: PipePosition.top,
        height: isSoShort
            ? centerOfPipes - space / 2 - 10
            : centerOfPipes - space / 2,
      ),
      Pipe(
        pipePosition: PipePosition.bottom,
        height:
            isSoShort ? 10 : heightWithoutGround - (centerOfPipes + space / 2),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    /// Move Pipe
    position.x -= Config.gameSpeed * dt;

    /// Remove Pipe
    if (position.x < -10) {
      removeFromParent();

      /// Play Audio
      FlameAudio.play(Assets.audioPoint);

      /// Add Score
      game.score++;
    }

    /// Game Over
    if (game.isGameOver) {
      /// Remove Pipe
      removeFromParent();

      /// Reset Game
      game.isGameOver = false;
    }
  }
}
