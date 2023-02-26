import 'package:flutter/foundation.dart';

class VideoCallProvider with ChangeNotifier {
  bool isAudioEnabled = true;
  bool clientAudioEnabled = true;
  audioSwitch() {
    isAudioEnabled = !isAudioEnabled;
    notifyListeners();
  }
}
