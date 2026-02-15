class ChatMessage {
  final String body;
  final DateTime timestamp;
  final bool deleted;
  final String email;

  ChatMessage({
    required this.body,
    required this.timestamp,
    required this.deleted,
    required this.email,
  });
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      body: json['body'],
      timestamp: DateTime.parse(json['datetime']),
      deleted: json['deleted'] == 1,
      email: json['user_email'],
    );
  }
  @override
  bool operator ==(Object other) => other is ChatMessage && email == other.email && timestamp == other.timestamp && body == other.body && deleted == other.deleted;
  
  @override
  int get hashCode => Object.hash(email, timestamp, body, deleted);
}