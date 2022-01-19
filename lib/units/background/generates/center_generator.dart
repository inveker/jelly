import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/vector2.dart';

class CenterGenerator extends Generator {
  @override
  void update(BackgroundUnit context, double dt) {
    final centerX = context.size!.width / 2;
    final centerY = context.size!.height / 2;

    var radius = (720) / 2;

    for(var i = 0; i < 5; i++) {
      var position = Vector2(centerX, centerY);

      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: position,
        ),
      );
    }
  }
}