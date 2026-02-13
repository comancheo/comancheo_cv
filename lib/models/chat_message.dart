class ChatMessage {
  final String body;
  final DateTime timestamp;
  final bool deleted;
  final int fromUser;

  ChatMessage({
    required this.body,
    required this.timestamp,
    required this.deleted,
    required this.fromUser,
  });
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      body: json['body'],
      timestamp: DateTime.parse(json['datetime']),
      deleted: json['deleted'] == 1,
      fromUser: json['users_id'],
    );
  }
}