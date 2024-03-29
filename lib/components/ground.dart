import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

class Ground extends ParallaxComponent<FlappyBird> with HasGameRef<FlappyBird> {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.imagesGround);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);

    add(
      RectangleHitbox(
        size: Vector2(
          gameRef.size.x,
          Config.groundHeight,
        ),
        position: Vector2(
          0,
          gameRef.size.y - Config.groundHeight,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    parallax?.baseVelocity.x = Config.gameSpeed;
    super.update(dt);
  }
}
