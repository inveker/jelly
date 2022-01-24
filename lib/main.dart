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
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/units/background/generates/random_points_generator.dart';
import 'package:nft_creator/units/background/generates/random_points_multiply_generator.dart';
import 'package:nft_creator/units/background/palette.dart';
import 'package:nft_creator/units/background/updates/moved/chaotic_moved_updater.dart';
import 'package:nft_creator/units/background/updates/moved/line_moved_updater.dart';
import 'package:nft_creator/units/background/updates/moved/moved_updater.dart';
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
import 'apps/recorder_from_saved_app.dart';
import 'apps/renderer_app.dart';
import 'units/background/forms/form_paint.dart';
import 'units/unit.dart';

var currentFrame = 0;
final frameRate = 50;
final frameTime = 1000 / frameRate;
final allTime = 5;

final countHotFrames = 22 * frameRate;
final allFrames = (allTime * frameRate);

enum AppMode {
  preview,
  recorder,
  recorderFromSave
}

AppMode appMode = AppMode.preview;


final pictureSize = Size(600, 600);

void main() async {
  if (appMode == AppMode.preview) {
    runApp(RendererApp(
      scene: () => Scene(),
    ));
  } else {
    if(appMode == AppMode.recorderFromSave) {
      recorderFromSavedApp();
    } else {
      var count = 60;
      var time = DateTime.now().millisecondsSinceEpoch;
      for (var i = 0; i < count; i++) {
        await recorderApp(Scene());
      }
      print('All success: ${(DateTime.now().millisecondsSinceEpoch - time) / 1000}sec');
      print('AVG time: ${(DateTime.now().millisecondsSinceEpoch - time) / count}ms');
    }
  }
}

class Scene extends Unit {
  late BackgroundUnit backgroundUnit;

  FormPaint? form;
  Palette? palette;
  Generator? generator;
  MovedUpdater? movedUpdater;
  RotationUpdater? rotationUpdater;
  double? widthSpeed;

  Scene({
    this.form,
    this.palette,
    this.generator,
    this.movedUpdater,
    this.rotationUpdater,
    this.widthSpeed,
  }) {
    currentFrame = 0;

    Palette palette;
    if (this.palette != null) {
      palette = this.palette!;
    } else {
      palette = Palette();
    }

    FormPaint form;
    var forms = [
          () => EthForm(),
          () => TriangleForm(),
          () => CircleForm(),
          () => StarForm(),
          () => SquareForm(),
          () => HeartForm(),
    ];
    if (this.form != null) {
      form = this.form!;
    } else {
      form = forms[random.nextInt(forms.length)]();
    }

    Generator generator;
    var generators = [
          () => CenterGenerator(),
          () => RandomPointsMultiplyGenerator(),
          () => RandomPointsGenerator(),
          () => CircleMultiplyGenerator(),
          () => CircleGenerator(),
          () => CrossGenerator(),
          () => CenterMovedRotationGenerator(),
    ];
    if (this.generator != null) {
      generator = this.generator!;
    } else {
      generator = generators[random.nextInt(generators.length)]();
    }

    MovedUpdater movedUpdater;
    var movedUpdaters = [
          () => RandomNotMovedLinearUpdater(),
          () => RandomNotMovedRandomUpdater(),
          () => RotationMovedUpdater(),
          () => NotMovedUpdater(),
          () => LineMovedUpdater(),
          () => ChaoticMovedUpdater(),
    ];
    if (this.movedUpdater != null) {
      movedUpdater = this.movedUpdater!;
    } else {
      movedUpdater = movedUpdaters[random.nextInt(movedUpdaters.length)]();
    }

    RotationUpdater rotationUpdater;
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
    if (this.rotationUpdater != null) {
      rotationUpdater = this.rotationUpdater!;
    } else {
      rotationUpdater = rotationUpdaters[random.nextInt(rotationUpdaters.length)]();
    }

    print('ALL COUNTS ~~ ${forms.length * generators.length * movedUpdaters.length * rotationUpdaters.length}!');

    backgroundUnit = BackgroundUnit(
      colors: palette.colors,
      formPaint: form,
      updater: Updater(
        movedUpdater: movedUpdater,
        rotationUpdater: rotationUpdater,
        widthSpeed: widthSpeed,
      ),
      generator: generator,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()
      ..color = Colors.black);
    if (appMode == AppMode.preview) {
      canvas.drawRect(
          Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: pictureSize.width - 2, height: pictureSize.height - 2),
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
    currentFrame++;
    backgroundUnit.update(dt);
  }
}
