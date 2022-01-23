import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XZRotationUpdater extends RotationUpdater {
  bool? isRandom;
  double? angleX;
  int? angleDirX;
  double? angleZ;
  int? angleDirZ;
  XZRotationUpdater.fromJson(Map json) : super.fromJson(json);

  XZRotationUpdater() {
    init();
  }

  init() {
    isRandom = random.nextBool();
    angleX = (30.0 + random.nextInt(150));
    angleZ = (30.0 + random.nextInt(150));
    angleDirX = random.sign();
    angleDirZ = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom!) {
        p.rotationX += random.nextInt(angleX!.toInt()) * angleDirX! * dt;
        p.rotationZ += random.nextInt(angleZ!.toInt()) * angleDirZ! * dt;
      } else {
        p.rotationX += angleX! * angleDirX! * dt;
        p.rotationZ += angleZ! * angleDirZ! * dt;
      }
    });
  }
}