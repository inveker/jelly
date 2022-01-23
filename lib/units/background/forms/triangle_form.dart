import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';


class TriangleForm extends FormPaint {
  TriangleForm.fromJson(Map json) : super.fromJson(json);

  double? selfRotationZ = 0;
  bool? randomSelfRotation = random.nextBool();
  var selfRotations = {};

  TriangleForm() {
    init();
  }

  @override
  void init() {
    selfRotationZ = random.nextInt(360).toDouble();
  }

  @override
  void paint(BackgroundUnit context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      var _selfRotation = selfRotationZ;
      if(randomSelfRotation!) {
        if(selfRotations[p] == null) {
          selfRotations[p] = random.nextInt(360).toDouble();
        }
        _selfRotation = selfRotations[p];
      }
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ + _selfRotation!))).storage);


      if (p.type == BackgroundParticleType.simple) {
        var path = Path();
        path
          ..moveTo(-p.width/2, p.width/3)
          ..lineTo(0, -2*p.width/3)
          ..lineTo(p.width/2, p.width/3)
          ..close();
        canvas.drawPath(path, Paint()..color = p.color.withAlpha(150));
      } else if (p.type == BackgroundParticleType.light) {
        var path1 = Path();
        path1
          ..moveTo(-p.width/2, p.width/3)
          ..lineTo(0, -2*p.width/3)
          ..lineTo(p.width/2, p.width/3)
          ..close();

        canvas.drawPath(path1, Paint()..color = context.colors[0].withAlpha(150));

        var path2 = Path();
        path2
          ..moveTo(-(p.width / 2)/2, (p.width / 2)/3)
          ..lineTo(0, -2*(p.width / 2)/3)
          ..lineTo((p.width / 2)/2, (p.width / 2)/3)
          ..close();
        canvas.drawPath(path2, Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }
      canvas.restore();
    }
  }
}