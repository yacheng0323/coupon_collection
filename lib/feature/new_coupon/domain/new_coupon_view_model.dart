import 'dart:io';

import 'package:coupon_collection/core/custom/image_helper.dart';
import 'package:coupon_collection/core/database/coupons_db_view_model.dart';
import 'package:coupon_collection/core/entities/coupon_model.dart';
import 'package:coupon_collection/core/entities/insert_result.dart';
import 'package:flutter/material.dart';

final imageHelperProvider = ImageHelper();

final couponsDBProvider = CouponsDBViewModel();

class NewCouponViewModel extends ChangeNotifier {
  InsertResult? insertResult;

  DateTime? _startTime;

  DateTime? get startTime => _startTime;

  DateTime? _endTime;

  DateTime? get entTime => _endTime;

  String? _category;

  String? get category => _category;

  String? _content;

  String? get content => _content;

  File? _imageFile;

  File? get imageFile => _imageFile;

  String? _notValidateMessage;

  String? get notValidateMessage => _notValidateMessage;

  void validateForm() {
    String message = "";
    if (_category == null) {
      message += "Please select a category.\n";
    }
    if (_startTime == null) {
      message += "Please select the effective date and expiration date.";
    }
    _notValidateMessage = message;
    notifyListeners();
  }

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

  Future<void> setImage({required bool fromCamera}) async {
    final file = await imageHelperProvider.getImage(fromCamera: fromCamera);
    _imageFile = file;
    notifyListeners();
  }

  Future<void> addCoupon({required String storeName}) async {
    CouponModel couponModel = CouponModel(
        storeName: storeName,
        category: _category!,
        startTime: _startTime!.millisecondsSinceEpoch ~/ 1000,
        endTime: _endTime!.millisecondsSinceEpoch ~/ 1000,
        createTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        content: _content,
        imagePath: _imageFile?.path);
    insertResult = await couponsDBProvider.newCoupon(couponModel);
    notifyListeners();
  }
}
