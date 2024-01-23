import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/flappy_bird.dart';

void main() {
  final game = FlappyBird();
  runApp(
    GameWidget(game: game),
  );
}
