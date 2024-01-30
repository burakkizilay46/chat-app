// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomsModel {
  final String id;
  List<String> users;
  List<Message> messages;

  RoomsModel({
    required this.id,
    required this.users,
    required this.messages,
  });

  factory RoomsModel.fromJson(String id, Map<String, dynamic> json) => RoomsModel(
        id: id,
        users: List<String>.from(json['users'] as List),
        messages: (json['messages'] as List).map((e) => Message.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'users': users,
        'messages': messages.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'Data(users: $users, messages: $messages)';
  }
}

class Message {
  String content;
  String senderId;

  Message({required this.content, required this.senderId});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json['content'],
        senderId: json['senderId'],
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'senderId': senderId,
      };

  @override
  String toString() {
    return 'Message(content: $content, senderId: $senderId)';
  }
}
