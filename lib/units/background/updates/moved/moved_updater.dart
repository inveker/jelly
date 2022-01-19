import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/utils/utils.dart';

abstract class MovedUpdater {
  void update(BackgroundUnit context, double dt);
}