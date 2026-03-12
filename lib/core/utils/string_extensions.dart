extension StringX on String {
  String truncate(int length, {String suffix = '...'}) {
    if (this.length <= length || length <= suffix.length) {
      return this;
    }
    return '${substring(0, length - suffix.length)}$suffix';
  }

  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  bool isValidUrl({bool httpsOnly = false}) {
    final uri = Uri.tryParse(this);
    if (uri == null) {
      return false;
    }

    if (httpsOnly) {
      return uri.scheme == 'https';
    }

    return uri.scheme == 'http' || uri.scheme == 'https';
  }
}
