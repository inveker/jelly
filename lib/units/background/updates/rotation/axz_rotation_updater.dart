import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class AXZRotationUpdater extends RotationUpdater {
  AXZRotationUpdater.fromJson(Map json) : super.fromJson(json);
  AXZRotationUpdater() {
    init();
  }

  @override
  void init() {
    isRandom = random.nextBool();
  }

  bool? isRandom;
  Map<BackgroundParticle, Map<String, num>> _particliesRotation = {};

  @override
  void update(BackgroundUnit context, double dt) {
    context.particles.toList().forEach((p) {
      if(_particliesRotation[p] == null) {
        var x =  30 + random.nextInt(150);
        var z =  30 + random.nextInt(150);

        _particliesRotation[p] = {
          'angleX': x,
          'dirX': random.sign(),
          'angleZ': z,
          'dirZ': random.sign(),
        };
      }
      if(isRandom!) {
        p.rotationX += random.nextInt(_particliesRotation[p]!['angleX']!.toInt()) * _particliesRotation[p]!['dirX']! * dt;
        p.rotationZ += random.nextInt(_particliesRotation[p]!['angleZ']!.toInt()) * _particliesRotation[p]!['dirZ']! * dt;
      } else {
        p.rotationX += _particliesRotation[p]!['angleX']! * _particliesRotation[p]!['dirX']! * dt;
        p.rotationZ += _particliesRotation[p]!['angleZ']! * _particliesRotation[p]!['dirZ']! * dt;
      }
    });
  }
}