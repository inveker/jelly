import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class AZRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  Map<BackgroundParticle, Map<String, num>> _particliesRotation = {};

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(_particliesRotation[p] == null) {
        var z =  30 + random.nextInt(150);

        _particliesRotation[p] = {
          'angleZ': z,
          'dirZ': random.sign(),
        };
      }
      if(isRandom) {
        p.rotationZ += random.nextInt(_particliesRotation[p]!['angleZ']!.toInt()) * _particliesRotation[p]!['dirZ']! * dt;
      } else {
        p.rotationZ += _particliesRotation[p]!['angleZ']! * _particliesRotation[p]!['dirZ']! * dt;
      }
    });
  }
}