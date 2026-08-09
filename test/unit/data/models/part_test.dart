import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opencode_remote_app/data/models/models.dart';

Map<String, dynamic> basePart(String type) => {
  'id': 'prt_1',
  'sessionID': 'ses_1',
  'messageID': 'msg_1',
  'type': type,
};

void main() {
  group('MessagePart', () {
    test('parses text', () {
      final part = MessagePart.fromJson({
        ...basePart('text'),
        'text': 'hello',
        'synthetic': false,
        'time': {'start': 1, 'end': 2},
      });
      final text = part as TextPart;
      expect(text.text, 'hello');
      expect(text.synthetic, false);
      expect(text.time?.start, 1);
      expect(text.time?.end, 2);
    });

    test('parses reasoning', () {
      final part = MessagePart.fromJson({
        ...basePart('reasoning'),
        'text': 'thinking',
        'time': {'start': 1},
      });
      final reasoning = part as ReasoningPart;
      expect(reasoning.text, 'thinking');
      expect(reasoning.time.end, isNull);
    });

    test('parses tool with completed state', () {
      final part = MessagePart.fromJson({
        ...basePart('tool'),
        'callID': 'call_1',
        'tool': 'bash',
        'state': {
          'status': 'completed',
          'input': {'command': 'ls'},
          'output': 'lib/',
          'title': 'ls',
          'metadata': <String, dynamic>{},
          'time': {'start': 1, 'end': 2},
        },
      });
      final tool = part as ToolPart;
      expect(tool.callID, 'call_1');
      expect(tool.tool, 'bash');
      final state = tool.state as ToolStateCompleted;
      expect(state.output, 'lib/');
      expect(state.title, 'ls');
      expect(state.time.start, 1);
      expect(state.time.end, 2);
    });

    test('parses step-start', () {
      final part = MessagePart.fromJson(basePart('step-start'));
      expect(part, isA<StepStartPart>());
      expect((part as StepStartPart).snapshot, isNull);
    });

    test('parses step-finish with tokens', () {
      final part = MessagePart.fromJson({
        ...basePart('step-finish'),
        'reason': 'tool-calls',
        'cost': 0.5,
        'tokens': {
          'input': 100,
          'output': 20,
          'reasoning': 10,
          'cache': {'read': 30, 'write': 40},
        },
      });
      final finish = part as StepFinishPart;
      expect(finish.reason, 'tool-calls');
      expect(finish.cost, 0.5);
      expect(finish.tokens.input, 100);
      expect(finish.tokens.cache.write, 40);
    });

    test('falls back to OtherPart for unknown types', () {
      final part = MessagePart.fromJson({
        ...basePart('snapshot'),
        'snapshot': 'sha-abc',
      });
      final other = part as OtherPart;
      expect(other.type, 'snapshot');
      expect(other.id, 'prt_1');
      expect(other.sessionID, 'ses_1');
      expect(other.messageID, 'msg_1');
    });

    test('round-trips every typed variant through toJson', () {
      final parts = <MessagePart>[
        MessagePart.text(id: 'a', sessionID: 's', messageID: 'm', text: 'hi'),
        MessagePart.reasoning(
          id: 'a',
          sessionID: 's',
          messageID: 'm',
          text: 'r',
          time: const PartTime(start: 1),
        ),
        MessagePart.tool(
          id: 'a',
          sessionID: 's',
          messageID: 'm',
          callID: 'c',
          tool: 'bash',
          state: const ToolState.pending(input: {'x': 1}, raw: '{}'),
        ),
        MessagePart.stepStart(id: 'a', sessionID: 's', messageID: 'm'),
        MessagePart.stepFinish(
          id: 'a',
          sessionID: 's',
          messageID: 'm',
          reason: 'done',
          cost: 1,
          tokens: const Tokens(
            input: 1,
            output: 1,
            reasoning: 1,
            cache: CacheTokens(read: 1, write: 1),
          ),
        ),
        MessagePart.other(
          id: 'a',
          sessionID: 's',
          messageID: 'm',
          type: 'mystery',
        ),
      ];

      for (final part in parts) {
        final roundTrip = MessagePart.fromJson(
          jsonDecode(jsonEncode(part.toJson())) as Map<String, dynamic>,
        );
        expect(
          roundTrip,
          part,
          reason: 'round-trip failed for ${part.runtimeType}',
        );
      }
    });
  });

  group('ToolState', () {
    test('parses pending', () {
      final state = ToolState.fromJson({
        'status': 'pending',
        'input': {'command': 'ls'},
        'raw': '{"command":"ls"}',
      });
      final pending = state as ToolStatePending;
      expect(pending.input['command'], 'ls');
      expect(pending.raw, '{"command":"ls"}');
    });

    test('parses running', () {
      final state = ToolState.fromJson({
        'status': 'running',
        'input': {'command': 'ls'},
        'time': {'start': 1},
      });
      final running = state as ToolStateRunning;
      expect(running.title, isNull);
      expect(running.time.start, 1);
    });

    test('parses completed', () {
      final state = ToolState.fromJson({
        'status': 'completed',
        'input': {'command': 'ls'},
        'output': 'out',
        'title': 'ls',
        'metadata': <String, dynamic>{},
        'time': {'start': 1, 'end': 2},
      });
      final completed = state as ToolStateCompleted;
      expect(completed.output, 'out');
      expect(completed.metadata, isEmpty);
    });

    test('parses error', () {
      final state = ToolState.fromJson({
        'status': 'error',
        'input': <String, dynamic>{},
        'error': 'command failed',
        'time': {'start': 1, 'end': 2},
      });
      expect((state as ToolStateError).error, 'command failed');
    });

    test('throws on unknown status', () {
      expect(
        () => ToolState.fromJson({
          'status': 'unknown',
          'input': <String, dynamic>{},
          'time': {'start': 1},
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });
}
