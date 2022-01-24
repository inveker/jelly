import 'package:nft_creator/apps/recorder_app.dart';
import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class CenterMovedRotationGenerator extends Generator {
  CenterMovedRotationGenerator.fromJson(Map json) : super.fromJson(json);

  double? paddingRight;
  double? paddingTop;

  CenterMovedRotationGenerator() {
    init();
  }

  late Vector2? currentPosition;
  late Vector2? currentVelocity;
  late int? currentAngleDir;

  @override
  void init() {
    print('here');
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
    reset();
  }

  reset() {
    currentPosition = position!.copy();
    currentVelocity = velocity!.copy();
    currentAngleDir = angleDir;
  }

  @override
  void update(BackgroundUnit context, double dt) {
    double x = currentVelocity!.x;
    double y = currentVelocity!.y;
    if(currentPosition!.x < paddingRight! || currentPosition!.x > pictureSize.width - paddingRight!) {
      x = -x;
      if(random.nextBool()) currentAngleDir = currentAngleDir! * -1;
    }
    if(currentPosition!.y < paddingTop! || currentPosition!.y > pictureSize.height - paddingTop!) {
      y = -y;
      if(random.nextBool()) currentAngleDir = currentAngleDir! * -1;
    }
    currentVelocity = Vector2(x, y);
    currentPosition = currentPosition! + currentVelocity! * speed! * dt;

    currentVelocity = currentVelocity!.rotate(radians(currentAngleDir! * ang! * dt));


    for (var i = 0; i < particleCount!; i++) {
      context.particles.add(
        BackgroundParticle(
          colors: context.colors,
          position: currentPosition!,
        ),
      );
    }
  }
}
