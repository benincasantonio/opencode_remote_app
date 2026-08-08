import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opencode_remote_app/data/models/models.dart';

import 'fixtures.dart';

void main() {
  group('Session', () {
    test('parses the session list fixture', () {
      final sessions = loadFixtureList(
        'session_list',
      ).map((json) => Session.fromJson(json as Map<String, dynamic>)).toList();

      expect(sessions, isNotEmpty);
      final session = sessions.first;
      expect(session.id, 'ses_228065a50ffe1EqJiRf52UStJu');
      expect(session.slug, 'quick-canyon');
      expect(session.projectID, 'global');
      expect(session.directory, '/Users/antoniobenincasa');
      expect(session.title, contains('Tickets for resource scripts'));
      expect(session.version, '1.14.25');
      expect(session.parentID, isNull);
      expect(session.cost, 0);
      expect(session.tokens?.input, 9259);
      expect(session.tokens?.output, 288);
      expect(session.tokens?.reasoning, 687);
      expect(session.tokens?.cache.read, 12800);
      expect(session.tokens?.cache.write, 0);
      expect(session.summary?.additions, 0);
      expect(session.summary?.deletions, 0);
      expect(session.summary?.files, 0);
      expect(session.time.created, 1777444955568);
      expect(session.time.updated, 1777444986582);
    });

    test('parses parentID and permission when present', () {
      final sessions = loadFixtureList(
        'session_list',
      ).map((json) => Session.fromJson(json as Map<String, dynamic>)).toList();

      final session = sessions.firstWhere(
        (session) => session.parentID != null,
      );
      expect(session.parentID, 'ses_23ede5db1ffedcwtYD48GytLNJ');
      expect(session.permission, isNotEmpty);
    });

    test('parses the created session fixture', () {
      final session = Session.fromJson(loadFixtureJson('session_create'));
      expect(session.id, 'ses_01e20610bffeUwj04karYwal3V');
      expect(session.slug, 'eager-panda');
      expect(session.title, 'Fixture session');
      expect(session.path, '');
      expect(session.cost, 0);
    });

    test('toJson round-trips through fromJson', () {
      final session = Session.fromJson(loadFixtureJson('session_create'));
      final roundTrip = Session.fromJson(
        jsonDecode(jsonEncode(session.toJson())) as Map<String, dynamic>,
      );
      expect(roundTrip, session);
    });
  });

  group('SessionStatus', () {
    test('parses idle', () {
      expect(
        SessionStatus.fromJson({'type': 'idle'}),
        const SessionStatus.idle(),
      );
    });

    test('parses busy', () {
      expect(
        SessionStatus.fromJson({'type': 'busy'}),
        const SessionStatus.busy(),
      );
    });

    test('parses retry with action', () {
      final status = SessionStatus.fromJson({
        'type': 'retry',
        'attempt': 2,
        'message': 'model error',
        'next': 3000,
        'action': {
          'reason': 'provider',
          'provider': 'anthropic',
          'title': 'Reconnect',
          'message': 'Reconnect to Anthropic',
          'label': 'Reconnect',
          'link': 'https://example.com/auth',
        },
      });

      final retry = status as SessionStatusRetry;
      expect(retry.attempt, 2);
      expect(retry.message, 'model error');
      expect(retry.next, 3000);
      expect(retry.action?.provider, 'anthropic');
      expect(retry.action?.label, 'Reconnect');
      expect(retry.action?.link, 'https://example.com/auth');
    });

    test('parses retry without action', () {
      final status = SessionStatus.fromJson({
        'type': 'retry',
        'attempt': 1,
        'message': 'boom',
        'next': 1000,
      });
      final retry = status as SessionStatusRetry;
      expect(retry.action, isNull);
    });

    test('toJson round-trips through fromJson', () {
      final status = SessionStatus.fromJson({
        'type': 'retry',
        'attempt': 2,
        'message': 'model error',
        'next': 3000,
        'action': {
          'reason': 'provider',
          'provider': 'anthropic',
          'title': 't',
          'message': 'm',
          'label': 'l',
        },
      });
      final roundTrip = SessionStatus.fromJson(
        jsonDecode(jsonEncode(status.toJson())) as Map<String, dynamic>,
      );
      expect(roundTrip, status);
    });

    test('throws on unknown type', () {
      expect(
        () => SessionStatus.fromJson({'type': 'unknown'}),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });

  group('CreateSessionInput', () {
    test('serializes to the POST body shape', () {
      final input = CreateSessionInput(
        title: 'My session',
        model: const SessionModel(
          id: 'gpt-5.4',
          providerID: 'github-copilot',
          variant: 'xhigh',
        ),
      );
      final json =
          jsonDecode(jsonEncode(input.toJson())) as Map<String, dynamic>;
      expect(json['title'], 'My session');
      final model = json['model'] as Map<String, dynamic>;
      expect(model['id'], 'gpt-5.4');
      expect(model['providerID'], 'github-copilot');
      expect(model['variant'], 'xhigh');
    });

    test('omits absent fields as nulls', () {
      final json = const CreateSessionInput().toJson();
      expect(json.keys, hasLength(7));
      expect(json.values.every((value) => value == null), isTrue);
    });
  });
}
