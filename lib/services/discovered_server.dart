/// A resolved OpenCode server advertised on the local network via mDNS.
///
/// Equality is keyed on [name] + [host] + [port]. The TXT-record [attributes]
/// are excluded from equality because they can legitimately change (e.g. a
/// `version` bump) without representing a different server — including them
/// would break the upsert semantics in `MdnsService`.
class DiscoveredServer {
  const DiscoveredServer({
    required this.name,
    required this.host,
    required this.port,
    this.attributes = const {},
  });

  /// Service name advertised by the server (e.g. `"OpenCode on laptop"`).
  final String name;

  /// Resolved host or IP literal. Non-null: only constructed once the
  /// underlying bonsoir service has been resolved.
  final String host;

  /// TCP port the server listens on.
  final int port;

  /// TXT-record attributes (e.g. version, path). Never null; empty by default.
  final Map<String, String> attributes;

  /// Stable identifier used by `MdnsService` to upsert/remove entries.
  String get key => '$name|$host|$port';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscoveredServer &&
          other.name == name &&
          other.host == host &&
          other.port == port);

  @override
  int get hashCode => Object.hash(name, host, port);

  @override
  String toString() => 'DiscoveredServer(name: $name, host: $host:$port)';
}
