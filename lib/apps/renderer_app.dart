import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nft_creator/main.dart';
import '../units/unit.dart';

class RendererApp extends StatefulWidget {
  final Scene scene;

  const RendererApp({Key? key, required this.scene}) : super(key: key);
  @override
  _RendererAppState createState() => _RendererAppState();
}

class _RendererAppState extends State<RendererApp> {
  late final Ticker ticker;
  late final ValueNotifier<double> notifier;

  double _lastDt = 0;

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
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomPaint(
        painter: MyCustomPainter(
          repaint: notifier,
          scene: widget.scene,
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
      ..update(repaint.value)
    ;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}