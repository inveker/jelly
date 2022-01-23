import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/colors.dart';
import 'package:nft_creator/units/background/forms/circle_form.dart';
import 'package:nft_creator/units/background/forms/eth_form.dart';
import 'package:nft_creator/units/background/forms/heart_form.dart';
import 'package:nft_creator/units/background/forms/square_form.dart';
import 'package:nft_creator/units/background/forms/star_form.dart';
import 'package:nft_creator/units/background/forms/triangle_form.dart';
import 'package:nft_creator/units/background/generates/center_generator.dart';
import 'package:nft_creator/units/background/generates/center_moved_rotation_generator.dart';
import 'package:nft_creator/units/background/generates/circle_multiply_generator.dart';
import 'package:nft_creator/units/background/generates/circle_generator.dart';
import 'package:nft_creator/units/background/generates/cross_generator.dart';
import 'package:nft_creator/units/background/generates/random_points_generator.dart';
import 'package:nft_creator/units/background/generates/random_points_multiply_generator.dart';
import 'package:nft_creator/units/background/updates/moved/chaotic_moved_updater.dart';
import 'package:nft_creator/units/background/updates/moved/line_moved_updater.dart';
import 'package:nft_creator/units/background/updates/moved/not_moved_updater.dart';
import 'package:nft_creator/units/background/updates/moved/random_not_moved_linear_updater.dart';
import 'package:nft_creator/units/background/updates/moved/random_not_moved_random_updater.dart';
import 'package:nft_creator/units/background/updates/moved/rotation_moved_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/ax_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/axy_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/axyz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/axz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/ay_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/ayz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/az_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/not_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/x_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/xy_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/xyz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/xz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/y_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/yz_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/rotation/z_rotation_updater.dart';
import 'package:nft_creator/units/background/updates/updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'apps/recorder_app.dart';
import 'apps/renderer_app.dart';
import 'units/unit.dart';



final isDev = true;


final pictureSize = Size(600, 600);

void main() async {
  if(isDev) {
    final Scene scene = Scene();
    runApp(RendererApp(
      scene: scene,
    ));
  } else {
    var count = 30;
    var time = DateTime.now().millisecondsSinceEpoch;
    for(var i = 0; i < count; i++)  {
      print('start $i');
      await recorderApp(Scene());
    }
    print('All success: ${(DateTime.now().millisecondsSinceEpoch - time) / 1000}sec');
    print('AVG time: ${(DateTime.now().millisecondsSinceEpoch - time) / count}ms');
  }
}

class Scene extends Unit {
  late BackgroundUnit backgroundUnit;

  String name = '_';

  var i = 0;

  Scene() {
    List<List<Color>> palettes = allPalettes;

    var forms = [
          () => EthForm(),
          () => TriangleForm(),
          () => CircleForm(),
          () => StarForm(),
      () => SquareForm(),
      () => HeartForm(),
    ];

    var generators = [
          () => CenterGenerator(),
          () => RandomPointsMultiplyGenerator(),
          () => RandomPointsGenerator(),
          () => CircleMultiplyGenerator(),
          () => CircleGenerator(),
          () => CrossGenerator(),
          () => CenterMovedRotationGenerator(),
    ];


    var movedUpdaters = [
          () => RandomNotMovedLinearUpdater(),
          () => RandomNotMovedRandomUpdater(),
          () => RotationMovedUpdater(),
          () => NotMovedUpdater(),
          () => LineMovedUpdater(),
          () => ChaoticMovedUpdater(),
    ];

    var rotationUpdaters = [
      () => NotRotationUpdater(),
      () => XRotationUpdater(),
      () => YRotationUpdater(),
      () => ZRotationUpdater(),
      () => XYRotationUpdater(),
      () => XZRotationUpdater(),
      () => YZRotationUpdater(),
      () => XYZRotationUpdater(),
      () => AXRotationUpdater(),
      () => AYRotationUpdater(),
      () => AZRotationUpdater(),
      () => AXYRotationUpdater(),
      () => AXZRotationUpdater(),
      () => AYZRotationUpdater(),
      () => AXYZRotationUpdater(),
    ];

    if(isDev) {
      var count = 0;
      for(var palette in [palettes.first]) {
        for(var movedUpdater in movedUpdaters) {
          for(var form in forms) {
            for(var generator in generators) {
              for(var rotationUpdater in rotationUpdaters) {
                var type = rotationUpdater().runtimeType;
                if(form().runtimeType == CircleForm().runtimeType
                    && (type == ZRotationUpdater().runtimeType
                        || type == XZRotationUpdater().runtimeType
                        || type == YZRotationUpdater().runtimeType
                        || type == XYZRotationUpdater().runtimeType)
                ) {
                  continue;
                }
                var updater = Updater(movedUpdater: movedUpdater(), rotationUpdater: rotationUpdater());
                count++;

              }
            }
          }
        }
      }
      print('ALL COUNTS == ${count}!');
    }

    var mU = random.nextInt(movedUpdaters.length);
    var rU = random.nextInt(rotationUpdaters.length);
    var aP = random.nextInt(allPalettes.length);
    var f = random.nextInt(forms.length);
    var g = random.nextInt(generators.length);
    name = 'mU${mU}_rU${rU}_ap${aP}_f${f}_g$g';

    var upd = Updater(movedUpdater: movedUpdaters[mU](), rotationUpdater: rotationUpdaters[rU]());

    var count = random.nextInt(3) + 2;

    var p = <Color>[];
    for(var i = 0; i < count; i++) {
      p.add(randomRealColor());
    }

    backgroundUnit = BackgroundUnit(
      colors: p,//allPalettes[aP],
      formPaint: forms[f](),
      updater: upd,
      generator: generators[g](),
    );

    if(isDev) {
      Timer.periodic(Duration(seconds: 5), (timer) {

        var mU = random.nextInt(movedUpdaters.length);
        var rU = random.nextInt(rotationUpdaters.length);
        var aP = random.nextInt(allPalettes.length);
        var f = random.nextInt(forms.length);
        var g = random.nextInt(generators.length);
        name = 'mU${mU}_rU${rU}_ap${aP}_f${f}_g$g';
        // print('name $name');

        var p = <Color>[];
        for(var i = 0; i < count; i++) {
          p.add(randomRealColor());
        }
        var upd = Updater(movedUpdater: movedUpdaters[mU](), rotationUpdater: rotationUpdaters[rU]());
        backgroundUnit = BackgroundUnit(
          colors: p,//allPalettes[aP],
          formPaint: forms[f](),
          updater: upd,
          generator: generators[g](),
        );
      });
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black);
    if(isDev) {
      canvas.drawRect(
          Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: pictureSize.width-2, height: pictureSize.height-2),
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke);
    }

    backgroundUnit.paint(canvas, size);

    final textStyle = GoogleFonts.shadowsIntoLight().copyWith(
      color: Colors.black,
      fontSize: 30,
    );

    final textSpan = TextSpan(
      text: 'VisualEcstasy',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(size.width - 148, size.height - 50);
    textPainter.paint(canvas, offset);
  }

  @override
  void update(double dt) {
    backgroundUnit.update(dt);
  }
}
