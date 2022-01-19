import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class AYZRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  Map<BackgroundParticle, Map<String, num>> _particliesRotation = {};

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(_particliesRotation[p] == null) {
        var y =  30 + random.nextInt(150);
        var z =  30 + random.nextInt(150);

        _particliesRotation[p] = {
          'angleY': y,
          'dirY': random.sign(),
          'angleZ': z,
          'dirZ': random.sign(),
        };
      }
      if(isRandom) {
        p.rotationY += random.nextInt(_particliesRotation[p]!['angleY']!.toInt()) * _particliesRotation[p]!['dirY']! * dt;
        p.rotationZ += random.nextInt(_particliesRotation[p]!['angleZ']!.toInt()) * _particliesRotation[p]!['dirZ']! * dt;
      } else {
        p.rotationY += _particliesRotation[p]!['angleY']! * _particliesRotation[p]!['dirY']! * dt;
        p.rotationZ += _particliesRotation[p]!['angleZ']! * _particliesRotation[p]!['dirZ']! * dt;
      }
    });
  }
}