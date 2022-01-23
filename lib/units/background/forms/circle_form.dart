import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';


class CircleForm extends FormPaint {
  CircleForm.fromJson(Map json) : super.fromJson(json);

  CircleForm() {
    init();
  }

  @override
  void init() {

  }

  @override
  void paint(BackgroundUnit context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ))).storage);

      if (p.type == BackgroundParticleType.simple) {
        canvas.drawCircle(Offset.zero, p.width, Paint()..color = p.color.withAlpha(150));
      } else if (p.type == BackgroundParticleType.light) {
        canvas.drawCircle(Offset.zero, p.width, Paint()..color = context.colors[0].withAlpha(150));
        canvas.drawCircle(Offset.zero, p.width / 2, Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }

      canvas.restore();
    }
  }
}
