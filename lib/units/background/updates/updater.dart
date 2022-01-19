import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class Updater {

  final MovedUpdater movedUpdater;
  final RotationUpdater rotationUpdater;
  var widthSpeed = 1;

  Updater({
    required this.movedUpdater,
    required this.rotationUpdater,
  }) {
    widthSpeed = random.nextInt(3) + 3;
  }


  void update(BackgroundUnit context, double dt) {
    movedUpdater.update(context, dt);
    rotationUpdater.update(context, dt);
    context.particles.toList().forEach((p) {

      p.position += (p.velocity) * dt * p.speed;

      var newOpacity = p.color.opacity - 0.3 * dt;
      if (newOpacity < 0) newOpacity = 0;
      p.color = p.color.withOpacity(newOpacity);

      if(p.width > 0) {
        p.width += (p.width) * widthSpeed * dt;
      } else {
        p.width = 0;
      }

      bool notOpacity = p.color.opacity == 0;
      bool notSize = p.width <= 0;
      if (notOpacity || notSize) {
        context.particles.remove(p);
      }
    });
  }
}