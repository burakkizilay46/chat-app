class RoomsModel {
  List<String> users;
  Message message;

  RoomsModel({required this.users, required this.message});

  factory RoomsModel.fromJson(Map<String, dynamic> json) => RoomsModel(
        users: List<String>.from(json['users']),
        message: Message.fromJson(json['messages']),
      );

  Map<String, dynamic> toJson() => {
        'users': users,
        'messages': message.toJson(),
      };

  @override
  String toString() {
    return 'Data(users: $users, message: $message)';
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
