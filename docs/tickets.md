# Tickets

This document lists all implementation tickets with detailed descriptions and acceptance criteria.

Testing policy: Unit and integration tests are important from the beginning and should be added alongside each feature. Phase 15 focuses on coverage audits and hardening, not first-time test creation.

## Phase 1 - Project Bootstrap

### P1-01 Update pubspec dependencies
Goal: Add all required packages for the app.
Details: Add runtime deps (flutter_riverpod, riverpod_annotation, dio, go_router, firebase_core, firebase_messaging, freezed_annotation, json_annotation, bonsoir, shared_preferences, flutter_secure_storage, google_fonts, flutter_markdown, flutter_syntax_view, cupertino_icons). Add dev deps (flutter_lints, build_runner, riverpod_generator, freezed, json_serializable, custom_lint, riverpod_lint). Run flutter pub get.
Acceptance: pubspec.yaml contains all dependencies with versions from AGENTS.md. pubspec.lock updated by flutter pub get. flutter pub get completes without errors.

### P1-02 Scaffold folder structure
Goal: Create the initial directory layout and keep empty dirs tracked.
Details: Create all lib/ subdirectories for core, data, domain, presentation, and services per AGENTS.md. Add widget subfolders under presentation/widgets and screen subfolders under presentation/screens. Create test/unit, test/widget, and test/integration directories. Add a .gitkeep file to each empty directory so Git tracks the structure.
Acceptance: Directory tree matches AGENTS.md structure. Empty directories include .gitkeep files.

### P1-03 Create api_constants.dart
Goal: Centralize API endpoints and timeouts.
Details: Create lib/core/constants/api_constants.dart. Define ApiConstants with default host 127.0.0.1 and port 4096. Add OpenCode endpoints: /global/health, /event, /session, /session/:id, /session/:id/message, /session/:id/prompt_async, /file, /file/content, /find, /find/file, /config, /provider, /agent, /auth/:id, /project/current. Add Rust notifier endpoints: /devices/register, /devices/:token, /health. Add timeouts (connect, receive) and SSE reconnect delay constants.
Acceptance: ApiConstants exposes all endpoints and timeouts as static constants. File compiles with no unused imports.

### P1-04 Create app_constants.dart
Goal: Define app-wide constants.
Details: Create lib/core/constants/app_constants.dart. Add constants for app display name, mDNS service type (_opencode._tcp), health polling interval, max reconnect attempts, and Android notification channel ID/name.
Acceptance: AppConstants contains the required values as static constants. File compiles with no unused imports.

### P1-05 Create app_colors.dart
Goal: Create the terminal color palette.
Details: Create lib/core/theme/app_colors.dart. Define AppColors with dark background, surface, surfaceVariant, border, primaryGreen, accentCyan, textPrimary, textSecondary, textMuted, error, warning, success, toolUse, thinking. Use hex values consistent with a dark terminal aesthetic.
Acceptance: AppColors exposes all palette colors as static Color constants. Colors align with the terminal-style theme.

### P1-06 Create app_typography.dart
Goal: Define typography for the terminal theme.
Details: Create lib/core/theme/app_typography.dart. Use GoogleFonts.jetBrainsMono with Fira Code fallback. Provide TextStyles: headlineLarge, headlineMedium, titleLarge, titleMedium, bodyLarge, bodyMedium, bodySmall, codeLarge, codeSmall, label. Default text color should use AppColors.textPrimary unless overridden.
Acceptance: AppTypography provides all required TextStyles. Styles use the monospace font consistently.

### P1-07 Create app_theme.dart
Goal: Assemble ThemeData for the app.
Details: Create lib/core/theme/app_theme.dart. Build ThemeData using Material 3 dark ColorScheme and AppColors. Configure scaffoldBackgroundColor, appBarTheme, cardTheme, inputDecorationTheme, dividerTheme, snackBarTheme, floatingActionButtonTheme. Apply AppTypography text styles globally.
Acceptance: AppTheme.dark returns a complete ThemeData instance. Theme uses the terminal palette and typography.

### P1-08 Create app_exception.dart
Goal: Define a structured exception hierarchy.
Details: Create lib/core/errors/app_exception.dart. Add base AppException with message and optional stackTrace. Add subclasses: NetworkException, ServerException (statusCode, responseBody), AuthException, TimeoutException, ParseException, CacheException, SseException. Override toString for readable error messages.
Acceptance: AppException hierarchy compiles and covers all error types. ServerException captures HTTP status and response body.

### P1-09 Create error_handler.dart
Goal: Map low-level errors to AppException.
Details: Create lib/core/errors/error_handler.dart. Implement mapDioException(DioException) -> AppException with proper mapping for timeouts, bad responses (401/403 -> AuthException), connection errors, and defaults. Add handle(error, stackTrace) that logs and returns AppException.
Acceptance: ErrorHandler maps Dio errors consistently. All methods compile and are unit-testable.

### P1-09a Unit tests for error handling
Goal: Verify error mapping behavior early.
Details: Create unit tests for mapDioException and handle. Cover timeouts, 401/403, connection error, and default mapping cases.
Acceptance: Tests pass and cover expected mappings and messages.

### P1-10 Create logger.dart
Goal: Provide a simple logging utility.
Details: Create lib/core/utils/logger.dart. Add Logger.debug/info/warning/error methods. Use dart:developer log with a timestamped tag. error() should accept optional error and stackTrace. In debug builds, also print to console for visibility.
Acceptance: Logger methods compile and log consistently. Error logs include stackTrace when provided.

### P1-11 Create extensions.dart
Goal: Add convenience extensions for common tasks.
Details: Create lib/core/utils/extensions.dart. StringX: truncate, capitalize, isValidUrl. DateTimeX: timeAgo, formatShort. BuildContextX: theme, textTheme, colorScheme, mediaQuery, showSnackBar helpers. AsyncValueX: helpers for common loading and error rendering patterns.
Acceptance: Extensions compile and are usable across the app. No unused imports or analyzer warnings.

## Phase 2 - UI Building Blocks

### P2-01 Create TerminalText widget
Goal: Create a monospace text building block.
Details: Create lib/presentation/widgets/terminal_text/terminal_text.dart. Props: text, style override, color, fontSize, maxLines, overflow, selectable. Use AppTypography and AppColors by default. When selectable is true, render SelectableText.
Acceptance: TerminalText renders with the terminal font and colors. Optional props override defaults correctly.

### P2-02 Create CodeBlock widget
Goal: Create a reusable code block widget.
Details: Create lib/presentation/widgets/code_block/code_block.dart. Props: code, language, showLineNumbers, maxHeight. Use flutter_syntax_view for syntax highlighting with a styled container. Add a copy-to-clipboard icon button in the top-right corner. Support horizontal scrolling for long lines.
Acceptance: CodeBlock renders code with syntax highlighting. Copy button copies full code to clipboard. Long lines scroll horizontally.

### P2-03 Create LoadingIndicator widget
Goal: Create a terminal-styled loading indicator.
Details: Create lib/presentation/widgets/loading_indicator/loading_indicator.dart. Support small and large variants via a size enum. Use CircularProgressIndicator with AppColors.primaryGreen. Large variant optionally shows a message below the spinner.
Acceptance: LoadingIndicator renders both size variants. Large variant shows message when provided.

### P2-04 Create AppErrorWidget
Goal: Create a reusable error display widget.
Details: Create lib/presentation/widgets/app_error_widget/app_error_widget.dart. Props: message, onRetry, compact. Full mode: error icon, message text, retry button. Compact mode: single row with icon, message, retry icon button. Use AppButton and terminal styling.
Acceptance: AppErrorWidget displays error text and triggers retry. Compact mode fits in tight spaces.

### P2-05 Create ConnectionBadge widget
Goal: Create a connection status badge widget.
Details: Create lib/presentation/widgets/connection_badge/connection_badge.dart. Status enum: connected, connecting, disconnected, error. Render a colored dot + label + optional server name. Animate the dot when status is connecting.
Acceptance: ConnectionBadge shows correct colors and labels. Connecting state animates.

### P2-06 Create MarkdownRenderer widget
Goal: Create a markdown rendering widget.
Details: Create lib/presentation/widgets/markdown_renderer/markdown_renderer.dart. Wrap flutter_markdown with terminal typography and colors. Style links with AppColors.accentCyan. Render code blocks using the CodeBlock widget. Support selectable text.
Acceptance: MarkdownRenderer renders text, links, and code blocks correctly. Code blocks use CodeBlock styling.

### P2-07 Create TerminalAppBar widget
Goal: Create a terminal-styled app bar.
Details: Create lib/presentation/widgets/app_bar/app_bar.dart. Return a PreferredSizeWidget. Props: title, actions, leading, showConnectionBadge. Style with AppColors surface and a subtle bottom border. Include ConnectionBadge when enabled.
Acceptance: TerminalAppBar renders with terminal styling. ConnectionBadge appears when enabled.

### P2-08 Create AppButton widget
Goal: Create a reusable button component.
Details: Create lib/presentation/widgets/app_button/app_button.dart. Variants: primary, secondary, destructive, ghost. Props: label, onPressed, isLoading, icon. Show a small spinner when isLoading is true. Apply AppTypography and AppColors.
Acceptance: AppButton renders all variants correctly. Loading state disables button and shows spinner.

### P2-09 Widget tests for building blocks
Goal: Validate core UI components early.
Details: Add widget tests for TerminalText, ConnectionBadge, AppButton, AppErrorWidget, and LoadingIndicator with key props and interactions.
Acceptance: Widget tests pass for all building blocks.

## Phase 3 - Services Layer

### P3-01 Create Dio client service
Goal: Provide a configured Dio instance for the app.
Details: Create lib/services/dio_client.dart. Build a DioClient that accepts baseUrl and optional credentials. Configure timeouts, JSON response type, and interceptors for logging, auth, and error mapping. Expose the Dio instance and a dispose method.
Acceptance: DioClient creates a functional Dio instance with interceptors and configurable baseUrl.

### P3-02 Create Firebase service
Goal: Centralize Firebase and FCM behavior.
Details: Create lib/services/firebase_service.dart. Implement initialize(), getToken(), onTokenRefresh(), onMessage(), onMessageOpenedApp(), getInitialMessage(). Guard with try and catch so app can run before Firebase is configured.
Acceptance: FirebaseService compiles and exposes all required methods. App startup can call initialize without crashing in dev.

### P3-03 Create mDNS discovery service
Goal: Discover OpenCode servers on the local network.
Details: Create lib/services/mdns_service.dart using bonsoir. Implement startDiscovery() returning a stream of discovered servers and stopDiscovery() to release resources. Maintain a list of currently discovered servers and emit updates on changes.
Acceptance: MdnsService can start and stop discovery and emit discovered servers.

### P3-04 Unit tests for services
Goal: Validate service behavior early.
Details: Add unit tests for DioClient (interceptors, baseUrl, timeouts), FirebaseService guard behavior, and MdnsService start/stop lifecycle (with mocks).
Acceptance: Service tests pass with key behaviors covered.

## Phase 4 - Data Models

### P4-01 Create ServerHealth model
Goal: Represent server health responses.
Details: Create lib/data/models/server_health.dart as a Freezed class with fields healthy and version. Add fromJson and toJson.
Acceptance: ServerHealth parses the /global/health response.

### P4-02 Create Session models
Goal: Represent sessions and session status.
Details: Create lib/data/models/session.dart. Define Session with id, title, createdAt, updatedAt, parentID, share. Define SessionStatus as a Freezed union with idle, busy, error variants. Add fromJson and toJson.
Acceptance: Session and SessionStatus parse API responses from /session and /session/status.

### P4-03 Create Message and Part models
Goal: Represent messages and parts in sessions.
Details: Create lib/data/models/message.dart. Define Message with id, role, sessionID, createdAt, error, metadata. Define Part union with text, toolUse, toolResult, thinking. Define MessageWithParts wrapper with info and parts. Add fromJson and toJson.
Acceptance: MessageWithParts parses /session/:id/message responses correctly.

### P4-04 Create Project model
Goal: Represent the current project.
Details: Create lib/data/models/project.dart. Define Project with id, name, path. Add fromJson and toJson.
Acceptance: Project parses /project/current response.

### P4-05 Create Config and Provider models
Goal: Represent server config and provider list.
Details: Create lib/data/models/config.dart. Define AppConfig, ProviderInfo, ProviderModel with fields matching /config and /provider responses. Add fromJson and toJson.
Acceptance: Config models parse /config and /provider responses.

### P4-06 Create FileNode and FileContent models
Goal: Represent file tree nodes and file content.
Details: Create lib/data/models/file_node.dart. Define FileNode with name, path, type, and optional children. Define FileContent with content and type. Add fromJson and toJson.
Acceptance: File models parse /file and /file/content responses.

### P4-07 Create Agent model
Goal: Represent OpenCode agents.
Details: Create lib/data/models/agent.dart. Define Agent with id, name, description, mode. Add fromJson and toJson.
Acceptance: Agent parses /agent responses.

### P4-08 Create ServerEvent model
Goal: Represent SSE events.
Details: Create lib/data/models/server_event.dart as a Freezed union. Add variants for sessionUpdated, sessionStatusChanged, messageUpdated, partUpdated, serverConnected, and unknown. Implement factory fromSseData to map event type and data.
Acceptance: ServerEvent can parse SSE payloads into typed events.

### P4-09 Create NotificationToken model
Goal: Represent device notification registration.
Details: Create lib/data/models/notification_token.dart with fields token, label, registeredAt. Add fromJson and toJson.
Acceptance: NotificationToken matches Rust notifier register API payload.

### P4-10 Unit tests for models
Goal: Validate Freezed DTO serialization early.
Details: Add unit tests for core models (ServerHealth, Session/SessionStatus, Message/Part, Project, Config/Provider, FileNode/FileContent, Agent, ServerEvent, NotificationToken). Focus on fromJson/toJson and union parsing.
Acceptance: Model tests pass and cover serialization edge cases.

## Phase 5 - Data Sources

### P5-01 Implement OpenCode API client
Goal: Access OpenCode server endpoints via Dio.
Details: Create lib/data/datasources/opencode_api.dart. Implement methods for health, sessions, messages, files, config, providers, agents, auth, and project endpoints. Each method calls Dio and maps the response to Freezed models.
Acceptance: OpencodeApi covers all endpoints used by the app and returns typed models.

### P5-02 Implement SSE client
Goal: Stream server events in real time.
Details: Create lib/data/datasources/sse_client.dart. Open a Dio streaming request to /event, parse SSE lines, map to ServerEvent, and emit a Stream. Implement reconnect with delay after disconnection.
Acceptance: SSE client emits ServerEvent objects and reconnects on failures.

### P5-03 Implement local storage layer
Goal: Provide persisted server configs and secure credential storage.
Details: Create lib/data/datasources/local_storage.dart. Use shared_preferences for saved servers and lightweight flags. Use flutter_secure_storage for credentials. Provide CRUD methods for server configs and credential storage.
Acceptance: LocalStorage supports save, read, and delete for saved servers and credentials.

## Phase 6 - Repositories

### P6-01 Implement ServerRepository
Goal: Manage connection and server discovery.
Details: Create lib/data/repositories/server_repository.dart. Integrate OpencodeApi, LocalStorage, and MdnsService. Implement connect, disconnect, health check, saved server list, delete server, and discovery stream.
Acceptance: ServerRepository can connect, persist servers, and expose discovery and health info.

### P6-02 Implement SessionRepository
Goal: Manage session operations.
Details: Create lib/data/repositories/session_repository.dart. Implement list, get, create, delete, fork, share, abort, and status methods.
Acceptance: SessionRepository returns sessions and session status from network calls.

### P6-03 Implement MessageRepository
Goal: Manage message operations.
Details: Create lib/data/repositories/message_repository.dart. Implement list messages, get message, send prompt sync, and send prompt async.
Acceptance: MessageRepository returns messages per session and sends prompts.

### P6-04 Implement FileRepository
Goal: Access file endpoints.
Details: Create lib/data/repositories/file_repository.dart. Implement list directory, read file, search text, and find files. No caching required.
Acceptance: FileRepository provides access to file browsing features.

### P6-05 Implement ConfigRepository
Goal: Access config, providers, and agents.
Details: Create lib/data/repositories/config_repository.dart. Implement getConfig, listProviders, listAgents, and setAuth.
Acceptance: ConfigRepository returns typed config and provider data.

### P6-06 Implement NotificationRepository
Goal: Register devices with the Rust notifier.
Details: Create lib/data/repositories/notification_repository.dart. Implement registerDevice, unregisterDevice, and health check using a Dio client pointed at the Rust notifier base URL.
Acceptance: NotificationRepository can register and unregister device tokens.

## Phase 7 - Riverpod Providers

### P7-01 Connection providers
Goal: Provide connection state and core clients.
Details: Create lib/domain/providers/connection_providers.dart. Provide LocalStorage, DioClient, current server config, and a connection state notifier with connect and disconnect methods.
Acceptance: Providers expose connection state and current server info.

### P7-02 Server providers
Goal: Expose server data and discovery streams.
Details: Create lib/domain/providers/server_providers.dart. Provide ServerRepository, serverHealthProvider with polling, savedServersProvider, and mdnsDiscoveryProvider.
Acceptance: Server providers supply health and discovery data to the UI.

### P7-03 Session providers
Goal: Expose session data to UI.
Details: Create lib/domain/providers/session_providers.dart. Provide SessionRepository, sessionsListProvider, sessionDetailProvider family, and sessionStatusesProvider.
Acceptance: Providers return AsyncValue for session data.

### P7-04 Message providers
Goal: Expose messages to the chat UI.
Details: Create lib/domain/providers/message_providers.dart. Provide MessageRepository, messagesProvider family, and a sendMessage provider method that invalidates messages on success.
Acceptance: Messages update when a new prompt is sent.

### P7-05 File providers
Goal: Expose file browsing data.
Details: Create lib/domain/providers/file_providers.dart. Provide FileRepository, directoryListingProvider, fileContentProvider, and fileSearchProvider families.
Acceptance: Providers return file data for the browser screens.

### P7-06 Config providers
Goal: Expose config and provider lists.
Details: Create lib/domain/providers/config_providers.dart. Provide ConfigRepository, appConfigProvider, providersListProvider, and agentsListProvider.
Acceptance: Providers return config and provider data to the UI.

### P7-07 Event providers
Goal: Expose SSE events to the app.
Details: Create lib/domain/providers/event_providers.dart. Provide SseClient, eventStreamProvider, and an event handler that invalidates relevant providers on events.
Acceptance: Event providers trigger data refresh on SSE updates.

### P7-08 Notification providers
Goal: Manage FCM token registration via providers.
Details: Create lib/domain/providers/notification_providers.dart. Provide FirebaseService, fcmTokenProvider, NotificationRepository, and notificationRegistrationProvider that registers tokens.
Acceptance: Tokens register automatically and update on refresh.

### P7-09 Run build_runner for providers
Goal: Generate Riverpod and model code.
Details: Run dart run build_runner build --delete-conflicting-outputs. Resolve any generator errors or missing imports.
Acceptance: All generated files are present and analyzer passes.

## Phase 8 - Routing and App Shell

### P8-01 Configure GoRouter
Goal: Define all routes and redirects.
Details: Create lib/presentation/router/app_router.dart. Add routes for splash, connect, home, sessions, chat/:id, files, file content, and settings. Add redirect logic based on connection state and support deep links for notifications.
Acceptance: Routing works for all screens and redirects appropriately.

### P8-02 Create app.dart
Goal: Wire up MaterialApp.router.
Details: Create lib/app.dart with MaterialApp.router, AppTheme.dark, and routerConfig from app_router.dart. Wrap in error boundary if needed.
Acceptance: App renders with the correct theme and router.

### P8-03 Update main.dart
Goal: Initialize core services and launch the app.
Details: Ensure WidgetsFlutterBinding is initialized, start FirebaseService, and run App within ProviderScope with overrides.
Acceptance: App starts without the default counter UI and initializes services.

## Phase 9 - Connect and Home Screens

### P9-01 Create SplashScreen
Goal: Provide a startup experience and auto-connect logic.
Details: Create lib/presentation/screens/splash/splash_screen.dart. Show logo and LoadingIndicator. Check for saved server and attempt auto-connect, then route to home or connect.
Acceptance: SplashScreen routes correctly based on connection availability.

### P9-02 Create ManualConnectWidget
Goal: Allow manual server entry.
Details: Create lib/presentation/screens/connect/manual_connect_widget.dart. Provide fields for host, port, username, password, and buttons for test and connect. Validate inputs and show results.
Acceptance: Manual connection can be tested and saved.

### P9-03 Create ServerListWidget
Goal: Show saved and discovered servers.
Details: Create lib/presentation/screens/connect/server_list_widget.dart. List saved servers with delete action and discovered servers from mDNS. Tapping a server triggers connection.
Acceptance: Saved and discovered servers render and connect on tap.

### P9-04 Create ConnectScreen
Goal: Combine manual and discovery connection flows.
Details: Create lib/presentation/screens/connect/connect_screen.dart. Use tabs or segmented control to switch between manual entry and discovery list. Start and stop discovery appropriately.
Acceptance: User can connect via manual or discovered server.

### P9-05 Create ServerStatusWidget
Goal: Display server health status.
Details: Create lib/presentation/screens/home/server_status_widget.dart. Show server name, version, health badge, and a disconnect action. Consume serverHealthProvider and connectionStateProvider.
Acceptance: Server status updates from provider data.

### P9-06 Create HomeScreen
Goal: Provide the main dashboard.
Details: Create lib/presentation/screens/home/home_screen.dart. Show ServerStatusWidget, recent sessions list, and quick action buttons for new session, files, and settings.
Acceptance: Home screen loads and navigates to core features.

## Phase 10 - Sessions and Chat

### P10-01 Create SessionTile widget
Goal: Standardize session list items.
Details: Create lib/presentation/screens/sessions/session_tile.dart. Show session title, timestamp, and status badge. Support tap and long-press actions.
Acceptance: SessionTile displays correct metadata and status.

### P10-02 Create NewSessionDialog
Goal: Allow session creation.
Details: Create lib/presentation/screens/sessions/new_session_dialog.dart. Provide title input and optional parent session selector. Create session on submit and navigate to chat.
Acceptance: New session is created and navigated to chat.

### P10-03 Create SessionsListScreen
Goal: List and manage sessions.
Details: Create lib/presentation/screens/sessions/sessions_list_screen.dart. Display list of sessions with pull-to-refresh and swipe-to-delete. Include FAB to create new session.
Acceptance: Sessions list refreshes and deletes sessions correctly.

### P10-04 Create ChatInput
Goal: Provide message input UI.
Details: Create lib/presentation/screens/chat/chat_input.dart. Include text input, send button, and model or agent selector. Disable send when empty or busy.
Acceptance: ChatInput sends prompts and clears on success.

### P10-05 Create TypingIndicator
Goal: Show AI processing state.
Details: Create lib/presentation/screens/chat/typing_indicator.dart. Render animated dots with terminal styling. Control visibility via a bool property.
Acceptance: TypingIndicator animates and can be toggled.

### P10-06 Create PartRenderer
Goal: Render individual message parts.
Details: Create lib/presentation/screens/chat/part_renderer.dart. Render text with MarkdownRenderer, toolUse and toolResult with ToolCallWidget, and thinking blocks with muted styling.
Acceptance: Each Part type renders correctly.

### P10-07 Create ToolCallWidget
Goal: Display tool usage and results.
Details: Create lib/presentation/screens/chat/tool_call_widget.dart. Create an expandable card showing tool name, input JSON, output, and status. Include icons for pending, running, completed, and error states.
Acceptance: ToolCallWidget expands and displays tool details clearly.

### P10-08 Create MessageBubble
Goal: Display a complete chat message.
Details: Create lib/presentation/screens/chat/message_bubble.dart. Render header with role and timestamp, and body with a list of PartRenderer outputs. Different styling for user vs assistant messages.
Acceptance: MessageBubble shows message parts with correct alignment and style.

### P10-09 Create ChatScreen
Goal: Provide the chat experience for a session.
Details: Create lib/presentation/screens/chat/chat_screen.dart. Show list of messages, typing indicator, and ChatInput. Listen to SSE events for live updates. Provide session actions in the app bar.
Acceptance: ChatScreen loads messages, sends prompts, and updates in real time.

## Phase 11 - SSE Integration

### P11-01 Wire SSE to session providers
Goal: Keep session data in sync with SSE updates.
Details: In event handler provider, invalidate sessionsListProvider and sessionDetailProvider when sessionUpdated events arrive. Update session status provider on status events.
Acceptance: Sessions UI updates when SSE events occur.

### P11-02 Wire SSE to message providers
Goal: Keep message data in sync with SSE updates.
Details: In event handler provider, invalidate messagesProvider when messageUpdated or partUpdated events arrive. Use sessionId from the event to target the correct provider.
Acceptance: Chat UI reflects message updates without manual refresh.

### P11-03 Wire SSE to typing indicator
Goal: Show and hide typing indicator based on session status.
Details: Implement a sessionIsTypingProvider that derives from sessionStatusesProvider and exposes a bool for busy status. Bind TypingIndicator visibility to this provider.
Acceptance: Typing indicator appears while the assistant is processing.

## Phase 12 - File Browser

### P12-01 Create FileTreeWidget
Goal: Render a file tree structure.
Details: Create lib/presentation/screens/files/file_tree_widget.dart. Show folders with expand and collapse behavior, files with tap handling. Sort directories first, then files.
Acceptance: FileTreeWidget expands folders and opens files.

### P12-02 Create FileContentScreen
Goal: View file contents.
Details: Create lib/presentation/screens/files/file_content_screen.dart. Fetch file content with fileContentProvider and render using CodeBlock. Add copy button and breadcrumb path display.
Acceptance: File content renders with syntax highlighting and copy support.

### P12-03 Create FileBrowserScreen
Goal: Provide the main file browsing UI.
Details: Create lib/presentation/screens/files/file_browser_screen.dart. Combine search bar, file tree view, and navigation breadcrumbs. Search calls findFiles and displays results.
Acceptance: FileBrowserScreen supports navigation and search.

## Phase 13 - Settings

### P13-01 Create ServerConfigScreen
Goal: Manage saved server connections.
Details: Create lib/presentation/screens/settings/server_config_screen.dart. Show saved servers, allow test and delete actions, and set default server. Provide add server flow.
Acceptance: Server configs can be edited and deleted.

### P13-02 Create SettingsScreen
Goal: Provide a settings hub.
Details: Create lib/presentation/screens/settings/settings_screen.dart. Include server config navigation, notification toggles, about section, and cache clearing actions.
Acceptance: SettingsScreen links to key configuration actions.

## Phase 14 - Firebase and Rust Notifier

### P14-01 Configure Firebase project
Goal: Enable Firebase Cloud Messaging.
Details: Add google-services.json to android/app and GoogleService-Info.plist to ios/Runner. Update Android Gradle to apply Google Services plugin. Update iOS deployment target if required. Run flutter pub get and verify build.
Acceptance: Firebase config files are present and builds succeed.

### P14-02 Implement FCM token registration
Goal: Register devices with the Rust notifier.
Details: On app start, request FCM token and call NotificationRepository.registerDevice. Listen to token refresh and re-register. Persist the last registered token.
Acceptance: Device token is registered and updated on refresh.

### P14-03 Implement notification deep links
Goal: Navigate to sessions from notifications.
Details: Handle getInitialMessage, onMessageOpenedApp, and onMessage. Extract sessionId from payload and navigate to /chat/:sessionId. Show in-app banner for foreground messages.
Acceptance: Notification taps route to the correct session.

### P14-04 Scaffold Rust notifier project
Goal: Initialize the Rust notifier codebase.
Details: Create rust_notifier/ with cargo init. Add dependencies for tokio, reqwest, serde, toml, axum, tracing, and reqwest-eventsource. Build successfully.
Acceptance: rust_notifier builds without errors.

### P14-05 Create Rust config module
Goal: Load configuration from TOML.
Details: Create rust_notifier/src/config.rs with Config struct for OpenCode URL, optional auth, FCM service account path, and listen host/port. Add a load() helper.
Acceptance: Config loads from TOML and validates required fields.

### P14-06 Create Rust models module
Goal: Define shared request and event types.
Details: Create rust_notifier/src/models.rs with DeviceRegistration, FcmPayload, SseEvent, and HealthResponse types. Derive Serialize and Deserialize.
Acceptance: Models compile and support JSON serialization.

### P14-07 Create device registry
Goal: Store registered device tokens.
Details: Create rust_notifier/src/device_registry.rs with an Arc<RwLock<HashMap>> and file persistence. Implement register, unregister, get_all, load, and save.
Acceptance: Registry persists tokens and supports concurrent access.

### P14-08 Create notifier API
Goal: Expose device registration endpoints.
Details: Create rust_notifier/src/api.rs using axum. Implement POST /devices/register, DELETE /devices/:token, and GET /health. Add logging middleware.
Acceptance: API endpoints return expected status codes and payloads.

### P14-09 Create SSE listener
Goal: Consume OpenCode server events.
Details: Create rust_notifier/src/sse_listener.rs using reqwest-eventsource. Implement reconnect with backoff. Parse event data into SseEvent and filter for notification-worthy events.
Acceptance: Listener connects, parses events, and reconnects on failures.

### P14-10 Create FCM sender
Goal: Send FCM push notifications.
Details: Create rust_notifier/src/fcm_sender.rs. Load service account credentials, obtain OAuth token, and send messages to tokens with notification + data payload. Refresh token on expiry.
Acceptance: FCM sender can deliver notifications to registered tokens.

### P14-11 Wire Rust notifier end to end
Goal: Run API server and SSE listener together.
Details: Update rust_notifier/src/main.rs to load config, initialize registry and sender, start API server, and spawn SSE listener loop that sends notifications.
Acceptance: Rust notifier runs and sends notifications on relevant events.

### P14-12 Add Rust notifier config example and README
Goal: Document configuration and usage.
Details: Create rust_notifier/config.example.toml with comments. Write rust_notifier/README.md with setup, build, run, and API usage.
Acceptance: Documentation is clear and sufficient to run the notifier.

## Phase 15 - Polish and Test Hardening

### P15-01 Add auth interceptor to Dio
Goal: Attach Basic Auth headers to API requests.
Details: Implement AuthInterceptor in dio_client.dart. Read credentials from secure storage, encode to Base64, and set Authorization header. Map 401 and 403 to AuthException.
Acceptance: Requests include Authorization header when credentials are present.

### P15-02 Add auto-reconnect logic
Goal: Recover from connection drops.
Details: In connectionStateProvider, implement reconnect with exponential backoff. Stop after max attempts and surface an error state. Reinitialize SSE stream on success.
Acceptance: App automatically reconnects and updates connection state.

### P15-03 Add pull-to-refresh
Goal: Refresh list data easily.
Details: Add RefreshIndicator to sessions list, file browser, and home screen. On refresh, invalidate the relevant providers.
Acceptance: Pull-to-refresh triggers data reloads without errors.

### P15-04 Add haptic feedback
Goal: Improve tactile interactions.
Details: Add light haptics on send, button taps, and notifications. Add medium and heavy haptics for session creation and connect or disconnect actions. Centralize in a HapticService.
Acceptance: Haptics fire for key actions without blocking UI.

### P15-05 Add consistent loading and error states
Goal: Standardize UI feedback.
Details: Ensure every AsyncValue uses LoadingIndicator and AppErrorWidget for loading and error states. Remove any ad-hoc spinners or error text.
Acceptance: All screens use consistent loading and error components.

### P15-06 Unit test coverage audit for models
Goal: Validate remaining gaps in model serialization tests.
Details: Audit model test coverage and add missing unit tests for Freezed DTOs and serializers, focusing on edge cases not already covered earlier.
Acceptance: Model tests cover edge cases and any uncovered DTOs.

### P15-07 Unit tests for repositories
Goal: Validate repository behavior.
Details: Mock datasources and test network behavior, error mapping, and local storage interactions for saved servers and credentials where applicable.
Acceptance: Repository tests pass and cover success and failure cases.

### P15-08 Unit tests for providers
Goal: Validate provider logic.
Details: Use ProviderContainer to test provider outputs, state transitions, and invalidations on SSE events. Override repositories with mocks.
Acceptance: Provider tests pass and reflect correct state behavior.

### P15-09 Widget tests for building blocks
Goal: Validate reusable widgets.
Details: Test TerminalText, ConnectionBadge, AppButton, AppErrorWidget, LoadingIndicator for correct rendering and interactions.
Acceptance: Widget tests pass for all building blocks.

### P15-10 Widget tests for key screens
Goal: Validate screen UI behavior.
Details: Test ConnectScreen, SessionsListScreen, and ChatScreen with provider overrides for loading, data, and error states.
Acceptance: Screen widget tests pass with expected UI states.

### P15-11 Integration test: connect to chat flow
Goal: Validate end-to-end app flow.
Details: Use integration_test to simulate connect, navigate to home, open session, send message, and receive response. Expand coverage with additional edge cases beyond the initial integration tests.
Acceptance: Integration tests pass and verify core flow with additional coverage.

### P15-12 Integration test: notification deep link
Goal: Validate notification navigation.
Details: Simulate FCM notification payload with sessionId and ensure app navigates to the correct chat screen from cold start and background. Extend tests for edge cases and error handling.
Acceptance: Deep link behavior works for both entry paths and edge cases.
