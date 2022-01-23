import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class XRotationUpdater extends RotationUpdater {

  XRotationUpdater.fromJson(Map json) : super.fromJson(json);

  late bool? isRandom;
  late double? angleX;
  late int? angleDirX;

  XRotationUpdater() {
   init();
  }

  @override
  void init() {
    isRandom = random.nextBool();
    angleX = (30.0 + random.nextInt(150));
    angleDirX = random.sign();
  }

  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(isRandom!) {
        p.rotationX += random.nextInt(angleX!.toInt()) * angleDirX! * dt;
      } else {
        p.rotationX += angleX! * angleDirX! * dt;
      }
    });
  }
}