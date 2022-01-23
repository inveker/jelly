import 'dart:async';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:nft_creator/apps/recorder_app.dart';
import 'package:nft_creator/currentNft.dart';
import 'package:nft_creator/main.dart';
import 'package:nft_creator/units/background/palette.dart';
import 'package:nft_creator/utils/utils.dart';
import '../units/unit.dart';

class RendererApp extends StatefulWidget {
  final Scene Function() scene;

  RendererApp({Key? key, required this.scene}) : super(key: key) {
    Future.delayed(Duration(seconds: 2), () {
      DesktopWindow.setWindowSize(pictureSize);
    });
  }

  @override
  _RendererAppState createState() => _RendererAppState();
}

class _RendererAppState extends State<RendererApp> {
  late final Ticker ticker;
  late final ValueNotifier<double> notifier;

  double _lastDt = 0;

  late Scene scene;

  @override
  initState() {
    notifier = ValueNotifier(_lastDt);
    ticker = Ticker((elapsed) {
      int time = elapsed.inMilliseconds;
      var ms = time / 1000;
      double deltaTime = ms - _lastDt;
      _lastDt = ms;
      notifier.value = deltaTime;
    });
    ticker.start();
    newScene();
    super.initState();
  }

  void newScene() {
    scene = widget.scene();
    currentNft = CurrentNft(
      form: scene.backgroundUnit.formPaint,
      palette: Palette(colors: scene.backgroundUnit.colors),
      generator: scene.backgroundUnit.generator,
      movedUpdater: scene.backgroundUnit.updater.movedUpdater,
      rotationUpdater: scene.backgroundUnit.updater.rotationUpdater,
    );
    setState(() {});
  }

  void restartScene() {
    scene = Scene(
      form: currentNft.form,
      palette: currentNft.palette,
      generator: currentNft.generator,
      movedUpdater: currentNft.movedUpdater,
      rotationUpdater: currentNft.rotationUpdater,
    );
    setState(() {});
  }

  void changeColor() {
    currentNft.palette = Palette();
    scene = Scene(
      form: currentNft.form,
      palette: currentNft.palette,
      generator: currentNft.generator,
      movedUpdater: currentNft.movedUpdater,
      rotationUpdater: currentNft.rotationUpdater,
    );
    setState(() {});
  }

  void toggleTick() {
    if(ticker.isActive) {
      ticker.stop();
    } else {
      ticker.start();
    }
    setState(() {});
  }

  void saveStart() {
    currentNft.startFrame = 0;
    currentNft.save();
  }

  void saveHot() {
    currentNft.startFrame = currentFrame;
    currentNft.save();
  }

  bool withVideo = false;
  void addVideo() {
    if(currentNft.hasVideo != null && currentNft.hasVideo!) {
      currentNft.hasVideo = false;
    } else {
      currentNft.hasVideo = true;
    }
    withVideo = currentNft.hasVideo!;
    setState(() {});
  }

  @override
  void dispose() {
    notifier.dispose();
    ticker.dispose();
    super.dispose();
  }

  bool showMenu = false;
  FocusNode focusNode = FocusNode()..requestFocus();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RawKeyboardListener(
        onKey: (e) {
          if (e.isKeyPressed(LogicalKeyboardKey.enter)) {
            setState(() {
              showMenu = !showMenu;
            });
          }
        },
        focusNode: focusNode,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: MyCustomPainter(
                  repaint: notifier,
                  scene: scene,
                ),
              ),
            ),
            if (showMenu)
              Positioned(
                bottom: 0,
                left: 0,
                width: pictureSize.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    bottom: 8,
                    right: 32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              child: Text('Restart'),
                              onPressed: () {
                                restartScene();
                              },
                            ),
                            const SizedBox(height: 16,),
                            ElevatedButton(
                              child: Text(withVideo ? 'Delete video' : 'Add video'),
                              onPressed: () {
                                addVideo();
                              },
                            ),
                            const SizedBox(height: 16,),
                            ElevatedButton(
                              child: Text('Change color'),
                              onPressed: () {
                                changeColor();
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text(ticker.isActive ? 'Stop' : 'Start'),
                        onPressed: () {
                          toggleTick();
                        },
                      ),
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              child: Text('Save start'),
                              onPressed: () {
                                saveStart();
                              },
                            ),
                            const SizedBox(height: 16,),
                            ElevatedButton(
                              child: Text('Save hot'),
                              onPressed: () {
                                saveHot();
                              },
                            ),
                            const SizedBox(height: 16,),
                            ElevatedButton(
                              child: Text('Next'),
                              onPressed: () {
                                newScene();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class MyCustomPainter extends CustomPainter {
  final ValueNotifier repaint;
  final Unit scene;

  MyCustomPainter({
    required this.repaint,
    required this.scene,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    scene
      ..paint(canvas, size)
      ..update(repaint.value);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
