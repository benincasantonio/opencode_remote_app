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

---

## E1 - Lint baseline & l10n foundation

Source: engineering audit (Aug 2026). Goal: enforce mechanical rules statically at the analyzer level; wire the l10n foundation that E2's raw-string rule depends on. Dependency chain: E1 → E2 → E3 → E4.

Details:
1. `analysis_options.yaml`: escalate `deprecated_member_use` to `error`; enable built-ins `prefer_relative_imports`, `avoid_print`, `prefer_single_quotes`, `use_decorated_box`; wire the `custom_lint` + `riverpod_lint` analyzer plugins (already dev deps, currently unused).
2. Add `leancode_lint` dev dep; enable only Riverpod-compatible rules: `avoid_context_read_in_build`, `use_dedicated_media_query_methods`, `avoid_single_child_in_multi_child_widgets`, `catch_parameter_names`, `start_comments_with_space`, `prefer_abstract_final_class`. Skip Bloc-only rules.
3. l10n foundation: `flutter_localizations` + `intl`, `l10n.yaml`, gen-l10n, `AppLocalizations` delegate wired in the app; seed `arb` files with existing hardcoded UI strings; `context.l10n` extension.
4. Fix violations surfaced by the new ruleset (deprecated APIs, mixed imports, formatting).

Acceptance checklist:
- [ ] `flutter analyze --fatal-infos --fatal-warnings` passes with 0 issues under the new ruleset
- [ ] Any deprecated Flutter API usage fails analysis as an error
- [ ] All imports inside `lib/` are relative (no `package:` imports)
- [ ] `AppLocalizations` wired in the app; existing hardcoded strings moved to `arb`
- [ ] leancode_lint rules active in IDE and CLI

Testing: analyzer clean; regression test — a fixture file using `WillPopScope` fails analysis.

## E2 - Custom lint rules

Goal: enforce conventions built-in lints cannot check. Depends on E1 (l10n must exist before the raw-string rule can be enforced).

Details:
1. Create a lint package (e.g. `packages/opencode_lints`, using `custom_lint_builder`) with:
   - `file_size_signal`: **warning** (not error) when a `lib/` file exceeds 400 lines; suppressible via `// ignore: file_size_signal <reason>` — signal-not-law, the reason is mandatory.
   - `avoid_raw_string_in_widgets`: flags string literals in `Text()`/button constructors (i18n).
   - `avoid_widget_returning_methods`: flags methods returning `Widget`.
   - `models_are_dtos`: flags `ChangeNotifier`/mutable non-final fields in `lib/data/models/`.
2. Tests for every rule using the `// expect_lint` convention (happy + edge cases).
3. Wire the plugin in `analysis_options.yaml` for both app and widgetbook.

Acceptance checklist:
- [ ] `dart run custom_lint` exits 0 on the current codebase with no unexpected hits
- [ ] Every rule has `// expect_lint` tests covering positive and negative cases
- [ ] `file_size_signal` surfaces as a warning (never an error) and `// ignore` requires a reason
- [ ] Rules surface in the IDE and in CI
- [ ] A fixture model with `ChangeNotifier` is flagged by `models_are_dtos`

## E3 - CI PR gate & make check

Goal: every PR must pass the full static + test gate; `make check` mirrors it locally. Depends on E2.

Details:
1. `.github/workflows/ci.yml` (first workflow in the repo) on `pull_request`:
   - `make generate` **first** (regenerates `.g.dart`/`.freezed.dart`/l10n/widgetbook from committed sources; staleness self-corrects — missing generated files fail analysis; amended per E9)
   - `flutter analyze --fatal-infos --fatal-warnings`
   - `dart format --set-exit-if-changed .`
   - `dart run custom_lint`
   - `flutter test`
   - `make check-widgetbook-registration`: `tool/check_widgetbook_registration.dart` verifies every `widgetbook/lib/*_use_case.dart` is registered in `main.directories.g.dart` (replaces the `git diff --exit-code` freshness check — generated files are no longer committed per E9)
   - `tool/check_file_sizes.dart`: lists files > 400 lines (non-blocking, printed for review)
2. `Makefile`: add `make check` target chaining all of the above locally.
3. Optional: `lefthook` pre-commit hook.

Acceptance checklist:
- [ ] CI runs on every PR and fails on: any analyze issue, formatting drift, custom_lint hit, failing test, stale widgetbook registration
- [ ] `make check` exits 0 on a green tree and non-zero on each violation type (validated with deliberately red commits)
- [ ] Fresh clone: `make install && make check` passes without manual steps (codegen reproducible)
- [ ] Stale widgetbook registration is caught by `make check-widgetbook-registration`
- [ ] Files > 400 lines are listed in CI logs (non-blocking)

## E4 - AGENTS.md simplification & judgment rules

Goal: reduce AGENTS.md to judgment-based rules; mechanical rules live in CI/`make check`. Depends on E3.

Details:
1. Keep as prose: form-factor/conditional-imports policy, async-teardown discipline (`_disposed` guards), rationale comments with issue references, seam judgment ("when in doubt keep together").
2. Remove mechanical-rule prose that E1/E2/E3 now enforce (deprecated API, imports, sizing, one-widget-per-file).
3. Add i18n discipline note: all user-facing strings via `context.l10n`.
4. Add pointer: "Hard rules are enforced by `make check` / CI — see E1/E2/E3."

Acceptance checklist:
- [ ] No mechanical rule in AGENTS.md duplicates a check enforced by E1/E2/E3
- [ ] AGENTS.md retains form-factor policy, teardown discipline, rationale-comment convention, seam judgment
- [ ] A fresh agent can run `make check` successfully using only AGENTS.md's documented commands

---

## E5 - App bootstrap hardening

Source: architecture audit (Aug 2026). Mature Flutter apps have a real composition root; ours is minimal. **Scope note: Firebase-independent parts land now. Firebase init + FCM wiring stays in F6** (guarded-init pattern is shared, so the seam is designed here).

Details:
1. `main.dart`: register `FlutterError.onError` and `PlatformDispatcher.onError` → logger + `ErrorHandler`; avoid double-reporting (guarded by `ErrorHandler.isFromFlutterError`).
2. `BootstrapErrorWidget`: if any init step fails (storage, Firebase guarded init, etc.), render a terminal-style error screen with retry instead of crashing.
3. Logger init as the first bootstrap step; error handler writes breadcrumbs into the logger (consumed by E10's log buffer).
4. Define the `AppBootstrap` structure (ordered init steps, per-step try/catch) so F6 can slot Firebase init in without restructuring.
5. `WidgetsFlutterBinding.ensureInitialized()` + `SystemChrome`/edge-to-edge config, consistent with the audit's findings.

Acceptance checklist:
- [ ] Unhandled Dart errors and platform errors are logged and surfaced once
- [ ] A failing init step shows BootstrapErrorWidget (retry works), never a silent crash
- [ ] F6 can add Firebase init by registering one step — no bootstrap restructuring needed

Testing: widget tests for BootstrapErrorWidget (retry callback, error message rendering); unit test for the error-hook dedup guard.

## E6 - Sealed result types (FlowyResult pattern)

Source: architecture audit (Aug 2026). Sealed result types (explicit success/failure) across repositories are stronger than bare try/catch. We keep `AppException` + `AsyncValue` at the provider boundary, but make repository calls explicit.

Details:
1. Add sealed result in `core/errors/` (e.g. `result.dart`): `sealed class Result<T>` + `ResultSuccess<T>` / `ResultFailure<T>` carrying `AppException`; helpers `fold`, `mapError`, `unwrapOrThrow`.
2. Repository methods return `Future<Result<T>>` instead of throwing; datasources still throw → repository catches and converts (single conversion point).
3. Providers translate `ResultFailure` → `AsyncError` so UI keeps `AsyncValue` (no UI changes required).
4. Apply to F0's `DioClient` error mapping and F1+ repositories as they land (do not retrofit the P4-01 models tests).

Acceptance checklist:
- [ ] `Result<T>` lives in core/errors with tests for fold/mapError/unwrap
- [ ] At least one repository (F1's ServerRepository) demonstrates the pattern
- [ ] UI layer sees zero changes: providers still expose `AsyncValue<T>`

Testing: unit tests for the Result type (success/failure/fold/mapError) and a repository test proving error conversion.

## E7 - Feature organization restructure

Source: architecture audit (Aug 2026). Large Flutter codebases scale via feature modules (feature-first, or layer-first with feature subfolders); our layer-first layout with empty placeholder dirs (`data/datasources/`, `data/repositories/`, `domain/providers/`, `presentation/router/`) does not.

Details:
1. Decide and document the target layout in AGENTS.md + roadmap. Recommended: feature-first — `lib/features/<feature>/` (models, data, providers, screens) with `lib/core/` (shared), `lib/services/` (cross-cutting: dio, mDNS, firebase) kept at root.
2. Move existing code: chat, connect, files, sessions, settings, home screens → `features/`; shared widgets stay in `lib/presentation/widgets/` (or `lib/features/shared/` — decide in the ticket).
3. Delete all empty `.gitkeep` placeholder layer dirs; new layers are created on demand by feature tickets (matches the vertical-slice policy in tickets.md).
4. Update AGENTS.md project structure section, roadmap, and this ticket map.

Acceptance checklist:
- [ ] Every feature's vertical slice (models → data → providers → UI) lives under one feature folder
- [ ] No empty layer directories remain in `lib/`
- [ ] AGENTS.md structure section matches the real tree (audit: `find lib -type f | wc -l` doc check)

Testing: `flutter analyze` + `flutter test` green after the move; no behavior change.

## E8 - App lifecycle, connectivity monitoring & background refresh

Source: architecture audit (Aug 2026). Established practice is to drive app state from `AppLifecycleState` and schedule background work when needed; we have neither. For a remote client this matters twice: SSE must re-init on resume and health polling must pause when offline.

Details:
1. `AppLifecycleListener` (or `WidgetsBindingObserver`) → `LifecycleProvider` (StateNotifier: resumed/inactive/paused/detached).
2. Add `connectivity_plus` dependency; `ConnectivityProvider` (StreamProvider) reflecting online/offline; health polling pauses when offline, resumes on reconnect.
3. Reconnect orchestration: on resume or connectivity-restore → re-establish server connection if dropped + re-init SSE (F3) + trigger a health check. Coordinate with F7's auto-reconnect (exponential backoff lives in the connection state, not in the listeners).
4. Background refresh scope decision (v1 = refresh-on-resume only; periodic background sync via WorkManager deferred — note it in F7 so it is not silently forgotten).
5. Log lifecycle transitions (feeds E10).

Acceptance checklist:
- [ ] App-state changes are observable via a provider and logged
- [ ] Going offline pauses polling; coming back online triggers reconnect + health check without user action
- [ ] Resuming from background re-inits a dead SSE stream (verified with chat screen open)
- [ ] WorkManager periodic refresh is explicitly documented as deferred in F7

Testing: provider unit tests (fake lifecycle/connectivity); integration-style widget test simulating resume → SSE re-init; connectivity stream mocked.

## E9 - Codegen hygiene (gitignore generated files) — implement ASAP

Source: architecture audit (Aug 2026). Industry convention is to gitignore `*.g.dart`/`*.freezed.dart` and regenerate via scripts; we commit them (`message.freezed.dart`, etc.). **Land before E3** (E3's freshness check assumes committed generated files and must be amended).

Details:
1. `.gitignore`: add `**/*.g.dart`, `**/*.freezed.dart`, `widgetbook/lib/**/*.g.dart`, generated l10n files (`lib/l10n/app_localizations*.dart`, `*.g.dart` once E1's gen-l10n lands), `lib/generated/` (reserved for E11).
2. `git rm --cached` the currently tracked generated files.
3. Makefile: extend `make generate` to run build_runner + `widgetbook-generate` + `flutter gen-l10n` in one step (keep `generate-clean`).
4. Amend E3: CI runs `make generate` **before** analyze/test (staleness self-corrects: missing generated files fail analysis). Replace the `git diff --exit-code` freshness check with a small script that verifies every `widgetbook/lib/*_use_case.dart` is registered in `main.directories.g.dart` (the widgetbook registration problem E3 wanted to catch).
5. AGENTS.md: document "generated files are never committed; run `make generate` before analyze/test".

Acceptance checklist:
- [ ] No generated files tracked in git; `git status` clean after `make generate`
- [ ] Fresh clone → `make install && make generate && make analyze && make test` passes
- [ ] E3 is amended (freshness check + widgetbook registration script)
- [ ] `make generate-clean` leaves the tree buildable (generated files excluded from the repo by .gitignore, not by deletion)

Testing: CI/freshness script unit-tested on a deliberately stale widgetbook registration.

## E10 - Observability: crash breadcrumbs + persisted logs + debug export

Source: architecture audit (Aug 2026). Persisting logs makes crash reports actionable and gives on-device log access. F7 already plans Crashlytics (P3-04); this ticket makes crash reports useful and gives on-device log access. Crashlytics vs Sentry: decide at F7 — the seams here work for either.

Details:
1. Logger (core/utils/logger.dart): add an in-memory ring buffer (last ~500 entries with level/timestamp) + optional file-backed persistence (append-only file via `path_provider`).
2. Crash breadcrumbs: F7's Crashlytics integration attaches the ring buffer (last N lines) to every crash report as custom keys.
3. Debug screen: Settings → Developer → view + share/export logs (reuse `discovery_debug_screen.dart` pattern; `share_plus` for export).
4. Log lifecycle + connectivity transitions from E8 land here too (single entry point).

Acceptance checklist:
- [ ] Logger exposes a ring buffer; buffer contents survive in-memory across navigation
- [ ] Debug screen shows recent logs with level filtering and a working export/share
- [ ] Crash reports (F7) include the last 50 log lines as breadcrumbs

Testing: unit tests for the ring buffer (cap, ordering, levels); widget test for the debug log screen (list, filter, export button).

## E11 - OpenAPI-driven Dart client generation

Source: architecture audit + verified — `opencode serve` publishes an **OpenAPI 3.1 spec at `GET /doc`**, and the docs state it is used to generate SDKs (the opencode repo's `packages/sdk/js/src/gen/types.gen.ts` is generated from it). This is the strongest anti-drift move available: our hand-written endpoints table is already missing routes (e.g. `/session/:id/fork`, `/session/:id/revert`, `/session/:id/todo`, `/find/symbol`, `/command`, `/mcp`).

Details:
1. Snapshot the spec: run a local `opencode serve`, fetch the spec JSON, commit it as `tool/openapi/opencode-spec.json` (pinned, versioned; refresh is a manual task when the server API changes). Add `make spec-refresh` documenting the commands.
2. Tooling decision: evaluate `swagger_dart_code_generator` (emits **Dio** clients — matches our stack) vs `openapi-generator-cli` dart generator (requires patched templates). Recommend the former; spike both if time allows.
3. Generate into `lib/generated/openapi/` (gitignored per E9; wired into `make generate`).
4. Boundary decision: the **generated client IS the datasource layer** (answers the "do we need datasources?" question from the audit — no hand-written datasource classes). Repositories wrap it and translate to the hand-written freezed DTOs where needed. Union-heavy DTOs (`MessagePart`, `Message`, SSE `ServerEvent` envelopes) stay hand-written since freezed handles unions better than generated code.
5. Amend F0: `DioClient` becomes the transport/authenticator for the generated client instead of the hand-rolled API surface; F1+ repositories consume the generated client.

Acceptance checklist:
- [ ] `tool/openapi/opencode-spec.json` committed; `make spec-refresh` documented
- [ ] Generated client compiles, analyzer-clean, gitignored, produced by `make generate`
- [ ] At least one feature (F1 health or F2 sessions) consumes the generated client instead of hand-written endpoints
- [ ] Union-heavy models (Message/Part/ServerEvent) remain freezed, not generated

Testing: unit tests on generated client usage through a repository (mocked transport); spec snapshot freshness documented (no CI gate required for v1).

## E12 - E2E: integration_test (in-process behavior tests)

Source: architecture audit (Aug 2026) + code-level study of established Flutter E2E setups. `integration_test` runs the **real app widget tree in-process** with Riverpod `ProviderScope` overrides — deterministic feature-level E2E: connect → create session → send prompt → SSE-driven reply. Companion to E13 (Maestro, black-box OS-level smoke); E12 is the PR gate, E13 is real-device/nightly.

Details:
1. **Dependency**: add `integration_test` (SDK, dev dependency in `pubspec.yaml`). No new state/DI packages — tests reuse existing Riverpod override machinery. Firebase must not initialize in tests: route through the F6 guarded-init seam so tests run without `google-services.json`.
2. **Folder layout** (`integration_test/` at repo root, mirroring `test/` conventions):
   - `runner.dart` — **single entrypoint** that calls every shard's `main()` (required by [flutter/flutter#101031](https://github.com/flutter/flutter/issues/101031): one integration-test target per app process; multiple `main()` files break `flutter test integration_test`).
   - `shard_connect_runner.dart`, `shard_chat_runner.dart` — balanced groups (each feature folder gets a `*_runner.dart` that imports its `_test.dart` files with namespace aliases and calls their `main()`). Add explicit `// DON'T add more tests here — keep shards balanced.` guards.
   - `features/connect/connect_test.dart`, `features/chat/chat_test.dart` — test files registering `testWidgets` groups.
   - `test_utils/` — harness + fake server + page objects (below).
3. **Fake OpenCode server** (`test_utils/fake_opencode_server.dart`) — the core pattern: the app under test must never know it is not talking to a real server.
   - Localhost `HttpServer` (`HttpServer.bind(InternetAddress.loopbackIPv4, 0)` — random free port), implementing **only** the endpoints a scenario touches, returning the exact JSON shapes our freezed models parse (reuse `test/unit/data/models/fixtures/*.json` bodies where possible):
     - `GET /global/health` → `{healthy, version}`
     - `GET /session` / `POST /session` / `DELETE /session/:id`
     - `GET /session/:id/message` / `POST /session/:id/message` (synchronous reply)
     - `GET /global/event` → SSE stream the **test controls**: `pushEvent(Map json)` writes an SSE frame; `sendTypingEvent()`, `sendPartDelta(text)` helpers
   - Records requests (`receivedRequests` list) so tests can assert what the app actually sent (e.g. POST body contains the prompt).
   - Test-side hooks: `Completer`-based sync points (e.g. resolves when the app opens the SSE stream) instead of sleeps.
   - The fake server gets its own **unit tests** (route → JSON/SSE-frame behavior) so a scenario failure is an app bug, never a harness bug.
4. **Harness** (`test_utils/test_helper.dart`):
   - `TestHelper.initialize()`: `IntegrationTestWidgetsFlutterBinding.ensureInitialized()` + `framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive` (real async animations/SSE/timers play out; default `LiveTestWidgetsFlutterBindingFramePolicy.fadePointers` would throttle frames).
   - `loadApp(tester)`: boot the actual app — `ProviderScope(overrides: [...]` with: in-memory shared_preferences (`SharedPreferences.setMockInitialValues({})`), the fake server URL injected into the connection state, Firebase/notifications provider overridden to no-ops — then `pumpWidget(const App())`. One override list shared across tests (a `buildOverrides()` helper), overridable per test.
   - `appWidgetTest(name, fn)` wrapper: `testWidgets(name, (tester) async { await TestHelper.loadApp(tester); await fn(tester, TestHelper(tester)); }, semanticsEnabled: false)` — `semanticsEnabled: false` speeds up runs.
   - `pumpUntilFound(tester, finder, {Duration timeout = 120s})`: poll `tester.pump()` until the finder matches or the timer throws. **Never** hard-coded `pump(Duration)` sleeps — resilient to CI load.
5. **Page objects** (`test_utils/connect_helper.dart`, `test_utils/chat_helper.dart`) — one method per user action/assertion, so tests read like scenarios:
   - `ConnectHelper`: `enterServerUrl(String)`, `tapConnect()`, `waitForConnected()` (asserts `ConnectionBadge` in connected state), `assertConnectionFailed()`.
   - `ChatHelper`: `createSession(String title)`, `sendPrompt(String text)`, `assertUserBubble(text)`, `waitForTypingIndicator()` / `waitForTypingIndicatorGone()`, `assertAssistantTextContains(...)` (SSE-driven), `waitForSessionBusy()` / `waitForSessionIdle()`.
   - Selector rules: stable `Key`s first (see step 6), else `find.byType` scoped to the screen, else **localized strings via `context.l10n` / the generated `AppLocalizations`** — never raw English literals (tests stay green when UI strings change). Follow the existing `pump_with_l10n.dart` test helper pattern.
6. **Test IDs (testability seam)**: add `Key`s to critical interactive elements in this ticket: connect button, server URL input, session-create button, chat input, send button, connection badge. No behavior changes; Maestro `id:` selectors in E13 map to the same keys.
7. **Scenarios (v1)**:
   - `features/connect/connect_test.dart`: connect to fake server → badge green; wrong port → failure state with retry; reconnect after fake server restart (kill `HttpServer`, start new one on same port).
   - `features/chat/chat_test.dart`: create session → send prompt → user bubble appears → typing indicator shows → fake server pushes `message.part.delta` events → assistant text renders and indicator disappears → `POST /session/:id/message` body asserted on the fake server; abort action stops a busy session.
8. **Makefile + docs**: `make test-e2e` → `flutter test integration_test` (document: requires a connected device/emulator; `-d <device>` supported). AGENTS.md gets a short E2E section (device prerequisites, how to run, where the fake server lives).
9. **CI** (fold into E3 when it lands): integration_test runs on the android-emulator-runner job — **this is the PR gate** for e2e. Maestro (E13) is explicitly NOT a PR gate.

Acceptance checklist:
- [ ] `make test-e2e` green on a local emulator: connect → create session → send prompt → assistant reply rendered (all driven by the fake server, zero real-server dependency)
- [ ] SSE path covered: typing indicator appears/disappears and a streamed part updates the UI mid-test via `pushEvent`
- [ ] Fake server records and asserts the app's HTTP requests; fake server itself has unit tests
- [ ] Single `runner.dart` entrypoint; shards balanced with `// DON'T add more tests here` guards
- [ ] Test keys on all elements in step 6; analyzer + existing `test/` suite pass
- [ ] No raw English literals in integration_test finders (l10n used)
- [ ] No hard-coded `pump(Duration)` sleeps anywhere in `integration_test/` (only `pumpUntilFound`)

Testing: this ticket IS the behavior e2e layer; the fake server and page objects get unit tests in the same PRs.

## E13 - E2E: Maestro (black-box device smoke)

Source: architecture audit (Aug 2026) + ente's mobile-tests pattern (YAML flows, `subflows/`, env-var secrets). Maestro drives the real installed app on a real device/emulator — covers what in-process tests cannot: app install/launch, permissions, keyboard, push notification tap, deep links. E13 is a **nightly/optional** layer, never a PR gate (E12 is the gate).

Details:
1. **Tooling**: Maestro CLI (not a repo dependency) — `brew install maestro` (mobile) or `curl -Ls https://get.maestro.mobile.dev | bash`; document `maestro --version` check in AGENTS.md. Flows live in `e2e/maestro/`; no Dart involved.
2. **Folder layout** (`e2e/maestro/`):
   - `setup.yaml` — the "login" step every flow needs: `appId: <applicationId/bundle id>` + `launchApp: clearState: true` (deterministic start — wipes saved servers/credentials), then connect to the real server via `${SERVER_URL}` (manual connect screen).
   - `flows/` — one YAML per scenario (`sessions_smoke.yaml`, `chat_smoke.yaml`, `notification_deep_link.yaml` — the latter once F6 lands).
   - `subflows/` — reusable steps parameterized with `env:`: `subflows/create_session.yaml` (`env: SESSION_TITLE`), `subflows/send_prompt.yaml` (`env: PROMPT_TEXT`), `subflows/delete_session.yaml`.
   - `README.md` — how to run locally, env vars, device requirements.
3. **Flow conventions** (ente pattern):
   - Header: `appId: <bundle id>` then `---` then steps. Bundle id from Android `applicationId` (and iOS `PRODUCT_BUNDLE_IDENTIFIER`) — keep the two in sync (documented in AGENTS.md).
   - **State**: `launchApp: clearState: true` at flow start; never assume prior state.
   - **Secrets/env**: server URL and any credentials via `${SERVER_URL}`/`${...}` passed with `maestro test --env SERVER_URL=...`; never committed. Test user/device only.
   - **Async UI**: `extendedWaitUntil: {visible: X, timeout: 10000}` and `extendedWaitUntil: {notVisible: X, timeout: 10000}` instead of fixed sleeps; `assertVisible`/`assertNotVisible` for assertions; `waitForAnimationToEnd` after navigation.
   - **Selectors**: `id: <test key>` matching the E12 test keys (single source of truth — the widget `Key`s), falling back to visible text (`tapOn: "Send"`) only where no key exists. Avoid coordinates entirely.
   - **Reuse**: every multi-step action lives in `subflows/` and is composed via `runFlow: {file: ../subflows/x.yaml, env: {...}}`.
4. **Scenarios (v1)**:
   - `flows/connect_smoke.yaml`: launch (cleared state) → connect to `${SERVER_URL}` → `extendedWaitUntil` connected badge → assert visible.
   - `flows/chat_smoke.yaml`: `runFlow` setup + create_session + send_prompt → wait for assistant reply (real server, real model) → assert reply text visible.
   - `flows/notification_deep_link.yaml` (after F6): send notification (via Rust notifier or manual FCM), tap it → app opens on the right session chat.
5. **Makefile + docs**: `make test-maestro` → `maestro test e2e/maestro/setup.yaml e2e/maestro/flows` with `--env` documented (`--env SERVER_URL=...`); `make test-maestro-smoke` for the connect-only flow. Document simulator/device prerequisites in AGENTS.md.
6. **CI** (fold into E3 when it lands): Maestro optional — nightly schedule or Maestro Cloud; runs against a test server instance; **not** on the PR path (real-device runs are slow and flaky-prone by nature). E12 remains the PR gate.

Acceptance checklist:
- [ ] `make test-maestro` runs setup + connect + chat smoke flows green against a real server on a simulator/device
- [ ] `subflows/` used for setup/create-session/send-prompt; no duplicated steps across flows
- [ ] No secrets or server URLs in committed flows (all `${ENV_VARS}`)
- [ ] No fixed sleeps: `extendedWaitUntil`/`assertVisible` only
- [ ] `id:` selectors map 1:1 to the E12 test keys
- [ ] README documents install, env vars, device prerequisites

Testing: flows are executed against the real app; each new flow must be run once against a clean install before merging (smoke + one full scenario).

## E14 - CI performance optimizations (#68)

Goal: speed up the PR gate without weakening it. Depends on the existing CI workflow (E3).

Details:
1. `make install-ci` / `make generate-ci` — app + `opencode_lints` (+ example) only; skip Widgetbook on the hot path.
2. Pin Flutter via `.flutter-version` (workflow reads it into `flutter-version:`).
3. **One** Flutter setup for the main gate (`make check-ci`: analyze → custom_lint → test). Avoid parallel jobs that each re-run `flutter-action` + `pub get`.
4. Flutter SDK + pub cache via `flutter-action`; `.dart_tool/build` cached separately for build_runner.
5. Path filters: docs-only PRs skip heavy jobs; Widgetbook codegen runs only when `widgetbook/**` (or related) changes.
6. Aggregating `CI gate` job so branch protection can require one check.

Acceptance checklist:
- [ ] `make install-ci` / `make generate-ci` skip Widgetbook
- [ ] CI pins Flutter from `.flutter-version`
- [ ] Main gate uses a single Flutter install (`make check-ci`)
- [ ] Docs-only changes skip heavy jobs; Widgetbook job is path-filtered
- [ ] Gate still fails on analyze / custom_lint / test failures
