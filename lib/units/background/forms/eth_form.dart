import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class EthForm extends FormPaint {
  double selfRotationZ = 0; //angle < 180
  bool randomSelfRotation = random.nextBool();
  var selfRotations = {};

  EthForm() {
    selfRotationZ = random.nextInt(60).toDouble() * random.sign();
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

        canvas.drawPath(allTop(p.width), Paint()..color = p.color.withAlpha((150 * 0.4).toInt()));
        canvas.drawPath(center(p.width), Paint()..color = p.color.withAlpha((150 * 0.4).toInt()));
        canvas.drawPath(topRight(p.width), Paint()..color = p.color.withAlpha((150 * 0.4).toInt()));
        canvas.drawPath(bottom(p.width), Paint()..color = p.color.withAlpha((150 * 0.4).toInt()));
        canvas.drawPath(bottomRight(p.width), Paint()..color = p.color.withAlpha((150 * 0.4).toInt()));


      } else if (p.type == BackgroundParticleType.light) {
        canvas.drawPath(all(p.width), Paint()..color = context.colors[0].withAlpha((150).toInt()));

        var paint = Paint()
          ..color = p.color.withAlpha((250 * 0.4).toInt())
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2));
        canvas.drawPath(allTop(p.width/2), paint);
        canvas.drawPath(center(p.width/2), paint);
        canvas.drawPath(topRight(p.width/2), paint);
        canvas.drawPath(bottom(p.width/2), paint);
        canvas.drawPath(bottomRight(p.width/2), paint);

      }
      canvas.restore();
    }
  }

  Path? allTopPath;
  Path allTop(double width) {
    allTopPath ??= Path()
      ..moveTo(-(1 * 0.6)/ 2, 0)
      ..lineTo(0, -1 / 2)
      ..lineTo((1 * 0.6) / 2, 0)
      ..lineTo(0, (1 * 0.3) / 2)
      ..close()
    ;
    return allTopPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }

  Path? centerPath;
  Path center(double width) {
    centerPath ??= Path()
      ..moveTo(-(1 * 0.6)/ 2, 0)
      ..lineTo(0, -(1 * 0.3) / 2)
      ..lineTo((1 * 0.6) / 2, 0)
      ..lineTo(0, (1 * 0.3) / 2)
      ..close();
    return centerPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }

  Path? topRightPath;
  Path topRight(double width) {
    topRightPath ??= Path()
      ..moveTo(0, -1 / 2)
      ..lineTo((1 * 0.6) / 2, 0)
      ..lineTo(0, (1 * 0.3) / 2)
      ..close();
    return topRightPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }

  Path? bottomPath;
  Path bottom(double width) {
    bottomPath ??= Path()
      ..moveTo(-(1 * 0.6)/ 2, 1 * 0.05)
      ..lineTo(0, 1 / 2)
      ..lineTo((1 * 0.6) / 2,  1 * 0.05)
      ..lineTo(0, (1 * 0.3) / 2 + 1 * 0.05)
      ..close();
    return bottomPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }

  Path? bottomRightPath;
  Path bottomRight(double width) {
    bottomRightPath ??= Path()
      ..moveTo(0, 1 / 2)
      ..lineTo((1 * 0.6) / 2,  1 * 0.05)
      ..lineTo(0, (1 * 0.3) / 2 + 1 * 0.05)
      ..close();
    return bottomRightPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }

  Path? allPath;
  Path all(double width) {
    allPath ??= Path()
        ..moveTo(-(1 * 0.6)/ 2, 0)
        ..lineTo(0, -1 / 2)
        ..lineTo((1 * 0.6) / 2, 0)
        ..lineTo(0, 1  / 2)
        ..close();
    return allPath!.transform((Matrix4(
      width, 0, 0, 0,
      0,  width, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    )).storage);
  }
}