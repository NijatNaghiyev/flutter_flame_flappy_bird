import 'package:flutter/material.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';

import '../enum/screen_name.dart';
import '../generated/assets.dart';

@immutable
final class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  final FlappyBird game;

  /// Restart the game when the restart button is pressed
  void restart() {
    /// Reset the bird position
    game.bird.reset();

    /// Reset Score
    game.score = 0;

    /// Restart the game when the restart button is pressed
    game.overlays.remove(ScreenName.gameOverScreen.name);

    /// Resume the game when the game over screen is closed
    game.resumeEngine();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${game.score}',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Game',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(Assets.imagesGameover),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
            onPressed: restart,
            child: const Text(
              'Restart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
