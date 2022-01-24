import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RandomPointsGenerator extends Generator {
  RandomPointsGenerator.fromJson(Map json) : super.fromJson(json);

  double? length;
  double? angleZ;


  int? particleCount;
  late List<Vector2>? points;

  RandomPointsGenerator() {
    init();
  }

  @override
  void init() {
    length = random.nextInt(200) + 100;
    angleZ = random.nextInt(360).toDouble();
    particleCount = 1 + random.nextInt(5);
    points = [];
    for(var i = 0; i < particleCount!; i ++) {
      points!.add(Vector2(random.nextInt(pictureSize.width.toInt()).toDouble(), random.nextInt(pictureSize.width.toInt()).toDouble()));
    }
  }

  @override
  void update(BackgroundUnit context, double dt) {

    for(var point in points!) {
      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: point,
        ),
      );
    }
  }
}