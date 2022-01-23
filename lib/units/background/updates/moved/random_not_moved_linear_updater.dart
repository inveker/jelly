import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RandomNotMovedLinearUpdater extends MovedUpdater {

  RandomNotMovedLinearUpdater.fromJson(Map json) : super.fromJson(json);

  Map<BackgroundParticle, Vector2> particles = {};
  List<Vector2>? tails;

  RandomNotMovedLinearUpdater() {
    init();
  }

  @override
  void init() {
    particles = {};
    tails = [];
    var tailsCount = random.nextInt(5) + 1;
    for(var i = 0; i < tailsCount; i++) {
      tails!.add( Vector2.random() * (2 + random.nextInt(2)));
    }
  }

  void update(BackgroundUnit context, double dt) {

    context.particles.forEach((p) {
      if(particles[p] == null) {
        particles[p] = random.nextBool() ? Vector2.zero() : tails![random.nextInt(tails!.length)];
      }
      p.velocity = particles[p]!;
    });
  }
}