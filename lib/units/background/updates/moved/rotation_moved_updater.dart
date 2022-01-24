import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RotationMovedUpdater extends MovedUpdater {

  RotationMovedUpdater.fromJson(Map json) : super.fromJson(json);
  RotationMovedUpdater() {
    init();
  }

  @override
  void init() {
    speed = 100 + random.nextInt(100);
    angleZ = 30 + random.nextInt(150) * random.sign();
  }


  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.forEach((p) {
      p.velocity = p.velocity.rotate(radians(angleZ! * dt));
      p.speed += speed! * dt;
    });
  }
}