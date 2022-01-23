import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/utils/vector2.dart';

abstract class Generator {
  int? particleCount;
  Vector2? position;
  Vector2? velocity;
  double? ang;
  double? speed;
  int? angleDir;
  double? length;
  double? angleZ;
  List<Vector2>? points;
  void update(BackgroundUnit context, double dt);


  Generator();

  void init();

  Generator.fromJson(Map json) {
    particleCount = json['particleCount'];
    position = json['position'] != null ? Vector2.fromJson(json['position']) : null;
    velocity = json['velocity'] != null ? Vector2.fromJson(json['velocity']) : null;
    ang = json['ang'];
    speed = json['speed'];
    angleDir = json['angleDir'];
    length = json['length'];
    angleZ = json['angleZ'];
    points = json['points']?.map((e) => Vector2.fromJson(e)).toList().cast<Vector2>();
    init();
  }

  Map toJson() {
    return {
      'runtype': this.runtimeType.toString(),
      'particleCount': particleCount,
      'position': position?.toJson(),
      'velocity': velocity?.toJson(),
      'ang': ang,
      'speed': speed,
      'angleDir': angleDir,
      'length': length,
      'angleZ': angleZ,
      'points': points?.map((e) => e.toJson()).toList().cast<Vector2>(),
    };
  }
}