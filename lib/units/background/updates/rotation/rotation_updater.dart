import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/utils/utils.dart';

abstract class RotationUpdater {
  void update(BackgroundUnit context, double dt);
}