import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:nft_creator/currentNft.dart';
import 'package:nft_creator/main.dart';
import 'package:nft_creator/utils/utils.dart';


Future<void> recorderFromSavedApp() async {
  var time = DateTime.now().millisecondsSinceEpoch;

  var file = File(r'C:\Users\User\AndroidStudioProjects\nft_creator_jelly\lib\saved.json');
  List<CurrentNft> savedData = jsonDecode(file.readAsStringSync()).map((e) => CurrentNft.fromJson(e)).toList().cast<CurrentNft>();

  final double imageWidth = pictureSize.width;
  final double imageHeight = pictureSize.height;

  for(var savedNft in savedData) {
    var localTime = DateTime.now().millisecondsSinceEpoch;
    String nftName = random.nextInt(100).toString();
    print('RecordedApp $nftName');

    var dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${nftName}';
    var q = 1;
    while(Directory(dirPath).existsSync()) {
      dirPath = 'C:/Users/User/AndroidStudioProjects/nft_creator_jelly/lib/images/${q}_${nftName}';
      q++;
    }
    Directory(dirPath).createSync();

    Scene scene = Scene(
      form: savedNft.form,
      palette: savedNft.palette,
      generator: savedNft.generator,
      movedUpdater: savedNft.movedUpdater,
      rotationUpdater: savedNft.rotationUpdater,
    );

    var countHotFrames = savedNft.startFrame!;

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
          File file = File('${dirPath}/img${i}.png');
          file
            ..writeAsBytes(pngBytes!.buffer.asInt8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes))
            ..createSync(recursive: true);
        }

        print('${(i - countHotFrames)  / (allFrames - countHotFrames) * 100}%');

      });
    }
    print('Success: ${DateTime.now().millisecondsSinceEpoch - localTime}');

  }

  print('All success: ${(DateTime.now().millisecondsSinceEpoch - time) / 1000}sec');
  print('AVG time: ${(DateTime.now().millisecondsSinceEpoch - time) / savedData.length}ms');
}
