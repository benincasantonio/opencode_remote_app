// ignore_for_file: file_size_signal, fixture exercises other rules
import 'package:flutter/foundation.dart';

/// Good: immutable DTO — must NOT trigger models_are_dtos.
class GoodDto {
  const GoodDto({required this.id, required this.name});

  final String id;
  final String name;
}

/// Bad: mutable non-final field.
class MutableModel {
  MutableModel({required this.id});

  // expect_lint: models_are_dtos
  String id;
}

/// Bad: ChangeNotifier in data/models (issue acceptance fixture).
// expect_lint: models_are_dtos
class NotifierModel extends ChangeNotifier {
  NotifierModel(this.value);

  // expect_lint: models_are_dtos
  int value;

  void bump() {
    value++;
    notifyListeners();
  }
}
