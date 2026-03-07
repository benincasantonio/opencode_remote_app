# Roadmap (Draft)

This file captures a rough execution plan for phases beyond the initial bootstrap and UI building blocks. It is intentionally high-level and may change as the project evolves.

## Phase 3 — Services Layer

- Implement a configured Dio client with auth, logging, and error mapping.
- Add Firebase initialization and token management service.
- Add mDNS discovery service for local OpenCode servers.

## Phase 4 — Data Models

- Define Freezed API DTOs for sessions, messages, parts, files, config, agents, and events.
- Add model unit tests alongside the DTOs.

## Phase 5 — Data Sources

- Build the OpenCode API client covering all endpoints used by the app.
- Implement SSE client for live events with reconnect support.
- Implement local storage layer for credentials and cached data.

## Phase 6 — Repositories

- Implement repository layer to orchestrate API + cache.
- Define network-first + write-through cache behavior.
- Ensure repositories expose clean model objects for Riverpod.

## Phase 7 — Riverpod Providers

- Build providers for repositories and data flows.
- Wire SSE events to invalidate and refresh relevant providers.
- Implement connection state provider with reconnect logic.

## Phase 8 — Routing & App Shell

- Create GoRouter routes for splash, connect, home, sessions, chat, files, settings.
- Add redirect logic based on connection state.
- Initialize Firebase at app startup.

## Phase 9–13 — Screens

- Connect + Home screens (server discovery, status dashboard).
- Sessions + Chat screens (message list, prompt input, parts rendering).
- File browser screens (tree view, file content viewer).
- Settings screens (server configs, notifications, about).

## Phase 14 — Firebase + Rust Notifier

- Add Firebase configuration to mobile platforms.
- Implement device token registration with Rust notifier.
- Build Rust notifier service: API, SSE listener, FCM sender.

## Phase 15 — Polish & Testing

- Add loading/error states, haptics, and subtle animations.
- Unit tests for repositories, mappers, and providers.
- Widget tests for building blocks and screens.
- Integration tests for connect → chat and notification deep links.
