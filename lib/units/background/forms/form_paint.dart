import 'dart:ui';

import 'package:nft_creator/units/background/backgound_unit.dart';

abstract class FormPaint {
  void paint(BackgroundUnit context, Canvas canvas, Size size);
}