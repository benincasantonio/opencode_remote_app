import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  T? get dataOrNull {
    if (this is AsyncData<T>) {
      return (this as AsyncData<T>).value;
    }
    return null;
  }

  (Object, StackTrace)? get errorOrNull {
    if (this is AsyncError) {
      final errorState = this as AsyncError;
      return (errorState.error, errorState.stackTrace);
    }
    return null;
  }
}
