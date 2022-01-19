import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class SquareForm extends FormPaint {
  double selfRotationZ = 0;
  bool randomSelfRotation = random.nextBool();
  var selfRotations = {};

  SquareForm() {
    selfRotationZ = random.nextInt(360).toDouble();
  }

  @override
  void paint(BackgroundUnit context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      var _selfRotation = selfRotationZ;
      if(randomSelfRotation) {
        if(selfRotations[p] == null) {
          selfRotations[p] = random.nextInt(360).toDouble();
        }
        _selfRotation = selfRotations[p];
      }
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ + _selfRotation))).storage);

      if (p.type == BackgroundParticleType.simple) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width, height: p.width),
          Paint()..color = p.color,
        );
      } else if (p.type == BackgroundParticleType.light) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width, height: p.width),
          Paint()
            ..color = context.colors[0].withAlpha(150)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)),
        );
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width / 2, height: p.width / 2),
          Paint()..color =  p.color.withAlpha(250),
        );
      }
      canvas.restore();
    }
  }
}