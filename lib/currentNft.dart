import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:nft_creator/units/background/forms/circle_form.dart';
import 'package:nft_creator/units/background/forms/eth_form.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/units/background/forms/heart_form.dart';
import 'package:nft_creator/units/background/forms/square_form.dart';
import 'package:nft_creator/units/background/forms/star_form.dart';
import 'package:nft_creator/units/background/forms/triangle_form.dart';
import 'package:nft_creator/units/background/generates/center_generator.dart';
import 'package:nft_creator/units/background/generates/center_moved_rotation_generator.dart';
import 'package:nft_creator/units/background/generates/circle_generator.dart';
import 'package:nft_creator/units/background/generates/circle_multiply_generator.dart';
import 'package:nft_creator/units/background/generates/cross_generator.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/units/background/generates/random_points_generator.dart';
import 'package:nft_creator/units/background/generates/random_points_multiply_generator.dart';
import 'package:nft_creator/units/background/generates/two_dance_generator.dart';
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
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

class CurrentNft {

  FormPaint? form;
  Palette? palette;
  Generator? generator;
  MovedUpdater? movedUpdater;
  RotationUpdater? rotationUpdater;
  bool? reversed = random.nextBool();
  int? startFrame = 0;
  bool? hasVideo = false;

  CurrentNft({
    this.form,
    this.palette,
    this.generator,
    this.movedUpdater,
    this.rotationUpdater,
    this.reversed,
    this.startFrame,
    this.hasVideo,
  });

  Map toJson() {
    return {
      'form': form!.toJson(),
      'palette': palette!.toJson(),
      'generator': generator!.toJson(),
      'movedUpdater': movedUpdater!.toJson(),
      'rotationUpdater': rotationUpdater!.toJson(),
      'reversed': reversed,
      'startFrame': startFrame,
      'hasVideo': hasVideo,
    };
  }

  void save() {
    var file = File(r'C:\Users\User\AndroidStudioProjects\nft_creator_jelly\lib\saved.json');
    List savedData = jsonDecode(file.readAsStringSync());
    savedData.add(toJson());
    file.writeAsString(jsonEncode(savedData));
  }

  factory CurrentNft.fromJson(Map json) {
    FormPaint? form;
    if(json['form']['runtype'] == 'CircleForm') {
      form = CircleForm.fromJson(json['form']);
    } else if(json['form']['runtype'] == 'EthForm') {
      form = EthForm.fromJson(json['form']);
    } else if(json['form']['runtype'] == 'HeartForm') {
      form = HeartForm.fromJson(json['form']);
    } else if(json['form']['runtype'] == 'SquareForm') {
      form = SquareForm.fromJson(json['form']);
    } else if(json['form']['runtype'] == 'StarForm') {
      form = StarForm.fromJson(json['form']);
    } else if(json['form']['runtype'] == 'TriangleForm') {
      form = TriangleForm.fromJson(json['form']);
    }

    Generator? generator;
    if(json['generator']['runtype'] == 'CenterGenerator') {
      generator = CenterGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'CenterMovedRotationGenerator') {
      generator = CenterMovedRotationGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'CircleGenerator') {
      generator = CircleGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'CircleMultiplyGenerator') {
      generator = CircleMultiplyGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'CrossGenerator') {
      generator = CrossGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'RandomPointsGenerator') {
      generator = RandomPointsGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'RandomPointsMultiplyGenerator') {
      generator = RandomPointsMultiplyGenerator.fromJson(json['generator']);
    } else if(json['generator']['runtype'] == 'TwoDanceGenerator') {
      generator = TwoDanceGenerator.fromJson(json['generator']);
    }

    MovedUpdater? movedUpdater;
    if(json['movedUpdater']['runtype'] == 'ChaoticMovedUpdater') {
      movedUpdater = ChaoticMovedUpdater.fromJson(json['movedUpdater']);
    } else if(json['movedUpdater']['runtype'] == 'LineMovedUpdater') {
      movedUpdater = LineMovedUpdater.fromJson(json['movedUpdater']);
    } else if(json['movedUpdater']['runtype'] == 'NotMovedUpdater') {
      movedUpdater = NotMovedUpdater.fromJson(json['movedUpdater']);
    } else if(json['movedUpdater']['runtype'] == 'RandomNotMovedLinearUpdater') {
      movedUpdater = RandomNotMovedLinearUpdater.fromJson(json['movedUpdater']);
    } else if(json['movedUpdater']['runtype'] == 'RandomNotMovedRandomUpdater') {
      movedUpdater = RandomNotMovedRandomUpdater.fromJson(json['movedUpdater']);
    } else if(json['movedUpdater']['runtype'] == 'RotationMovedUpdater') {
      movedUpdater = RotationMovedUpdater.fromJson(json['movedUpdater']);
    }

    RotationUpdater? rotationUpdater;
    if(json['rotationUpdater']['runtype'] == 'AXRotationUpdater') {
      rotationUpdater = AXRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AXYRotationUpdater') {
      rotationUpdater = AXYRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AXYZRotationUpdater') {
      rotationUpdater = AXYZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AXZRotationUpdater') {
      rotationUpdater = AXZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AYRotationUpdater') {
      rotationUpdater = AYRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AYZRotationUpdater') {
      rotationUpdater = AYZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'AZRotationUpdater') {
      rotationUpdater = AZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'NotRotationUpdater') {
      rotationUpdater = NotRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'XRotationUpdater') {
      rotationUpdater = XRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'XYRotationUpdater') {
      rotationUpdater = XYRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'XYZRotationUpdater') {
      rotationUpdater = XYZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'XZRotationUpdater') {
      rotationUpdater = XZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'YRotationUpdater') {
      rotationUpdater = YRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'YZRotationUpdater') {
      rotationUpdater = YZRotationUpdater.fromJson(json['rotationUpdater']);
    } else if(json['rotationUpdater']['runtype'] == 'ZRotationUpdater') {
      rotationUpdater = ZRotationUpdater.fromJson(json['rotationUpdater']);
    }

    return CurrentNft(
      form: form!,
      palette: Palette.fromJson(json['palette']),
      generator: generator,
      movedUpdater: movedUpdater,
      rotationUpdater: rotationUpdater,
      reversed: json['reversed'],
      startFrame: json['startFrame'],
      hasVideo: json['hasVideo'],
    );
  }
}

CurrentNft currentNft = CurrentNft();
