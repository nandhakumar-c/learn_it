import 'package:flutter/foundation.dart';

class VideoCallProvider with ChangeNotifier {
  bool isAudioEnabled = false;
  bool clientAudioEnabled = false;

  bool isVideoEnabled = false;
  bool clientVideoEnabled = false;
  audioSwitch() {
    isAudioEnabled = !isAudioEnabled;
    notifyListeners();
  }

  videoSwitch() {
    isVideoEnabled = !isVideoEnabled;
    notifyListeners();
  }
}
