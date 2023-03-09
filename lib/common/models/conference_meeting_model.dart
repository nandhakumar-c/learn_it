// To parse this JSON data, do
//
//     final conferenceMeetingModel = conferenceMeetingModelFromJson(jsonString);

import 'dart:convert';

ConferenceMeetingModel conferenceMeetingModelFromJson(String str) =>
    ConferenceMeetingModel.fromJson(json.decode(str));

String conferenceMeetingModelToJson(ConferenceMeetingModel data) =>
    json.encode(data.toJson());

class ConferenceMeetingModel {
  ConferenceMeetingModel({
    required this.meetingId,
    required this.token,
    required this.displayName,
    required this.micEnabled,
    required this.camEnabled,
    //required this.chatEnabled,
  });

  String meetingId;
  String token;
  String displayName;
  bool micEnabled;
  bool camEnabled;
  // bool chatEnabled;

  factory ConferenceMeetingModel.fromJson(Map<String, dynamic> json) =>
      ConferenceMeetingModel(
        meetingId: json["meetingId"],
        token: json["token"],
        displayName: json["displayName"],
        micEnabled: json["micEnabled"],
        camEnabled: json["camEnabled"],
        //  chatEnabled: json["chatEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "meetingId": meetingId,
        "token": token,
        "displayName": displayName,
        "micEnabled": micEnabled,
        "camEnabled": camEnabled,
        //"chatEnabled": chatEnabled,
      };
}
