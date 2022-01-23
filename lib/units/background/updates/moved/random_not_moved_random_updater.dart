import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RandomNotMovedRandomUpdater extends MovedUpdater {

  RandomNotMovedRandomUpdater.fromJson(Map json) : super.fromJson(json);
  RandomNotMovedRandomUpdater() {
    init();
  }

  @override
  void init() {
    // TODO: implement init
  }

  Map<BackgroundParticle, Vector2> particles = {};

  void update(BackgroundUnit context, double dt) {
    context.particles.forEach((p) {
      if(particles[p] == null) {
        particles[p] = random.nextBool() ? Vector2.zero() :  Vector2.random() * 1;
      }
      p.velocity = particles[p]!;
    });
  }
}