import 'dart:io';
import 'dart:ui';

import 'package:nft_creator/main.dart';
final frameRate = 50;
final frameTime = 1000 / frameRate;
final allTime = 5;

final countHotFrames = 22 * frameRate;

final allFrames = (allTime * frameRate) + countHotFrames;
Future<void> recorderApp(Scene scene) async {
  print('RecordedApp ${scene.name}');

  var time = DateTime.now().millisecondsSinceEpoch;
 //fix
 //  try {
 //    await Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}').delete(recursive: true);
 //  } catch(e) {}
 //  Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/').createSync();

  var dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}';
  var q = 1;
  while(Directory(dirPath).existsSync()) {
    dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${q}_${scene.name}';
    q++;
  }
  Directory(dirPath).createSync();

  final double imageWidth = pictureSize.width;
  final double imageHeight = pictureSize.height;





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

        File file = File('$dirPath/img${i}.png');

        file
          ..writeAsBytes(pngBytes!.buffer.asInt8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes))
          ..createSync();
        print('${(i - countHotFrames) / (allFrames - countHotFrames ) * 100}%');

      }

    });
  }

  print('Success: ${DateTime.now().millisecondsSinceEpoch - time}');
}
