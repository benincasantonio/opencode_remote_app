import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/message_providers.dart';
import '../../../domain/providers/server_providers.dart';
import '../../../domain/providers/session_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import 'chat_empty_view.dart';
import 'load_earlier_button.dart';
import 'message_bubble.dart';

/// Read-only transcript for one OpenCode session.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  var _didScrollToLatest = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sessionId = widget.sessionId;
    final connection = ref.watch(connectionProvider);
    final healthPolling = ref.watch(healthPollingProvider);
    final messagesAsync = ref.watch(messagesProvider(sessionId));

    final health = healthPolling.value ?? connection.health;
    final ConnectionStatus status;
    if (healthPolling.hasError || health == null) {
      status = ConnectionStatus.error;
    } else if (!health.healthy) {
      status = ConnectionStatus.unhealthy;
    } else {
      status = ConnectionStatus.connected;
    }

    final transcript = messagesAsync.asData?.value;
    if (transcript != null &&
        transcript.messages.isNotEmpty &&
        !_didScrollToLatest) {
      _didScrollToLatest = true;
      _jumpToLatest();
    }

    return Scaffold(
      appBar: TerminalAppBar(title: _title(), connectionStatus: status),
      body: messagesAsync.when(
        data: (transcript) {
          if (transcript.messages.isEmpty) {
            return const ChatEmptyView();
          }
          final loadingEarlier = transcript.isLoadingEarlier;
          final showEarlier = transcript.hasEarlier;
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: AppSizing.gapSmall),
            itemCount: transcript.messages.length + (showEarlier ? 1 : 0),
            itemBuilder: (context, index) {
              if (showEarlier && index == 0) {
                return LoadEarlierButton(
                  isLoading: loadingEarlier,
                  onPressed: loadingEarlier ? null : () => _loadEarlier(),
                );
              }
              final message =
                  transcript.messages[showEarlier ? index - 1 : index];
              return MessageBubble(
                key: ValueKey(message.info.id),
                message: message,
              );
            },
          );
        },
        loading: () => const Center(child: LoadingIndicator()),
        error: (_, _) => Center(
          child: AppErrorWidget(
            message: l10n.chatErrorTitle,
            onRetry: () => ref.invalidate(messagesProvider(sessionId)),
          ),
        ),
      ),
    );
  }

  String _title() {
    final sessions = ref.watch(sessionsListProvider).asData?.value;
    if (sessions == null) return widget.sessionId;
    for (final session in sessions) {
      if (session.id != widget.sessionId) continue;
      final title = session.title.trim();
      return title.isEmpty ? session.slug : title;
    }
    return widget.sessionId;
  }

  void _jumpToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Future<void> _loadEarlier() async {
    final hasClients = _scrollController.hasClients;
    final beforeOffset = hasClients ? _scrollController.offset : 0.0;
    final beforeExtent = hasClients
        ? _scrollController.position.maxScrollExtent
        : 0.0;
    final ok = await ref
        .read(messagesProvider(widget.sessionId).notifier)
        .loadEarlier();
    if (!mounted) return;
    if (!ok) {
      context.showSnackBar(context.l10n.loadEarlierError);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      final delta = _scrollController.position.maxScrollExtent - beforeExtent;
      final target = (beforeOffset + delta).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.jumpTo(target);
    });
  }
}
