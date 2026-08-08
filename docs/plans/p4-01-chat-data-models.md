# P4-01 — Create Chat Data Models (Issue #47)

Freezed models for sessions, messages, and parts, validated against the current OpenCode server API (`anomalyco/opencode`, `dev` branch, Aug 2026).

## Dependencies

- None — freezed, json_serializable, and build_runner are already in pubspec.
- P4-02/P4-03 may run in parallel; P4-04 depends on the `Session`/`Message` types exported here.

---

## Step 1 — Create Branch & Checkout

```bash
git checkout main
gh issue develop 47 --checkout --name feature/p4-01-chat-data-models
```

---

## Step 2 — Implement

### 2.1 Capture fixtures (best-effort live)

Start a local server in a scratch dir and capture real JSON:

```bash
cd /tmp/opencode-fixtures && opencode serve --port 4096 &
curl -s localhost:4096/global/health
curl -s localhost:4096/session
curl -s -X POST localhost:4096/session -d '{"title":"fixture"}' -H 'content-type: application/json'
curl -s localhost:4096/session/status
curl -s "localhost:4096/session/<id>/message"
```

Save responses to `test/unit/data/models/fixtures/`. If no provider is authed (message/part generation unavailable), hand-craft message/part fixtures from the validated schemas below. Fixtures must stay stable and readable — this is our contract with the server.

### 2.2 Create `Session` models

#### [NEW] `lib/data/models/session.dart`

Conventions: `@Freezed(sealed: true)` + `json_serializable`. Sealed unions get a manual `fromJson` factory that dispatches on the wire discriminator (freezed's default runtimeType dispatch does not match the JSON).

**Classes:**

1. `Session` (Freezed) — id, slug, projectID, workspaceID?, directory, path?, parentID?, summary?, cost? (`double`), tokens?, share?, title, agent?, model?, version, metadata? (`Map<String,dynamic>`), permission? (`List<dynamic>?`, opaque for now), revert?, time.
2. `SessionTime` — created, updated, compacting?, archived? (epoch millis `int`).
3. `Tokens` — input, output, reasoning, cache (`CacheTokens{read, write}`). Reused by `AssistantMessage` and `StepFinishPart`.
4. `SessionSummary` — additions, deletions, files, diffs? (`List<dynamic>?`).
5. `SessionShare` — url.
6. `SessionRevert` — messageID, partID?, snapshot?, diff?.
7. `ModelRef` — id, providerID, variant?. Reused by `UserMessage`.
8. `SessionStatus` (sealed union, discriminator `type`) — `idle` | `busy` | `retry(attempt, message, action?, next)`; `action` is `RetryAction{reason, provider, title, message, label, link?}`.
9. `CreateSessionInput` — parentID?, title?, agent?, model?, metadata?, permission? (POST /session body).

**fromJson dispatch:**

```dart
@Freezed(sealed: true)
sealed class SessionStatus with _$SessionStatus {
  const factory SessionStatus.idle() = SessionStatusIdle;
  const factory SessionStatus.busy() = SessionStatusBusy;
  const factory SessionStatus.retry({required int attempt, required String message, RetryAction? action, required int next}) = SessionStatusRetry;

  factory SessionStatus.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'idle': return SessionStatusIdle.fromJson(json);
      case 'busy': return SessionStatusBusy.fromJson(json);
      case 'retry': return SessionStatusRetry.fromJson(json);
      default: throw FormatException('Unknown session status: ${json['type']}');
    }
  }
}
```

### 2.3 Create `Part` models

#### [NEW] `lib/data/models/part.dart`

`MessagePart` (sealed union, discriminator `type`, `fallbackUnion: 'other'`) — the chat UI renders these variants; everything else falls back to `OtherPart`:

| Variant class | JSON type | Extra fields |
|---|---|---|
| `TextPart` | `text` | text, synthetic?, ignored?, time? {start, end?}, metadata? |
| `ReasoningPart` | `reasoning` | text, metadata?, time {start, end?} |
| `ToolPart` | `tool` | callID, tool, state, metadata? |
| `StepStartPart` | `step-start` | snapshot? |
| `StepFinishPart` | `step-finish` | reason, snapshot?, cost, tokens |
| `OtherPart` | *any other* | id, sessionID, messageID, type — absorbs file/snapshot/patch/agent/retry/compaction/subtask and future types without crashing (freezed `fallbackUnion`) |

Additional unions in this file:
- `ToolState` (discriminator `status`) — `pending{input,raw}` | `running{input,title?,metadata?,time}` | `completed{input,output,title,metadata,time}` | `error{input,error,metadata?,time}`.

Unknown `type` values map to `OtherPart` (no exceptions on forward-compatible payloads).

### 2.4 Create `Message` models

#### [NEW] `lib/data/models/message.dart`

- `Message` (sealed union, discriminator `role`):
  - `UserMessage` — id, sessionID, time {created}, agent, model (`ModelRef`), format?, summary?, system?, tools? (`Map<String,bool>`?).
  - `AssistantMessage` — id, sessionID, time {created, completed?}, parentID, modelID, providerID, mode, agent, path {cwd, root}, cost, tokens, error?, finish?, variant?, structured?.
- `MessageWithParts` — {info: Message, parts: List\<MessagePart\>} (wire shape of /session/:id/message).
- `MessageError` (pragmatic) — `{name, data: Map<String,dynamic>, message getter}` for assistant `error` (wire is `{name, data}` named-error union).
- `OutputFormat` (small sealed union, `type` discriminator) — `text` | `jsonSchema{schema, retryCount}` for user `format`.

### 2.5 Barrel export

#### [NEW] `lib/data/models/models.dart`

```dart
export 'session.dart';
export 'part.dart';
export 'message.dart';
```

Matches the existing barrel convention (`core/errors/errors.dart`, `services/services.dart`).

---

## Step 3 — Unit tests

#### [NEW] `test/unit/data/models/session_test.dart`
1. Session parses full JSON (all fields, nested time/tokens/revert/share).
2. Session parses minimal JSON (optionals absent).
3. Session toJson round-trips (fromJson(toJson) == original).
4. SessionStatus discrimination: idle, busy, retry (with action).
5. RetryAction parses with and without link.
6. CreateSessionInput serializes to the POST body shape.

#### [NEW] `test/unit/data/models/part_test.dart`
1. Typed variants parse: text, reasoning, tool (completed state), step-start, step-finish.
2. ToolState discrimination: pending, running, completed, error.
3. Unknown part type falls back to OtherPart (id/sessionID/messageID/type preserved).
4. Every typed variant round-trips through toJson.

#### [NEW] `test/unit/data/models/message_test.dart`
1. Message role discrimination: user and assistant.
2. UserMessage model ref + time parsing.
3. AssistantMessage error (MessageError) + tokens + path parsing.
4. MessageWithParts wrapper parses list payload.
5. OutputFormat discrimination: text and json_schema.
6. Unknown role throws FormatException.

Fixtures live in `test/unit/data/models/fixtures/` and are loaded via `File(...).readAsString()`.

---

## Step 4 — Codegen & Verify

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze lib/data/models
flutter test test/unit/data/models/
```

---

## Step 5 — Commit

```bash
git add lib/data/models test/unit/data/models
git commit -m "feat(models): create chat data models (Session, Message, Part)

- Session, SessionStatus (idle|busy|retry), CreateSessionInput + nested types
- MessagePart union with 12 variants, ToolState, FilePartSource, ApiError
- Message union (User|Assistant), MessageWithParts, MessageError, OutputFormat
- models.dart barrel export
- Sealed Freezed unions with manual discriminator fromJson
- Unit tests + fixtures for serialization and discrimination

Closes #47"
```

---

## Step 6 — Create PR

```bash
git push origin feature/p4-01-chat-data-models

gh pr create \
  --title "feat(models): create chat data models (Session, Message, Part)" \
  --body "## Summary

Implements **P4-01** — chat data models validated against the current OpenCode server API.

### Changes

- **session.dart** — Session, SessionStatus (idle|busy|retry), CreateSessionInput, nested types
- **part.dart** — MessagePart union (12 variants), ToolState, FilePartSource, ApiError
- **message.dart** — Message union (User|Assistant), MessageWithParts, MessageError, OutputFormat
- **models.dart** — barrel export
- **tests** — session/part/message tests + JSON fixtures

### Verification

- flutter analyze passes
- flutter test test/unit/data/models/ passes

Closes #47" \
  --head feature/p4-01-chat-data-models
```

---

## Verification Plan

### Automated

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze lib/data/models
flutter test test/unit/data/models/
```

### Manual

- Confirm fixture JSON matches real `opencode serve` output for /session, /session/status, /session/:id/message.
- Spot-check generated `.g.dart` files for correct `@JsonKey(name: 'tail_start_id')` mapping.
