# Roadmap (Draft)

Feature-first execution: each feature is a vertical slice (models → datasources → repositories → providers → UI → tests) delivered end-to-end. Nothing is built ahead of the feature that consumes it — models are created inside the feature ticket that needs them.

## F0 — Foundation: API Client & App Shell
- Configured Dio client (auth, logging, error mapping).
- GoRouter skeleton + app shell (splash, connect) with redirects.

## F1 — Connect & Dashboard
- Manual + mDNS connection, saved servers with secure credentials.
- Health polling and status display.
- Splash auto-connect; Home dashboard with server status.

## F2 — Sessions
- List, create, delete sessions; statuses (idle/busy/retry).
- Recent sessions on Home.

## F3 — Chat
- Prompt send (sync + async), live SSE updates, parts rendering, tool call cards, typing indicator, model/agent selector.
- SSE event models + config/provider/agent models created here.

## F4 — File Browser
- Directory navigation, file content viewer, search.
- File/search models created here.

## F5 — Settings
- Saved server management, notification toggles.

## F6 — Push Notifications
- Firebase FCM + Rust notifier (SSE listener → FCM sender), token registration, deep links to chat.

## F7 — Polish
- Haptics, pull-to-refresh, consistent loading/error states, Crashlytics, auto-reconnect, test hardening + integration tests.
