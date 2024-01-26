import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flutter_flame_flappy_bird/components/background.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';

import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_group.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBird();

  /// Repeat for [PipeGroup]
  Timer intervalPipe = Timer(Config.pipeInterval, repeat: true);

  /// Repeat for [Bird]
  final bird = Bird();

  /// Game Over
  bool isGameOver = false;

  /// Score Text
  late final TextComponent scoreText;

  /// Score
  int score = 0;

  void initScore() {
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y * 0.15),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'Game',
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
    );

    add(scoreText);
  }

  @override
  Future<void> onLoad() async {
    /// All Component
    addAll([
      /// Background
      Background(),

      /// Ground
      Ground(),

      /// Bird
      bird,
    ]);

    /// Score Text
    initScore();

    /// Pipe Group
    intervalPipe.onTick = () => add(PipeGroup());
  }

  @override
  void onTap() {
    super.onTap();
    bird.onTap();
  }

  @override
  void update(double dt) {
    super.update(dt);

    /// Interval for [PipeGroup]
    intervalPipe.update(dt);

    /// To update the score
    scoreText.text = 'Score: $score';
  }
}
