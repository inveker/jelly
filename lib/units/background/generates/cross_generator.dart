import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class CrossGenerator extends Generator {

  double length = random.nextInt(200) + 100;
  double angleZ = random.nextInt(360).toDouble();

  @override
  void update(BackgroundUnit context, double dt) {
    final centerX = context.size!.width / 2;
    final centerY = context.size!.height / 2;

    var radius = (720) / 2;

    var v = Vector2(1, 0).rotate(radians(angleZ)) * length;

    for(var i = 0; i < 5; i++) {
      var position;
      if(i == 0) {
        position = Vector2(centerX, centerY) + v.rotate(radians(270));
      } else if(i == 1) {
        position = Vector2(centerX, centerY) + v;
      } else if(i == 2) {
        position = Vector2(centerX, centerY) + v.rotate(radians(90));
      } else if(i == 3) {
        position = Vector2(centerX, centerY) + v.rotate(radians(180));
      } else if(i == 4) {
        position = Vector2(centerX, centerY);
      }

      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: position,
        ),
      );
    }
  }
}