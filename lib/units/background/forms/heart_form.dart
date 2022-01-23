import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class HeartForm extends FormPaint {
  HeartForm.fromJson(Map json) : super.fromJson(json);
  double? selfRotationZ = 0; //angle < 180
  bool? randomSelfRotation = random.nextBool();
  var selfRotations = {};

  HeartForm() {
    init();
  }

  @override
  void init() {
    selfRotationZ = random.nextInt(60).toDouble() * random.sign();
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
        canvas.drawPath(heart(p.width), Paint()..color = p.color.withAlpha(150));
      } else if (p.type == BackgroundParticleType.light) {
        canvas.drawPath(heart(p.width), Paint()..color = context.colors[0].withAlpha(150));
        canvas.drawPath(heart(p.width*3/4), Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }
      canvas.restore();
    }
  }

  Path? pathHeart;
  Path heart (double width) {
    if(pathHeart == null) {
      double width = 1;
      Path path = Path();
      path.moveTo(0.5 * width, width * 0.35);
      path.cubicTo(0.2 * width, width * 0.1, -0.25 * width, width * 0.6,
          0.5 * width, width);
      path.moveTo(0.5 * width, width * 0.35);
      path.cubicTo(0.8 * width, width * 0.1, 1.25 * width, width * 0.6,
          0.5 * width, width);
      pathHeart = path.transform(Matrix4.translationValues(-width/2, -width/2, 0).storage);
    }

    return pathHeart!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }
}