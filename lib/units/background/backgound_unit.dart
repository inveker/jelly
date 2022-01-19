import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_creator/units/background/forms/form_paint.dart';
import 'package:nft_creator/units/background/generates/generator.dart';
import 'package:nft_creator/units/background/updates/updater.dart';
import 'package:nft_creator/utils/utils.dart';
import 'package:nft_creator/utils/vector2.dart';

import '../unit.dart';




class BackgroundUnit extends Unit {
  final FormPaint formPaint;
  final Generator generator;
  final Updater updater;
  final List<Color> colors;
  Size? size;
  late List<BackgroundParticle> particles;


  BackgroundUnit({
    required this.colors,
    required this.formPaint,
    required this.generator,
    required this.updater,
  }) {
    particles = [];
  }

  @override
  void paint(Canvas canvas, Size size) {
    this.size ??= size;
    formPaint.paint(this, canvas, size);
  }

  @override
  void update(double dt) {
    generator.update(this, dt);
    updater.update(this, dt);
  }
}


enum BackgroundParticleType {
  simple,
  light,
}

class BackgroundParticle {
  late Color color;
  late List<Color> colors;
  Vector2 position;
  late Vector2 velocity;
  late double width;
  late double speed;
  late BackgroundParticleType type;
  late double rotationY;
  late double rotationX;
  late double rotationZ;

  BackgroundParticle({ required this.colors, required this.position}) {
    rotationY = 0;
    rotationX = 0;
    rotationZ = 0;
    velocity = Vector2.random();
    width = 10;
    speed = 100;
    if (random.percent(30)) {
      type = BackgroundParticleType.light;
    } else {
      type = BackgroundParticleType.simple;
    }
    color = colors.sublist(1)[random.nextInt(colors.length-1)];
  }
}
