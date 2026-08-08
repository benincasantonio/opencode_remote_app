# Tickets

This document lists all implementation tickets with detailed descriptions and acceptance criteria.

Testing policy: Unit and integration tests are important from the beginning and should be added alongside each feature, in the same PR that implements the feature.

## Structure (Aug 2026)

Tickets are organized **by feature**, not by technical layer. Each feature is a vertical slice: it builds exactly the models, datasources, repositories, providers, and UI it needs — **when it needs them**. Nothing is built ahead of time (no model phases, no datasource phases). If a model type is not consumed by a shipped feature, it does not exist yet.

---

## Old Ticket Map

The original phase-based tickets were restructured into features. Mapping so nothing is lost:

| Old ticket | Where it went |
|---|---|
| P1-01..P1-11 (bootstrap) | Completed (below) |
| P2-01..P2-10 (widgets) | Completed (below) |
| P3-01 Dio client | F0 Foundation |
| P3-02 Firebase service | F6 Push Notifications |
| P3-03 mDNS discovery | Completed (below) |
| P3-04 Crashlytics | F7 Polish |
| P4-01 Chat data models | Merged (PR #48); owned by F2/F3 |
| P4-02 Config/Provider/Agent models | F3 Chat (model/agent selector) |
| P4-03 File & search models | F4 File Browser |
| P4-04 Server models & events | Split: health → F1, events → F3, **project model dropped for v1** |
| P4-09 NotificationToken | F6 Push Notifications |
| P5-01..P5-03 Datasources | Split across F1/F2/F3/F4/F6 |
| P6-01..P6-06 Repositories | Split across F1/F2/F3/F4/F6 |
| P7-01..P7-09 Providers | Split across F1/F2/F3/F4/F6 |
| P8-01..P8-03 Routing & shell | F0 Foundation |
| P9-01..P9-06 Connect/Home | F1 Connect & Dashboard |
| P10-01..P10-09 Sessions/Chat | F2 Sessions, F3 Chat |
| P11-01..P11-03 SSE | F3 Chat |
| P12-01..P12-03 File browser | F4 File Browser |
| P13-01..P13-02 Settings | F5 Settings |
| P14-01..P14-12 Firebase + Rust | F6 Push Notifications |
| P15-01..P15-12 Polish & tests | F7 Polish |

---

## Completed

### P1 - Project Bootstrap
- P1-01 Dependencies, P1-02 Folder structure, P1-03 api_constants, P1-04 app_constants, P1-05 app_colors, P1-06 app_typography, P1-07 app_theme, P1-08 app_exception, P1-09 error_handler (+ tests), P1-10 logger, P1-11 extensions. All merged.

### P2 - UI Building Blocks
- P2-01 TerminalText, P2-02 CodeBlock, P2-03 LoadingIndicator, P2-04 AppErrorWidget, P2-05 ConnectionBadge, P2-06 MarkdownRenderer, P2-07 TerminalAppBar, P2-08 AppButton, P2-09 widget tests, P2-10 error snackbar system, P2-00 Widgetbook. All merged.

### P3-03 - mDNS Discovery Service
- mDNS discovery service + debug screen (#40). Merged.

### P4-01 - Chat Data Models (merged, PR #48)
- `Session`, `SessionStatus` (idle|busy|retry), `CreateSessionInput`, nested types in `session.dart`.
- `MessagePart` union: text, reasoning, tool (ToolState pending/running/completed/error), step-start, step-finish + `OtherPart` fallback (`@Freezed(fallbackUnion: 'other')`).
- `Message` union (User|Assistant), `MessageWithParts`, `MessageError`, `OutputFormat` in `message.dart`.
- `models.dart` barrel; real JSON fixtures; 36 unit tests.
- These models are consumed by F2 (Sessions) and F3 (Chat); no rework expected.

---

## F0 - Foundation: API Client & App Shell

Goal: The shared infrastructure every feature depends on — a configured Dio client and the routing/app shell.
Details:
1. Create lib/services/dio_client.dart: Dio instance accepting baseUrl + optional credentials; timeouts; interceptors for logging, auth (Basic), and error mapping to AppException (map 401/403 to AuthException).
2. Create lib/app.dart + lib/presentation/router/app_router.dart: GoRouter with splash + connect routes only; redirect logic based on connection state (routes for later features are added by their own tickets).
3. Update lib/main.dart: ProviderScope wiring, minimal initialization.
Acceptance: DioClient creates a functional configured instance. App boots through the router. Analyzer + tests pass.
Testing: Unit tests for DioClient (baseUrl, timeouts, interceptor behavior with mocked Dio adapter).

## F1 - Connect & Dashboard

Goal: Connect to an OpenCode server (manual entry + mDNS discovery), persist saved servers, and show server health. **Models created here: ServerHealth, SavedServer (+ credentials).**
Details:
1. Models: ServerHealth {healthy, version} for GET /global/health; SavedServer + credentials (local, not API) for persistence.
2. Datasource: local storage (shared_preferences for saved servers, flutter_secure_storage for credentials; CRUD).
3. Repository: ServerRepository — connect, disconnect, health check, saved server list, delete, discovery stream.
4. Providers: connection state notifier (connect/disconnect), server health polling, saved servers, mDNS discovery.
5. UI: SplashScreen (auto-connect saved server), ConnectScreen (manual + discovered server list), HomeScreen with ServerStatusWidget (server name, version, health badge, disconnect).
Acceptance: User can connect via manual entry or discovered server, persists across launches, and sees live health status on Home. Analyzer + tests pass.
Testing: Unit tests for storage + repository with mocks; widget tests for Connect/Home screens with provider overrides.

## F2 - Sessions

Goal: List, create, and delete sessions. Consumes the P4-01 Session models (no new models).
Details:
1. Datasource: session endpoints — GET /session (with scope/search/limit query), POST /session, DELETE /session/:id, GET /session/status.
2. Repository: SessionRepository — list, create, delete, status.
3. Providers: sessions list, session statuses; invalidate on changes.
4. UI: SessionsListScreen (pull-to-refresh, swipe-to-delete, FAB), SessionTile, NewSessionDialog. Home screen shows recent sessions (navigate to chat when F3 lands).
Acceptance: Sessions list loads from the server, sessions can be created and deleted, statuses reflect busy/idle/retry. Analyzer + tests pass.
Testing: Unit tests for repository with mocked datasource; widget tests for the list screen (loading/data/error states).

## F3 - Chat

Goal: Send prompts and view AI responses with live updates. Consumes P4-01 Message/Part models. **Models created here: ServerEvent envelope + typed events (SSE), Config/Provider/Agent models (model & agent selector in the input).**
Details:
1. Models: ServerEvent {id, type, properties} union — session.created/updated/deleted, message.updated/removed, message.part.updated/removed/delta, session.status/idle, session.error, server.connected + unknown fallback. AppConfig (subset of ConfigV1), ProviderListResult {all, default, connected}, ProviderInfo + nested Model, AgentInfo (mode subagent|primary|all).
2. Datasources: message endpoints — GET /session/:id/message (limit/before pagination), POST /session/:id/message, POST /session/:id/prompt_async, POST /session/:id/abort; SSE client on /global/event with reconnect; config endpoints GET /config, GET /provider, GET /config/providers, GET /api/agent.
3. Repositories: MessageRepository (list, send sync, send async), ConfigRepository (config, providers, agents), event stream handling.
4. Providers: messages per session, send action, event stream → invalidate messages/statuses, typing indicator from session status, model/agent options.
5. UI: ChatScreen, MessageBubble (role header + parts), PartRenderer (text/reasoning/tool/step + generic OtherPart row), ToolCallWidget (expandable, state icons), ChatInput (model/agent selector, busy gating), TypingIndicator, session detail view + abort action.
Acceptance: Send a prompt and see the streamed response update live; tool calls render with state; typing indicator shows while busy; model/agent selection is sent with the prompt. Analyzer + tests pass.
Testing: Unit tests for ServerEvent parsing, message pagination, provider invalidation on events; widget tests for chat screen, bubbles, tool calls, input.

## F4 - File Browser

Goal: Browse project files, view file content, and search. **Models created here: FileNode {name, path, absolute, type, ignored}, FileContent {type, content, diff?, patch?, encoding?, mimeType?}, FindMatch, FileStatus.**
Details:
1. Models: FileNode/FileContent/FindMatch/FileStatus matching GET /file, /file/content, /find, /find/file (returns string[]), /file/status.
2. Datasource: file endpoints — GET /file?path=, GET /file/content?path=, GET /find?pattern=, GET /find/file?query=.
3. Repository: FileRepository — list directory, read file, find files (no caching).
4. Providers: directory listing, file content, search.
5. UI: FileBrowserScreen (breadcrumbs + search), FileTreeWidget (tree built client-side from flat listing — dirs first, expand/collapse), FileContentScreen (CodeBlock rendering, copy button).
Acceptance: Navigate directories, open files with syntax highlighting, search by name. Analyzer + tests pass.
Testing: Unit tests for file/search models + repository; widget tests for tree and content screens.

## F5 - Settings

Goal: Manage saved servers and app preferences. Reuses F1's SavedServer models (no new models).
Details:
1. UI: SettingsScreen (server config navigation, notification toggles stub, about section), ServerConfigScreen (saved server CRUD — reuses ServerRepository from F1, test connection, delete, set default).
2. Wire notification toggles to a persisted flag (prefs); the actual push plumbing lands in F6.
Acceptance: Saved servers can be tested/deleted/defaulted; toggles persist. Analyzer + tests pass.
Testing: Widget tests for both screens with provider overrides.

## F6 - Push Notifications

Goal: Firebase Cloud Messaging push notifications via the Rust notifier. **Models created here: NotificationToken.**
Details:
1. Model: NotificationToken {token, label, registeredAt} for the Rust notifier register API.
2. Service: FirebaseService (P3-02) — initialize, getToken, onTokenRefresh, onMessage/OpenedApp/InitialMessage, guarded init so dev runs don't crash.
3. Datasource: Rust notifier API client — POST /devices/register, DELETE /devices/:token, GET /health.
4. Repository: NotificationRepository — register/unregister with token refresh handling.
5. Providers: FCM token, registration state.
6. Rust notifier: cargo scaffold, config module, models, device registry, axum API, SSE listener with backoff, FCM sender, main wiring, example config + README.
7. Deep links: notification payload → sessionId → navigate to chat; in-app banner for foreground messages.
8. Firebase project config: google-services.json / GoogleService-Info.plist.
Acceptance: Device registers with the notifier, token refresh re-registers, notifications navigate to the right session. Analyzer + tests pass.
Testing: Unit tests for NotificationToken + repository with mocked client; deep-link navigation test.

## F7 - Polish

Goal: Hardening and UX finish. **No new models.**
Details:
1. Haptics: HapticService — light on send/tap, medium/heavy on session create and connect/disconnect.
2. Pull-to-refresh on sessions list, file browser, and home.
3. Consistent loading/error states audit (LoadingIndicator + AppErrorWidget everywhere; remove ad-hoc spinners).
4. Crashlytics (P3-04) + logger integration.
5. Auto-reconnect with exponential backoff in connection state; SSE re-init on success.
6. Test hardening: coverage audit for models/repos/providers/screens, integration tests for connect → chat and notification deep links.
Acceptance: Consistent UX states, haptics present, reconnect works, integration tests pass. Analyzer passes.
