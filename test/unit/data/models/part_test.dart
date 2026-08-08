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
          'metadata': {'cwd': '/tmp'},
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
      expect(state.attachments, isNull);
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

    test('parses file with symbol source', () {
      final part = MessagePart.fromJson({
        ...basePart('file'),
        'mime': 'text/plain',
        'filename': 'main.dart',
        'url': 'file:///main.dart',
        'source': {
          'type': 'symbol',
          'text': {'value': 'main', 'start': 0, 'end': 4},
          'path': '/main.dart',
          'range': {
            'start': {'line': 1, 'character': 2},
            'end': {'line': 3, 'character': 4},
          },
          'name': 'main',
          'kind': 2,
        },
      });
      final file = part as FilePart;
      expect(file.mime, 'text/plain');
      final source = file.source as SymbolSource;
      expect(source.name, 'main');
      expect(source.range.start.line, 1);
    });

    test('parses snapshot', () {
      final part = MessagePart.fromJson({
        ...basePart('snapshot'),
        'snapshot': 'sha-abc',
      });
      expect((part as SnapshotPart).snapshot, 'sha-abc');
    });

    test('parses patch', () {
      final part = MessagePart.fromJson({
        ...basePart('patch'),
        'hash': 'h',
        'files': ['a.dart', 'b.dart'],
      });
      final patch = part as PatchPart;
      expect(patch.hash, 'h');
      expect(patch.files, ['a.dart', 'b.dart']);
    });

    test('parses agent', () {
      final part = MessagePart.fromJson({
        ...basePart('agent'),
        'name': 'explore',
        'source': {'value': 'text', 'start': 0, 'end': 4},
      });
      final agent = part as AgentPart;
      expect(agent.name, 'explore');
      expect(agent.source?.value, 'text');
    });

    test('parses retry with ApiError', () {
      final part = MessagePart.fromJson({
        ...basePart('retry'),
        'attempt': 1,
        'error': {'name': 'APIError', 'data': {'message': 'rate limited', 'isRetryable': true}},
        'time': {'created': 123},
      });
      final retry = part as RetryPart;
      expect(retry.attempt, 1);
      expect(retry.error.name, 'APIError');
      expect(retry.error.message, 'rate limited');
      expect(retry.time.created, 123);
    });

    test('maps tail_start_id to tailStartID', () {
      final part = MessagePart.fromJson({
        ...basePart('compaction'),
        'auto': true,
        'overflow': false,
        'tail_start_id': 'msg_0',
      });
      final compaction = part as CompactionPart;
      expect(compaction.auto, true);
      expect(compaction.overflow, false);
      expect(compaction.tailStartID, 'msg_0');
    });

    test('writes tail_start_id on toJson', () {
      const part = CompactionPart(
        id: 'prt_1',
        sessionID: 'ses_1',
        messageID: 'msg_1',
        auto: true,
        tailStartID: 'msg_0',
      );
      final json = part.toJson();
      expect(json['tail_start_id'], 'msg_0');
      expect(json.containsKey('tailStartID'), isFalse);
      expect(json['type'], 'compaction');
    });

    test('parses subtask', () {
      final part = MessagePart.fromJson({
        ...basePart('subtask'),
        'prompt': 'p',
        'description': 'd',
        'agent': 'explore',
        'model': {'providerID': 'anthropic', 'modelID': 'claude-3', 'variant': 'xhigh'},
      });
      final subtask = part as SubtaskPart;
      expect(subtask.prompt, 'p');
      expect(subtask.model?.providerID, 'anthropic');
      expect(subtask.command, isNull);
    });

    test('round-trips every variant through toJson', () {
      final parts = <MessagePart>[
        MessagePart.text(id: 'a', sessionID: 's', messageID: 'm', text: 'hi'),
        MessagePart.reasoning(id: 'a', sessionID: 's', messageID: 'm', text: 'r', time: const PartTime(start: 1)),
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
          tokens: const Tokens(input: 1, output: 1, reasoning: 1, cache: CacheTokens(read: 1, write: 1)),
        ),
        MessagePart.file(id: 'a', sessionID: 's', messageID: 'm', mime: 'text', url: 'file:///a'),
        MessagePart.snapshot(id: 'a', sessionID: 's', messageID: 'm', snapshot: 'snap'),
        MessagePart.patch(id: 'a', sessionID: 's', messageID: 'm', hash: 'h', files: const ['a']),
        MessagePart.agent(id: 'a', sessionID: 's', messageID: 'm', name: 'explore'),
        MessagePart.retry(
          id: 'a',
          sessionID: 's',
          messageID: 'm',
          attempt: 1,
          error: const ApiError(name: 'APIError', data: {'message': 'm'}),
          time: const RetryTime(created: 1),
        ),
        MessagePart.compaction(id: 'a', sessionID: 's', messageID: 'm', auto: true),
        MessagePart.subtask(id: 'a', sessionID: 's', messageID: 'm', prompt: 'p', description: 'd', agent: 'x'),
      ];

      for (final part in parts) {
        final roundTrip = MessagePart.fromJson(
          jsonDecode(jsonEncode(part.toJson())) as Map<String, dynamic>,
        );
        expect(roundTrip, part, reason: 'round-trip failed for ${part.runtimeType}');
      }
    });

    test('throws on unknown type', () {
      expect(
        () => MessagePart.fromJson({...basePart('mystery')}),
        throwsA(isA<CheckedFromJsonException>()),
      );
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

    test('parses completed with attachments', () {
      final state = ToolState.fromJson({
        'status': 'completed',
        'input': {'command': 'ls'},
        'output': 'out',
        'title': 'ls',
        'metadata': <String, dynamic>{},
        'time': {'start': 1, 'end': 2},
        'attachments': [
          {
            'id': 'prt_x',
            'sessionID': 'ses_1',
            'messageID': 'msg_1',
            'type': 'file',
            'mime': 'text/plain',
            'url': 'file:///a.txt',
          },
        ],
      });
      final completed = state as ToolStateCompleted;
      expect(completed.output, 'out');
      expect(completed.attachments, hasLength(1));
      expect(completed.attachments?.first.mime, 'text/plain');
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
        () => ToolState.fromJson({'status': 'unknown', 'input': <String, dynamic>{}, 'time': {'start': 1}}),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });

  group('FilePartSource', () {
    test('parses file source', () {
      final source = FilePartSource.fromJson({
        'type': 'file',
        'text': {'value': 'v', 'start': 0, 'end': 1},
        'path': '/a.dart',
      });
      expect((source as FileSource).path, '/a.dart');
    });

    test('parses resource source', () {
      final source = FilePartSource.fromJson({
        'type': 'resource',
        'text': {'value': 'v', 'start': 0, 'end': 1},
        'clientName': 'web',
        'uri': 'https://example.com',
      });
      final resource = source as ResourceSource;
      expect(resource.clientName, 'web');
      expect(resource.uri, 'https://example.com');
    });

    test('throws on unknown type', () {
      expect(
        () => FilePartSource.fromJson({'type': 'mystery', 'text': {'value': 'v', 'start': 0, 'end': 1}}),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });

  group('ApiError', () {
    test('exposes message from data', () {
      const error = ApiError(name: 'APIError', data: {'message': 'boom'});
      expect(error.message, 'boom');
    });

    test('returns empty message when data is missing', () {
      const error = ApiError(name: 'APIError');
      expect(error.message, '');
    });
  });
}
