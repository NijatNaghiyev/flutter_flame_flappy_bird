import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_flame_flappy_bird/enum/bird_movement.dart';
import 'package:flutter_flame_flappy_bird/enum/screen_name.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBird>, CollisionCallbacks {
  Bird();

  /// When OnTap, the bird will go up
  void onTap() {
    /// Current is middle, so we need to go up
    current = BirdMovement.up;

    /// Add the effect to go up
    add(
      MoveByEffect(
        Vector2(0, Config.birdFly),
        EffectController(
          duration: .3,
          curve: Curves.fastOutSlowIn,
        ),

        /// When the effect is complete, go down
        onComplete: () => current = BirdMovement.down,
      ),
    );
  }

  /// When the bird collides with something, the game is over
  void gameOver() {
    /// Set the game over flag
    game.isGameOver = true;

    /// Stop the game
    gameRef.pauseEngine();

    /// Add the game over screen
    game.overlays.add(ScreenName.gameOverScreen.name);
  }

  /// Reset the bird position
  void reset() {
    position = Vector2(50, (gameRef.size.y - Config.groundHeight) / 2);
  }

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

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.y += Config.birdGravity * dt;
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    /// When the bird collides with something, the game is over
    gameOver();
  }
}
