import 'package:nft_creator/units/background/backgound_unit.dart';

abstract class Generator {
  void update(BackgroundUnit context, double dt);
}