import 'dart:io';
import 'dart:ui';

import 'package:nft_creator/main.dart';

Future<void> recorderApp(Scene scene) async {
  print('RecordedApp ${scene.name}');

  var time = DateTime.now().millisecondsSinceEpoch;

  try {
    await Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}').delete(recursive: true);
  } catch(e) {}
  Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/').createSync();
  Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}').createSync();

  final double imageWidth = 720;
  final double imageHeight = 720;

  final frameRate = 50;
  final frameTime = 1000 / frameRate;
  final allTime = 5;

  final countHotFrames = 360;

  final allFrames = (allTime * frameRate) + countHotFrames;



  for(var i = 0; i < allFrames; i++) {
    await Future.delayed(Duration(milliseconds: frameTime.toInt()), () async {
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder, new Rect.fromLTWH(0.0, 0.0, imageWidth, imageHeight));
      scene.paint(canvas, Size(imageWidth, imageHeight));
      scene.update(frameTime / 1000);

      if(i > countHotFrames) {
        final picture = recorder.endRecording();
        final img = await picture.toImage(imageWidth.toInt(), imageHeight.toInt());
        var pngBytes = await img.toByteData(format: ImageByteFormat.png );
        var q = 0;
        File file = File('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}/img${i}.png');
        while(file.existsSync()) {
          file = File('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${q}_${scene.name}/img${i}.png');
          q++;
        }
        file
          ..writeAsBytes(pngBytes!.buffer.asInt8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes))
          ..createSync();
      }
      print('${(i - countHotFrames) / (allFrames - countHotFrames ) * 100}%');

    });
  }

  print('Success: ${DateTime.now().millisecondsSinceEpoch - time}');
}
