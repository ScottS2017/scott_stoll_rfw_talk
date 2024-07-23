/// Represents a single message sent by either the user or the AI.
class CustomChatMessage {
  CustomChatMessage({
    required this.who,
    required this.message,
  });

  /// Who the text message was from.
  String who;

  /// What the text message was.
  String message;
}