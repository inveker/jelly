import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XZRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleX = 0;
  int angleDirX = 1;
  double angleZ = 0;
  int angleDirZ = 1;

  XZRotationUpdater() {
    isRandom = random.nextBool();
    angleX = 10.0 + random.nextInt(350);
    angleZ = 10.0 + random.nextInt(350);
    angleDirX = random.sign();
    angleDirZ = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationX += random.nextInt(angleX.toInt()) * angleDirX * dt;
        p.rotationZ += random.nextInt(angleZ.toInt()) * angleDirZ * dt;
      } else {
        p.rotationX += angleX * angleDirX * dt;
        p.rotationZ += angleZ * angleDirZ * dt;
      }
    });
  }
}