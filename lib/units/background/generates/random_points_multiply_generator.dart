import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class RandomPointsMultiplyGenerator extends Generator {
  RandomPointsMultiplyGenerator.fromJson(Map json) : super.fromJson(json);

  double? length;
  double? angleZ;

  int? particleCount;

  late List<Vector2>? points;

  RandomPointsMultiplyGenerator() {
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
    final centerX = context.size!.width / 2;
    final centerY = context.size!.height / 2;

    var radius = (pictureSize.width) / 2;

    var v = Vector2(1, 0).rotate(radians(angleZ!)) * length!;

    var p = random.nextInt(points!.length);
    for(var i = 0; i < particleCount!; i++) {
      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: points![p],
        ),
      );
    }
  }
}