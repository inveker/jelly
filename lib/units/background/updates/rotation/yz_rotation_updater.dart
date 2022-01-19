import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class YZRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleY = 0;
  int angleDirY = 1;
  double angleZ = 0;
  int angleDirZ = 1;

  YZRotationUpdater() {
    isRandom = random.nextBool();
    angleY = 10.0 + random.nextInt(350);
    angleZ = 10.0 + random.nextInt(350);
    angleDirY = random.sign();
    angleDirZ = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationY += random.nextInt(angleY.toInt()) * angleDirY * dt;
        p.rotationZ += random.nextInt(angleZ.toInt()) * angleDirZ * dt;
      } else {
        p.rotationY += angleY * angleDirY * dt;
        p.rotationZ += angleZ * angleDirZ * dt;
      }
    });
  }
}