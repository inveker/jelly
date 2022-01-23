import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';


// создает 2 точки которые крутятся по кругу
// + версия где они еще притягиваются
class TwoDanceGenerator extends Generator {
  TwoDanceGenerator.fromJson(Map json) : super.fromJson(json);

  TwoDanceGenerator() {
    init();
  }

  @override
  void init() {

  }

  int? particleCount = 1 + random.nextInt(5);
  @override
  void update(BackgroundUnit context, double dt) {
    final centerX = context.size!.width / 2;
    final centerY = context.size!.height / 2;

    var radius = (pictureSize.width) / 2;

    for(var i = 0; i < particleCount!; i++) {
      var position = Vector2.random() * radius + Vector2(centerX, centerY);

      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: position,
        ),
      );
    }
  }

}