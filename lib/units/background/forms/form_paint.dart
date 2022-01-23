import 'dart:ui';

import 'package:nft_creator/units/background/backgound_unit.dart';

abstract class FormPaint {
  double? selfRotationZ;
  bool? randomSelfRotation;
  void paint(BackgroundUnit context, Canvas canvas, Size size);
  void init();

  FormPaint({
    this.selfRotationZ,
    this.randomSelfRotation,
  }) {
    init();
  }

  FormPaint.fromJson(Map json) {
    selfRotationZ = json['selfRotationZ'];
    randomSelfRotation = json['randomSelfRotation'];
    init();
  }

  Map toJson() {
    return {
      'runtype': this.runtimeType.toString(),
      'selfRotationZ': selfRotationZ,
      'randomSelfRotation': randomSelfRotation,
    };
  }
}