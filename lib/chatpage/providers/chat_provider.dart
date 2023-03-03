import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/common/meeting_controls/meeting_action_bar.dart';

import '../models/user_model.dart';

class ChatProvider with ChangeNotifier {
  List<MessageModel> message_list = [];
  addMessage(List<MessageModel> model) {
    message_list = [...model];
    notifyListeners();
  }
}
