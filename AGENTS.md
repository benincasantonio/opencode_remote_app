# AGENTS.md — OpenCode Remote App

## Project Overview

This is a Flutter mobile application (Android + iOS) that serves as a remote client for the OpenCode server. It allows users to manage OpenCode sessions, send prompts, view AI responses, browse project files, and monitor server health from a mobile device.

A companion Rust notification server runs locally alongside the OpenCode server. It subscribes to the OpenCode SSE event stream and dispatches Firebase Cloud Messaging (FCM) push notifications to registered mobile devices.

## Architecture

```
┌─────────────────┐       HTTP/SSE        ┌──────────────────┐
│   Flutter App    │◄────────────────────►│  OpenCode Server  │
│  (Android/iOS)   │                      │  (opencode serve) │
└────────┬────────┘                      └────────┬─────────┘
         │                                        │ SSE
         │ FCM Push                               │
         │                                        ▼
┌────────┴────────┐                      ┌──────────────────┐
│   Firebase FCM   │◄────────────────────│  Rust Notifier    │
│   (Google)       │      FCM Admin SDK  │  (local daemon)   │
└─────────────────┘                      └──────────────────┘
```

## Tech Stack

### Flutter App

| Category | Choice |
|---|---|
| Language | Dart 3.11+ |
| Framework | Flutter 3.x (Material 3) |
| State Management | Riverpod + codegen (riverpod_generator, riverpod_annotation) |
| HTTP Client | Dio |
| Routing | GoRouter |
| Push Notifications | Firebase Cloud Messaging (firebase_messaging) |
| SSE (real-time) | Dio streaming or eventsource_client |
| Code Generation | build_runner, riverpod_generator, freezed, json_serializable |
| Service Discovery | nsd / bonsoir (mDNS/DNS-SD) |
| Local Storage | shared_preferences or hive (for server configs, tokens) |
| Theme | Dark terminal-like aesthetic |

### Rust Notification Server

| Category | Choice |
|---|---|
| Language | Rust |
| HTTP Client | reqwest (SSE via eventsource-client or reqwest-eventsource) |
| FCM | fcm-rust or direct HTTP v1 API via reqwest |
| Config | toml / serde for config file |
| Async Runtime | tokio |

## Project Structure (Flutter)

```
lib/
├── main.dart                     # App entry point, ProviderScope, Firebase init
├── app.dart                      # MaterialApp.router, GoRouter config, theme
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart    # Base URLs, endpoints, timeouts
│   │   └── app_constants.dart    # App-wide constants
│   ├── theme/
│   │   ├── app_theme.dart        # Dark terminal-like theme definition
│   │   ├── app_colors.dart       # Color palette (greens, grays, terminal colors)
│   │   └── app_typography.dart   # Monospace font styles
│   ├── errors/
│   │   ├── app_exception.dart    # Custom exception classes
│   │   └── error_handler.dart    # Global error handling
│   └── utils/
│       ├── logger.dart           # Logging utility
│       └── extensions.dart       # Dart extensions
│
├── data/
│   ├── models/                   # Freezed data classes matching OpenCode API types
│   │   ├── session.dart          # Session, SessionStatus
│   │   ├── message.dart          # Message, Part (text, tool_use, tool_result, etc.)
│   │   ├── project.dart          # Project
│   │   ├── config.dart           # Config, Provider
│   │   ├── file_node.dart        # FileNode, FileContent
│   │   ├── agent.dart            # Agent
│   │   ├── server_health.dart    # Health response
│   │   ├── server_event.dart     # SSE event types
│   │   └── notification_token.dart # FCM token registration
│   │
│   ├── datasources/
│   │   ├── opencode_api.dart     # Dio-based HTTP client for OpenCode server
│   │   ├── sse_client.dart       # SSE event stream client
│   │   └── local_storage.dart    # Persisted server configs, connection history
│   │
│   └── repositories/
│       ├── session_repository.dart
│       ├── message_repository.dart
│       ├── file_repository.dart
│       ├── config_repository.dart
│       ├── server_repository.dart     # Health, connection, discovery
│       └── notification_repository.dart
│
├── domain/
│   └── providers/                # Riverpod providers (generated with @riverpod)
│       ├── session_providers.dart
│       ├── message_providers.dart
│       ├── file_providers.dart
│       ├── config_providers.dart
│       ├── server_providers.dart
│       ├── connection_providers.dart   # Current server connection state
│       ├── event_providers.dart        # SSE stream providers
│       └── notification_providers.dart
│
├── presentation/
│   ├── router/
│   │   └── app_router.dart       # GoRouter route definitions
│   │
│   ├── widgets/                  # Shared/reusable widgets
│   │   ├── terminal_text.dart    # Monospace styled text widget
│   │   ├── code_block.dart       # Syntax-highlighted code block
│   │   ├── loading_indicator.dart
│   │   ├── error_widget.dart
│   │   ├── connection_badge.dart # Shows connected/disconnected status
│   │   └── markdown_renderer.dart # Render markdown from AI responses
│   │
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   │
│   │   ├── connect/
│   │   │   ├── connect_screen.dart       # Server connection (manual + mDNS)
│   │   │   ├── server_list_widget.dart   # List of discovered/saved servers
│   │   │   └── manual_connect_widget.dart
│   │   │
│   │   ├── home/
│   │   │   ├── home_screen.dart          # Dashboard: health, sessions overview
│   │   │   └── server_status_widget.dart
│   │   │
│   │   ├── sessions/
│   │   │   ├── sessions_list_screen.dart
│   │   │   ├── session_detail_screen.dart  # Chat view for a session
│   │   │   ├── session_tile.dart
│   │   │   └── new_session_dialog.dart
│   │   │
│   │   ├── chat/
│   │   │   ├── chat_screen.dart          # Main chat UI for a session
│   │   │   ├── message_bubble.dart       # Renders a single message + parts
│   │   │   ├── part_renderer.dart        # Renders different Part types
│   │   │   ├── tool_call_widget.dart     # Shows tool use/result
│   │   │   ├── chat_input.dart           # Text input + send button
│   │   │   └── typing_indicator.dart     # Shows when AI is processing
│   │   │
│   │   ├── files/
│   │   │   ├── file_browser_screen.dart
│   │   │   ├── file_tree_widget.dart
│   │   │   └── file_content_screen.dart  # View file contents
│   │   │
│   │   └── settings/
│   │       ├── settings_screen.dart
│   │       └── server_config_screen.dart
│   │
│   └── theme/                    # (imported from core/theme)
│
└── services/
    ├── firebase_service.dart     # FCM init, token management, notification handling
    ├── mdns_service.dart         # mDNS discovery for OpenCode servers
    └── dio_client.dart           # Configured Dio instance (interceptors, auth, base URL)
```

## Project Structure (Rust Notification Server)

```
rust_notifier/
├── Cargo.toml
├── src/
│   ├── main.rs                # Entry point, config loading, server startup
│   ├── config.rs              # Configuration (TOML): OpenCode server URL, FCM credentials
│   ├── sse_listener.rs        # Connects to OpenCode /event SSE endpoint, parses events
│   ├── fcm_sender.rs          # Sends FCM push notifications via HTTP v1 API
│   ├── device_registry.rs     # In-memory or file-backed registry of FCM device tokens
│   ├── api.rs                 # Tiny HTTP API: register/unregister device tokens
│   └── models.rs              # Shared data types (events, notifications, tokens)
├── config.example.toml        # Example configuration file
└── README.md
```

## Key Features & Implementation Details

### 1. Server Connection & Discovery

- Manual entry: User enters hostname:port and optional HTTP basic auth credentials
- mDNS discovery: When OpenCode server is started with --mdns, use bonsoir or nsd to discover _opencode._tcp services on LAN
- Connection persistence: Save server configs locally so the user can reconnect quickly
- Health check: Call GET /global/health on connect and periodically

### 2. Authentication

- Support HTTP basic auth (OPENCODE_SERVER_PASSWORD / OPENCODE_SERVER_USERNAME)
- Store credentials securely via flutter_secure_storage
- Add Dio interceptor to attach Authorization: Basic <base64> header

### 3. Session Management

- List all sessions (GET /session)
- Create new session (POST /session)
- Delete session (DELETE /session/:id)
- View session details and status (GET /session/:id, GET /session/status)
- Fork, share, abort sessions

### 4. Chat / Messaging

- List messages in a session (GET /session/:id/message)
- Send a prompt (POST /session/:id/message) — synchronous
- Send async prompt (POST /session/:id/prompt_async) — fire-and-forget, use SSE for updates
- Render different message Part types: text, tool_use, tool_result, thinking, etc.
- Markdown rendering for AI responses
- Syntax highlighting for code blocks
- Model/agent selection per prompt

### 5. Real-Time Events (SSE)

- Subscribe to GET /event for global server events
- Parse event types: session.updated, message.updated, part.updated, etc.
- Use Riverpod StreamProvider to distribute events to the UI
- Show typing indicators and live updates during AI processing

### 6. File Browser

- List directory contents (GET /file?path=<path>)
- Read file content (GET /file/content?path=<path>)
- Search text in files (GET /find?pattern=<pat>)
- Find files by name (GET /find/file?query=<q>)
- Display file content with syntax highlighting

### 7. Push Notifications (Firebase + Rust)

- Flutter app: Initialize FCM, obtain device token, register with Rust notifier API
- Rust notifier: Listen to OpenCode SSE events, on relevant events (session complete, error, permission request) send FCM notification
- Notification payload: Include session ID, event type, summary text
- On tap: Deep-link into the relevant session/chat screen via GoRouter

### 8. Server Health Monitoring

- Periodic health polling (GET /global/health)
- Display server version, connection status
- Visual indicator (green/red badge) in app bar
- Auto-reconnect on connection loss

## UI/UX Design Principles

- Dark terminal-like theme: Dark backgrounds (#1a1a2e, #16213e), green/cyan accent colors, monospace fonts (JetBrains Mono or Fira Code)
- Chat-first design: The chat screen is the primary interaction surface
- Status always visible: Connection status badge in the app bar at all times
- Responsive: Adapt layouts for phone and tablet form factors
- Haptic feedback: Subtle feedback on send, receive, and actions

## API Endpoints Used (OpenCode Server)

| Feature | Method | Endpoint |
|---|---|---|
| Health | GET | /global/health |
| Events | GET | /event or /global/event |
| List Sessions | GET | /session |
| Create Session | POST | /session |
| Get Session | GET | /session/:id |
| Delete Session | DELETE | /session/:id |
| Session Status | GET | /session/status |
| Abort Session | POST | /session/:id/abort |
| Share Session | POST | /session/:id/share |
| List Messages | GET | /session/:id/message |
| Send Message | POST | /session/:id/message |
| Async Prompt | POST | /session/:id/prompt_async |
| List Files | GET | /file?path=<path> |
| Read File | GET | /file/content?path=<path> |
| Search Text | GET | /find?pattern=<pat> |
| Find Files | GET | /find/file?query=<q> |
| Get Config | GET | /config |
| List Providers | GET | /provider |
| List Agents | GET | /agent |
| Set Auth | PUT | /auth/:id |
| Get Project | GET | /project/current |

## Rust Notifier API

| Method | Endpoint | Description |
|---|---|---|
| POST | /devices/register | Register an FCM token + optional label |
| DELETE | /devices/:token | Unregister a device |
| GET | /health | Health check |

## Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  # Networking
  dio: ^5.7.0
  # Routing
  go_router: ^14.8.1
  # Firebase
  firebase_core: ^3.12.1
  firebase_messaging: ^15.2.4
  # Data Classes
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  # mDNS Discovery
  bonsoir: ^5.1.4
  # Local Storage
  shared_preferences: ^2.3.5
  flutter_secure_storage: ^9.2.4
  # UI
  google_fonts: ^6.2.1
  flutter_markdown: ^0.7.7
  flutter_syntax_view: ^4.0.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.14
  riverpod_generator: ^2.6.3
  freezed: ^2.5.8
  json_serializable: ^6.9.4
  custom_lint:
  riverpod_lint:
```

## Coding Conventions

- File naming: snake_case.dart
- Class naming: PascalCase
- Private members: prefix with _
- Models: Use freezed + json_serializable for all API models
- Providers: Use @riverpod annotation for all providers; generate with dart run build_runner build
- Error handling: All Dio calls wrapped in try/catch, map to AppException subtypes
- Null safety: Strict null safety, avoid ! operator
- Imports: Prefer relative imports within lib/, absolute for packages
- Tests: Unit tests for repositories and providers, widget tests for screens

## Build & Run Commands

```bash
# Flutter app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

# Rust notifier
cd rust_notifier
cargo build --release
cargo run -- --config config.toml
```

## Implementation Order

1. Project setup: Dependencies, folder structure, theme, Dio client
2. Core models: Freezed data classes for all OpenCode API types
3. API layer: Dio-based data sources for all endpoints
4. Repositories: Repository pattern wrapping data sources
5. Riverpod providers: Generated providers for all state
6. Connect screen: Server connection (manual + mDNS discovery)
7. Home screen: Dashboard with health status
8. Session management: List, create, delete sessions
9. Chat screen: Message display, prompt input, part rendering
10. SSE integration: Real-time event streaming
11. File browser: Directory listing, file viewing
12. Firebase + Rust notifier: FCM integration and notification server
13. Settings: Server config management, theme options
14. Polish: Error handling, loading states, animations, haptics
