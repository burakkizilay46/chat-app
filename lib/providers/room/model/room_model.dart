// To parse this JSON data, do
//
//     final roomsModel = roomsModelFromJson(jsonString);

import 'dart:convert';

RoomsModel roomsModelFromJson(String str) => RoomsModel.fromJson(json.decode(str));

String roomsModelToJson(RoomsModel data) => json.encode(data.toJson());

class RoomsModel {
  List<String> users;
  List<Message> messages;

  RoomsModel({
    required this.users,
    required this.messages,
  });

  factory RoomsModel.fromJson(Map<String, dynamic> json) => RoomsModel(
        users: List<String>.from(json["users"].map((x) => x)),
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x)),
        "messages": List<Message>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  String content;
  SendTime sendTime;
  String senderId;

  Message({
    required this.content,
    required this.sendTime,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        sendTime: SendTime.fromJson(json["sendTime"]),
        senderId: json["senderID"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "sendTime": sendTime.toJson(),
        "senderID": senderId,
      };
}

class SendTime {
  int seconds;
  int nanoseconds;

  SendTime({
    required this.seconds,
    required this.nanoseconds,
  });

  factory SendTime.fromJson(Map<String, dynamic> json) => SendTime(
        seconds: json["seconds"],
        nanoseconds: json["nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "seconds": seconds,
        "nanoseconds": nanoseconds,
      };
}
