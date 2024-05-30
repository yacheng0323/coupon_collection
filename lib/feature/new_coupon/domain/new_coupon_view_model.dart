import 'package:flutter/material.dart';

class NewCouponViewModel extends ChangeNotifier {
  DateTime? _startTime;

  DateTime? get startTime => _startTime;

  DateTime? _endTime;

  DateTime? get entTime => _endTime;

  String? _category;

  String? get category => _category;

  void setCategory({required String value}) {
    _category = value;
    notifyListeners();
  }

  void setDatePeriod({required List<DateTime?> dateTimeList}) {
    if (dateTimeList.length > 1) {
      _startTime = dateTimeList[0]!;
      _endTime = dateTimeList[1]!;
    } else if (dateTimeList.length == 1) {
      _startTime = dateTimeList[0]!;
      _endTime = dateTimeList[0]!;
    }

    notifyListeners();
  }
}
