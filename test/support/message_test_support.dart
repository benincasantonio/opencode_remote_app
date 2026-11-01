import 'package:opencode_remote_app/data/models/message.dart';
import 'package:opencode_remote_app/data/models/part.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/message_providers.dart';

const testModel = ModelRef(modelID: 'gpt', providerID: 'openai');

MessageWithParts testUserMessage({
  required String id,
  required int created,
  String text = 'hello',
  String sessionId = 'ses_1',
}) {
  return MessageWithParts(
    info: Message.user(
      id: id,
      sessionID: sessionId,
      time: UserTime(created: created),
      agent: 'build',
      model: testModel,
    ),
    parts: [
      MessagePart.text(
        id: 'prt_$id',
        sessionID: sessionId,
        messageID: id,
        text: text,
      ),
    ],
  );
}

/// A notifier that returns [transcript] and never calls the network.
class EmptyTranscriptMessages extends Messages {
  @override
  Future<Transcript> build(String sessionId) async {
    return const Transcript(messages: [], hasEarlier: false);
  }
}
