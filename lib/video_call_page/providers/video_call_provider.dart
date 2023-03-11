import 'package:flutter/foundation.dart';

import '../screens/signaling.dart';

class VideoCallProvider with ChangeNotifier {
  bool isAudioEnabled = false;
  bool clientAudioEnabled = false;

  bool isVideoEnabled = false;
  bool clientVideoEnabled = false;

  Signaling signaling = Signaling();

  audioSwitch() {
    isAudioEnabled = !isAudioEnabled;
    notifyListeners();
  }

  videoSwitch() {
    isVideoEnabled = !isVideoEnabled;
    notifyListeners();
  }

  videoAudioEnablingAndDisablingFunction(localRenderer, remoteRenderer) {
    signaling.openUserMedia(
        localRenderer, remoteRenderer, isAudioEnabled, isVideoEnabled);
    // notifyListeners();
  }

  hangUp(localRenderer) {
    signaling.hangUp(localRenderer);
    notifyListeners();
  }
}
