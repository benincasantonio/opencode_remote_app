import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opencode_remote_app/data/models/models.dart';

import 'fixtures.dart';

void main() {
  group('Message', () {
    test('parses the messages fixture into typed messages', () {
      final messages = loadFixtureList('messages_full')
          .map(
            (json) => MessageWithParts.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      expect(messages, hasLength(4));
      expect(messages[0].info, isA<UserMessage>());
      expect(messages[1].info, isA<AssistantMessage>());
      expect(messages[2].info, isA<AssistantMessage>());
    });

    test('parses user message fields', () {
      final user =
          (loadFixtureList('messages_full')
                  .map(
                    (json) =>
                        MessageWithParts.fromJson(json as Map<String, dynamic>),
                  )
                  .toList()
                  .first
                  .info
              as UserMessage);

      expect(user.id, 'msg_dd7f9a5b80013nvZFOFhEHD60I');
      expect(user.sessionID, 'ses_228065a50ffe1EqJiRf52UStJu');
      expect(user.agent, 'plan');
      expect(user.model.providerID, 'github-copilot');
      expect(user.model.modelID, 'gpt-5.4');
      expect(user.model.variant, 'xhigh');
      expect(user.time.created, 1777444955588);
      expect(user.format, isNull);
      expect(user.summary?.diffs, isEmpty);
      expect(user.tools, isNull);
    });

    test('parses assistant message fields', () {
      final assistant =
          (loadFixtureList('messages_full')
                  .map(
                    (json) =>
                        MessageWithParts.fromJson(json as Map<String, dynamic>),
                  )
                  .toList()[1]
                  .info
              as AssistantMessage);

      expect(assistant.id, 'msg_dd7f9a5cf002fJacgFS1InN08C');
      expect(assistant.parentID, 'msg_dd7f9a5b80013nvZFOFhEHD60I');
      expect(assistant.modelID, 'gpt-5.4');
      expect(assistant.providerID, 'github-copilot');
      expect(assistant.mode, 'plan');
      expect(assistant.agent, 'plan');
      expect(assistant.variant, 'xhigh');
      expect(assistant.finish, 'tool-calls');
      expect(assistant.path.cwd, '/Users/antoniobenincasa');
      expect(assistant.path.root, '/');
      expect(assistant.time.created, 1777444955599);
      expect(assistant.time.completed, 1777444977353);
      expect(assistant.cost, 0);
      expect(assistant.tokens.input, 5801);
      expect(assistant.tokens.total, 9771);
      expect(assistant.error, isNull);
    });

    test('parses assistant message parts', () {
      final message = loadFixtureList('messages_full')
          .map(
            (json) => MessageWithParts.fromJson(json as Map<String, dynamic>),
          )
          .toList()[1];

      expect(message.parts, hasLength(7));
      final types = message.parts.map((part) => part.runtimeType).toList();
      expect(
        types,
        containsAll([
          StepStartPart,
          ReasoningPart,
          TextPart,
          ToolPart,
          StepFinishPart,
        ]),
      );
      expect(message.parts.whereType<ReasoningPart>(), hasLength(2));
      final completed = message.parts.whereType<ToolPart>().first;
      expect(completed.tool, 'read');
      expect(
        (completed.state as ToolStateCompleted).title,
        'Users/antoniobenincasa',
      );
      final failed = message.parts.whereType<ToolPart>().last;
      expect(failed.tool, 'glob');
      expect(failed.state, isA<ToolStateError>());
    });

    test('parses user message with a text part', () {
      final message = loadFixtureList('messages_full')
          .map(
            (json) => MessageWithParts.fromJson(json as Map<String, dynamic>),
          )
          .toList()
          .first;

      expect(message.parts, hasLength(1));
      final text = message.parts.first as TextPart;
      expect(text.text, contains('create a ticket'));
    });

    test('toJson round-trips a full message', () {
      final message = MessageWithParts.fromJson(
        loadFixtureList('messages_full')[1] as Map<String, dynamic>,
      );
      final roundTrip = MessageWithParts.fromJson(
        jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>,
      );
      expect(roundTrip, message);
    });

    test('throws on unknown role', () {
      expect(
        () => Message.fromJson({
          'role': 'system',
          'id': 'msg_1',
          'sessionID': 'ses_1',
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });

  group('OutputFormat', () {
    test('parses text', () {
      expect(
        OutputFormat.fromJson({'type': 'text'}),
        const OutputFormat.text(),
      );
    });

    test('parses json_schema', () {
      final format = OutputFormat.fromJson({
        'type': 'json_schema',
        'schema': {'type': 'object'},
        'retryCount': 2,
      });
      final jsonSchema = format as OutputFormatJsonSchema;
      expect(jsonSchema.schema['type'], 'object');
      expect(jsonSchema.retryCount, 2);
    });

    test('round-trips json_schema', () {
      const format = OutputFormat.jsonSchema(
        schema: {'type': 'object'},
        retryCount: 2,
      );
      final roundTrip = OutputFormat.fromJson(
        jsonDecode(jsonEncode(format.toJson())) as Map<String, dynamic>,
      );
      expect(roundTrip, format);
    });

    test('throws on unknown type', () {
      expect(
        () => OutputFormat.fromJson({'type': 'mystery'}),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });

  group('MessageError', () {
    test('parses named error and exposes message', () {
      final error = MessageError.fromJson({
        'name': 'ProviderAuthError',
        'data': {'providerID': 'anthropic', 'message': 'Invalid API key'},
      });
      expect(error.name, 'ProviderAuthError');
      expect(error.message, 'Invalid API key');
    });
  });
}
