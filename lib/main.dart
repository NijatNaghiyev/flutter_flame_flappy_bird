import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_flappy_bird/screens/game_over_screen.dart';
import 'package:flutter_flame_flappy_bird/screens/menu_screen.dart';

import 'enum/screen_name.dart';
import 'game/flappy_bird.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set the device orientation to portrait
  await Flame.device.setPortrait();

  /// Set the device full screen
  await Flame.device.fullScreen();

  /// Initialize the game
  final game = FlappyBird();

  /// Run the game
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: [
        ScreenName.mainScreen.name,
      ],
      overlayBuilderMap: {
        ScreenName.mainScreen.name: (context, _) => MenuScreen(game: game),
        ScreenName.gameOverScreen.name: (context, _) =>
            GameOverScreen(game: game),
      },
    ),
  );
}
