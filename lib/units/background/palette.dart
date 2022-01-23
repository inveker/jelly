import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nft_creator/utils/utils.dart';

class Palette {
  late List<Color> colors;

  Palette({
    List<Color>? colors,
  }) {
    if(colors != null) {
      this.colors = colors;
    } else {
      this.colors = randomPalette();
    }
  }

  Palette.fromJson(List json) {
    colors = [];
    json.forEach((i) {
      colors.add(Color.fromARGB(i[0], i[1], i[2], i[3]));
    });
  }

  List toJson() {
    return [
      for(var color in colors)
        [color.alpha, color.red, color.green, color.blue],
    ];
  }
}