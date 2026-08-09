import 'package:flutter/foundation.dart';

class GoodDto {
  const GoodDto({required this.id, required this.name});

  final String id;
  final String name;
}

class MutableModel {
  MutableModel({required this.id});

  // expect_lint: models_are_dtos
  String id;
}

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
