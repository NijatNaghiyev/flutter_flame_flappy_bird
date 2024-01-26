import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
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

  @override
  Future<void> onLoad() async {
    /// All Component
    addAll([
      Background(),
      Ground(),
      bird,
    ]);

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
  }
}
