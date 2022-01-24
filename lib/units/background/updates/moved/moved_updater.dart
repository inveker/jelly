import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

abstract class MovedUpdater {
  num? speed;
  List<Vector2>? tails;
  num? angleZ;
  void update(BackgroundUnit context, double dt);
  void init();

  MovedUpdater();

  MovedUpdater.fromJson(Map json) {
    speed = json['speed'];
    tails = json['tails']?.map((e) => Vector2.fromJson(e)).toList().cast<Vector2>();
    angleZ = json['angleZ'];
    init();
  }

  Map toJson() {
    return {
      'runtype': this.runtimeType.toString(),
      'speed': speed,
      'tails': tails?.map((e) => e.toJson()).toList(),
      'angleZ': angleZ,
    };
  }
}