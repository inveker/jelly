import 'dart:io';
import 'dart:ui';

import 'package:nft_creator/main.dart';


Future<void> recorderApp(Scene scene) async {
  String nftName = '';
  print('RecordedApp $nftName');

  var time = DateTime.now().millisecondsSinceEpoch;
 //fix
 //  try {
 //    await Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${scene.name}').delete(recursive: true);
 //  } catch(e) {}
 //  Directory('C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/').createSync();

  var dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${nftName}';
  var q = 1;
  while(Directory(dirPath + '_sT0').existsSync()) {
    dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${q}_${nftName}';
    q++;
  }

  Directory(dirPath + '_sT0').createSync();
  Directory(dirPath + '_sT1').createSync();

  final double imageWidth = pictureSize.width;
  final double imageHeight = pictureSize.height;


  for(var i = 0; i < allFrames + countHotFrames; i++) {
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
        print('${(i - countHotFrames) / (allFrames ) * 100}%');
      }

    });
  }

  print('Success: ${DateTime.now().millisecondsSinceEpoch - time}');
}
