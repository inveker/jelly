import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';


class StarForm extends FormPaint {


  double selfRotationZ = 0;
  bool randomSelfRotation = random.nextBool();
  var selfRotations = {};

  StarForm() {
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
        canvas.drawPath(getStar(p.width), Paint()..color = p.color.withAlpha(150));
      } else if (p.type == BackgroundParticleType.light) {
        canvas.drawPath(getStar(p.width), Paint()..color = context.colors[0].withAlpha(150));
        canvas.drawPath(getStar(p.width/2), Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }

      canvas.restore();
    }
  }


  Path? pathStar;
  Path getStar(dynamic width) {
    if(pathStar == null) {
      double width = 1;
      Path path = Path();
      double max = 2 * pi;

      double halfWidth = width / 2;

      double wingRadius = halfWidth;
      double radius = halfWidth / 2;

      double degreesPerStep = radians(360 / 5);
      double halfDegreesPerStep = degreesPerStep / 2;

      path.moveTo(width, halfWidth);

      for (double step = 0; step < max; step += degreesPerStep) {
        path.lineTo(halfWidth + wingRadius * cos(step),
            halfWidth + wingRadius * sin(step));
        path.lineTo(halfWidth + radius * cos(step + halfDegreesPerStep),
            halfWidth + radius * sin(step + halfDegreesPerStep));
      }

      path.close();
      pathStar = path.transform(Matrix4.translationValues(-width/2, -width/2, 1).storage);
    }


    return pathStar!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }
}
