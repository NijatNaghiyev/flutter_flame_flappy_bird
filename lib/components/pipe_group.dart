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
    final space = 110 + _randomNumber.nextDouble() * 150;
    final centerOfPipes =
        space + _randomNumber.nextDouble() * (heightWithoutGround - space);

    addAll([
      Pipe(height: centerOfPipes - space / 2, pipePosition: PipePosition.top),
      Pipe(
          height: heightWithoutGround - (centerOfPipes + space / 2),
          pipePosition: PipePosition.bottom),
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
