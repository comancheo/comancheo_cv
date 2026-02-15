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
  @override
  bool operator ==(Object other) => other is ChatMessage && fromUser == other.fromUser && timestamp == other.timestamp && body == other.body && deleted == other.deleted;
  
  @override
  int get hashCode => Object.hash(fromUser, timestamp, body, deleted);
}