import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XYRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleX = 0;
  int angleDirX = 1;
  double angleY = 0;
  int angleDirY = 1;

  XYRotationUpdater() {
    isRandom = random.nextBool();
    angleX = (30.0 + random.nextInt(150));
    angleY = (30.0 + random.nextInt(150));
    angleDirX = random.sign();
    angleDirY = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationX += random.nextInt(angleX.toInt()) * angleDirX * dt;
        p.rotationY += random.nextInt(angleY.toInt()) * angleDirY * dt;
      } else {
        p.rotationX += angleX * angleDirX * dt;
        p.rotationY += angleY * angleDirY * dt;
      }
    });
  }
}