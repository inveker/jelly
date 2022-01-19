import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class AXRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  Map<BackgroundParticle, Map<String, num>> _particliesRotation = {};

  var r = random.nextInt(300);

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(_particliesRotation[p] == null) {
        var x =  30 + random.nextInt(150);
        _particliesRotation[p] = {
          'angleX': x,
          'dirX': random.sign(),
        };
      }
      if(isRandom) {
        p.rotationX += random.nextInt(_particliesRotation[p]!['angleX']!.toInt()) * _particliesRotation[p]!['dirX']! * dt;
      } else {
        p.rotationX += _particliesRotation[p]!['angleX']! * _particliesRotation[p]!['dirX']! * dt;
      }
    });
  }
}