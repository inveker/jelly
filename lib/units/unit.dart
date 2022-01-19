import 'package:flutter/material.dart';

abstract class Unit {
  void paint(Canvas canvas, Size size);

  void update(double dt);
}
