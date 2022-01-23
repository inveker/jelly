import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class LineMovedUpdater extends MovedUpdater {

  LineMovedUpdater.fromJson(Map json) : super.fromJson(json);
  LineMovedUpdater() {
    init();
  }

  @override
  void init() {
    speed = 100 + random.nextInt(100);
  }

  num? speed;

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.forEach((p) {
      p.speed += speed! * dt;
    });
  }
}