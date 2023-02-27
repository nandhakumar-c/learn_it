class MessageModel {
  String message;
  String socketId;
  String sender;
  DateTime date;
  MessageModel(
      {required this.message,
      required this.socketId,
      required this.sender,
      required this.date});
}
