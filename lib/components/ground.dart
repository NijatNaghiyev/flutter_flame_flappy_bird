import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter_flame_flappy_bird/game/configuration.dart';
import 'package:flutter_flame_flappy_bird/game/flappy_bird.dart';
import 'package:flutter_flame_flappy_bird/generated/assets.dart';

class Ground extends ParallaxComponent<FlappyBird> {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.imagesGround);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    parallax?.baseVelocity.x = Config.gameSpeed;
    super.update(dt);
  }
}
