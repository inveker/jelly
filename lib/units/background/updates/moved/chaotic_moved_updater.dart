import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class ChaoticMovedUpdater extends MovedUpdater {

  ChaoticMovedUpdater.fromJson(Map json) : super.fromJson(json);
  ChaoticMovedUpdater() {
    init();
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.forEach((p) {
      p.velocity += Vector2.random();
      p.speed += 100 * dt;
    });
  }
}