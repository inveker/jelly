import 'package:nft_creator/apps/recorder_app.dart';
import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class CenterMovedRotationGenerator extends Generator {
  CenterMovedRotationGenerator.fromJson(Map json) : super.fromJson(json);
  late int? particleCount;
  late Vector2? position;
  late Vector2? velocity;
  late double? ang;
  late double? speed;
  late int? angleDir;

  double? paddingRight;
  double? paddingTop;

  CenterMovedRotationGenerator() {
    init();
  }

  @override
  void init() {
    ang = 30.0 + random.nextInt(721 - 30);
    speed = 30.0 + random.nextInt(1601 - 30);
    particleCount = 1 + random.nextInt(5);
    velocity = Vector2.random();
    paddingRight = pictureSize.width * 0.1;
    paddingTop = pictureSize.height * 0.1;
    position = Vector2(
        paddingRight! * 2 + random.nextInt((pictureSize.width - paddingRight! * 4).toInt()).toDouble(),
        paddingTop! * 2 + random.nextInt((pictureSize.height - paddingTop! * 4).toInt()).toDouble()
    );

    angleDir = random.sign();
  }

  @override
  void update(BackgroundUnit context, double dt) {
    double x = velocity!.x;
    double y = velocity!.y;
    if(position!.x < paddingRight! || position!.x > pictureSize.width - paddingRight!) {
      x = -x;
      if(random.nextBool()) angleDir = angleDir! * -1;
    }
    if(position!.y < paddingTop! || position!.y > pictureSize.height - paddingTop!) {
      y = -y;
      if(random.nextBool()) angleDir = angleDir! * -1;
    }
    velocity = Vector2(x, y);
    position = position! + velocity! * speed! * dt;

    velocity = velocity!.rotate(radians(angleDir! * ang! * dt));


    for (var i = 0; i < particleCount!; i++) {
      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: position!,
        ),
      );
    }
  }
}
