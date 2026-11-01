import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/api_constants.dart';
import '../../data/datasources/message_datasource.dart';
import '../../data/models/message.dart';
import '../../data/repositories/message_repository.dart';
import 'connection_providers.dart';
import 'dio_providers.dart';

part 'message_providers.g.dart';

/// One session transcript, oldest message first.
class Transcript {
  const Transcript({
    required this.messages,
    required this.hasEarlier,
    this.isLoadingEarlier = false,
  });

  final List<MessageWithParts> messages;

  /// True when another page of older messages can be requested.
  final bool hasEarlier;

  /// True while an older page is being fetched. The current page stays visible.
  final bool isLoadingEarlier;
}

@riverpod
MessageDatasource messageDatasource(Ref ref) {
  final client = ref.watch(dioClientProvider);
  return MessageDatasource(client.dio);
}

@riverpod
MessageRepository messageRepository(Ref ref) {
  return MessageRepository(ref.watch(messageDatasourceProvider));
}

/// Loads one page of a session transcript and can prepend older pages.
///
/// The messages fixture and OpenCode's paged list body are both chronological
/// within a page (oldest first). OpenCode also sends `X-Next-Cursor` when
/// older messages exist; that opaque cursor is `before`. A full page with no
/// cursor uses the oldest message id instead. Nothing was listening on port
/// 4096, so a live page was not checked.
@riverpod
class Messages extends _$Messages {
  String? _before;
  CancelToken? _earlierToken;

  @override
  Future<Transcript> build(String sessionId) async {
    ref.watch(
      connectionProvider.select((value) => (value.isConnected, value.baseUrl)),
    );
    final token = CancelToken();
    ref.onDispose(() {
      token.cancel();
      _earlierToken?.cancel();
    });
    final page = await ref
        .watch(messageRepositoryProvider)
        .getMessages(
          sessionId,
          limit: ApiConstants.messagePageLimit,
          cancelToken: token,
        );
    final messages = _oldestFirst(page.messages);
    return Transcript(
      messages: messages,
      hasEarlier: _rememberCursor(page, messages),
    );
  }

  /// Prepends the previous page. Returns false when the request fails.
  Future<bool> loadEarlier() async {
    final before = _before;
    final current = state.asData?.value;
    if (before == null ||
        current == null ||
        !current.hasEarlier ||
        current.isLoadingEarlier ||
        state.isLoading) {
      return true;
    }

    final token = CancelToken();
    _earlierToken?.cancel();
    _earlierToken = token;
    state = AsyncData(
      Transcript(
        messages: current.messages,
        hasEarlier: current.hasEarlier,
        isLoadingEarlier: true,
      ),
    );
    try {
      final page = await ref
          .read(messageRepositoryProvider)
          .getMessages(
            sessionId,
            limit: ApiConstants.messagePageLimit,
            before: before,
            cancelToken: token,
          );
      if (!ref.mounted || token.isCancelled) return true;
      final seen = current.messages.map((message) => message.info.id).toSet();
      final merged = _oldestFirst([
        ...page.messages.where((message) => !seen.contains(message.info.id)),
        ...current.messages,
      ]);
      state = AsyncData(
        Transcript(messages: merged, hasEarlier: _rememberCursor(page, merged)),
      );
      return true;
    } on Object {
      if (!ref.mounted || token.isCancelled) return true;
      state = AsyncData(current);
      return false;
    }
  }

  /// Stores the cursor for the next older page.
  bool _rememberCursor(
    MessageListResult page,
    List<MessageWithParts> accumulated,
  ) {
    final cursor = page.nextCursor?.trim();
    if (cursor != null && cursor.isNotEmpty) {
      _before = cursor;
      return true;
    }
    if (page.messages.length >= ApiConstants.messagePageLimit &&
        accumulated.isNotEmpty) {
      _before = accumulated.first.info.id;
      return true;
    }
    _before = null;
    return false;
  }
}

/// Chronological order. Equal timestamps keep id order.
List<MessageWithParts> _oldestFirst(List<MessageWithParts> messages) {
  final sorted = List<MessageWithParts>.of(messages);
  sorted.sort((a, b) {
    final byTime = _createdAt(a).compareTo(_createdAt(b));
    if (byTime != 0) return byTime;
    return a.info.id.compareTo(b.info.id);
  });
  return sorted;
}

int _createdAt(MessageWithParts message) => switch (message.info) {
  UserMessage(:final time) => time.created,
  AssistantMessage(:final time) => time.created,
};
