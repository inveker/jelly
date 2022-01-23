import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class YRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleY = 0;
  int angleDirY = 1;

  YRotationUpdater() {
    isRandom = random.nextBool();
    angleY = (30.0 + random.nextInt(150));
    angleDirY = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationY += random.nextInt(angleY.toInt()) * angleDirY * dt;
      } else {
        p.rotationY += angleY * angleDirY * dt;
      }
    });
  }
}