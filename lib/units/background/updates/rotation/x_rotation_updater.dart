import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  double angleX = 0;
  int angleDirX = 1;

  XRotationUpdater() {
    isRandom = random.nextBool();
    angleX = 10.0 + random.nextInt(350);
    angleDirX = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom) {
        p.rotationX += random.nextInt(angleX.toInt()) * angleDirX * dt;
      } else {
        p.rotationX += angleX * angleDirX * dt;
      }
    });
  }
}