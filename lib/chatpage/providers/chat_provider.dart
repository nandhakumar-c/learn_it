import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ChatProvider with ChangeNotifier {
  List<MessageModel> message_list = [];
  addMessage(List<MessageModel> model) {
    message_list = [...model];
    notifyListeners();
  }
}
