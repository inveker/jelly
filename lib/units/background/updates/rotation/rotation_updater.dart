import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/utils/utils.dart';

abstract class RotationUpdater {
  bool? isRandom;
  double? angleX;
  int? angleDirX;
  double? angleY;
  int? angleDirY;
  double? angleZ;
  int? angleDirZ;
  void update(BackgroundUnit context, double dt);
  void init();

  RotationUpdater();

  RotationUpdater.fromJson(Map json) {
    isRandom = json['isRandom'];
    angleX = json['angleX'];
    angleDirX = json['angleDirX'];
    angleY = json['angleY'];
    angleDirY = json['angleDirY'];
    angleZ = json['angleZ'];
    angleDirZ = json['angleDirZ'];
    init();
  }

  Map toJson() {
    return {
      'runtype': this.runtimeType.toString(),
      'isRandom': isRandom,
      'angleX': angleX,
      'angleDirX': angleDirX,
      'angleY': angleY,
      'angleDirY': angleDirY,
      'angleZ': angleZ,
      'angleDirZ': angleDirZ,
    };
  }
}