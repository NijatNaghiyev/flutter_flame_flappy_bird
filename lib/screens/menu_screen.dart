import 'package:flutter/material.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

import '../enum/screen_name.dart';

@immutable
final class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.game});

  final FlappyBird game;

  /// Stop the game when the menu screen is displayed
  void stopGame() {
    if (!game.paused) {
      game.pauseEngine();
    }
  }

  @override
  Widget build(BuildContext context) {
    stopGame();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          /// Remove the menu screen when the screen is tapped
          game.overlays.remove(ScreenName.mainScreen.name);

          /// Resume the game when the menu screen is closed
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.imagesMenu,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(
            Assets.imagesMessage,
          ),
        ),
      ),
    );
  }
}
