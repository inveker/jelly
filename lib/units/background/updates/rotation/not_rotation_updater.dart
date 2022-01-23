import 'package:nft_creator/units/background/backgound_unit.dart';
import 'package:nft_creator/units/background/updates/rotation/rotation_updater.dart';
import 'package:nft_creator/utils/utils.dart';

class NotRotationUpdater extends RotationUpdater {

  NotRotationUpdater.fromJson(Map json) : super.fromJson(json);
  NotRotationUpdater() {
    init();
  }

  @override
  void init() {
    // TODO: implement init
  }

  void update(BackgroundUnit context, double dt) {

  }

}