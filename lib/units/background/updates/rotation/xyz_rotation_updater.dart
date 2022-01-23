import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XYZRotationUpdater extends RotationUpdater {
  late bool? isRandom;
  late double? angleX;
  late int? angleDirX;
  late double? angleY;
  late int? angleDirY;
  late double? angleZ;
  late int? angleDirZ;

  XYZRotationUpdater.fromJson(Map json) : super.fromJson(json);
  XYZRotationUpdater() {
    init();
  }

  @override
  void init() {
    isRandom = random.nextBool();
    angleX = (30.0 + random.nextInt(150));
    angleY = (30.0 + random.nextInt(150));
    angleZ = (30.0 + random.nextInt(150));
    angleDirX = random.sign();
    angleDirY = random.sign();
    angleDirZ = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom!) {
        p.rotationX += random.nextInt(angleX!.toInt()) * angleDirX! * dt;
        p.rotationY += random.nextInt(angleY!.toInt()) * angleDirY! * dt;
        p.rotationZ += random.nextInt(angleZ!.toInt()) * angleDirZ! * dt;
      } else {
        p.rotationX += angleX! * angleDirX! * dt;
        p.rotationY += angleY! * angleDirY! * dt;
        p.rotationZ += angleZ! * angleDirZ! * dt;
      }
    });
  }
}