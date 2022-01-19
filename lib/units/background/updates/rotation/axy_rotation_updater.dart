import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class AXYRotationUpdater extends RotationUpdater {
  bool isRandom = false;
  Map<BackgroundParticle, Map<String, num>> _particliesRotation = {};

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(_particliesRotation[p] == null) {
        var x =  30 + random.nextInt(150);
        var y =  30 + random.nextInt(150);

        _particliesRotation[p] = {
          'angleX': x,
          'dirX': random.sign(),
          'angleY': y,
          'dirY': random.sign(),
        };
      }
      if(isRandom) {
        p.rotationX += random.nextInt(_particliesRotation[p]!['angleX']!.toInt()) * _particliesRotation[p]!['dirX']! * dt;
        p.rotationY += random.nextInt(_particliesRotation[p]!['angleY']!.toInt()) * _particliesRotation[p]!['dirY']! * dt;
      } else {
        p.rotationX += _particliesRotation[p]!['angleX']! * _particliesRotation[p]!['dirX']! * dt;
        p.rotationY += _particliesRotation[p]!['angleY']! * _particliesRotation[p]!['dirY']! * dt;
      }
    });
  }
}