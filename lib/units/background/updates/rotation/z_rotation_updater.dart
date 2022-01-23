import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class ZRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleZ = 0;
  int angleDirZ = 1;

  ZRotationUpdater() {
    isRandom = random.nextBool();
    angleZ = (30.0 + random.nextInt(150));
    angleDirZ = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationZ += random.nextInt(angleZ.toInt()) * angleDirZ * dt;
      } else {
        p.rotationZ += angleZ * angleDirZ * dt;
      }
    });
  }
}