import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RandomPointsGenerator extends Generator {

  double length = random.nextInt(200) + 100;
  double angleZ = random.nextInt(360).toDouble();


  late List<Vector2> points;

  RandomPointsGenerator() {
    int count = 2 + random.nextInt(3);
    points = [];
    for(var i = 0; i < count; i ++) {
      points.add(Vector2(random.nextInt(720).toDouble(), random.nextInt(720).toDouble()));
    }
  }

  @override
  void update(BackgroundUnit context, double dt) {
    final centerX = context.size!.width / 2;
    final centerY = context.size!.height / 2;

    var radius = (720) / 2;

    var v = Vector2(1, 0).rotate(radians(angleZ)) * length;

    for(var point in points) {
      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: point,
        ),
      );
    }
  }
}