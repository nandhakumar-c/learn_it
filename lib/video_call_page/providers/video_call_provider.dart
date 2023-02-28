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

  videoAudioEnablingAndDisablingFunction(_localRenderer, _remoteRenderer) {
    signaling.openUserMedia(
        _localRenderer, _remoteRenderer, isAudioEnabled, isVideoEnabled);
    // notifyListeners();
  }

  hangUp(_localRenderer) {
    signaling.hangUp(_localRenderer);
    notifyListeners();
  }
}
