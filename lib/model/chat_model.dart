class ChatModel {
  final int id_forum;
  final int id_chat;
  final int id_user;
  final String name;
  final String message;
  final String send_at;

  ChatModel(
      {required this.id_chat,
      required this.id_user,
      required this.message,
      required this.name,
      required this.id_forum,
      required this.send_at});

  factory ChatModel.fromJSON(Map<String, dynamic> json) {
    return ChatModel(
        id_chat: json['id_chat'] ?? 0,
        id_user: json['id_user'] ?? 0,
        message: json['message'] ?? '',
        name: json['name'] ?? '',
        id_forum: json['id_forum'] ?? 0,
        send_at: json['send_at'] ?? '');
  }

  Map<String, dynamic> toJSON() {
    return {
      'id_forum': id_forum,
      'id_chat': id_chat,
      'id_user': id_user,
      'message': message,
      'name': name,
      'send_at': send_at
    };
  }
}
