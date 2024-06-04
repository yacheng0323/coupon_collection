import 'dart:io';
import 'package:coupon_collection/core/custom/image_helper.dart';
import 'package:coupon_collection/core/database/coupons_db_view_model.dart';
import 'package:coupon_collection/core/entities/coupon_model.dart';
import 'package:coupon_collection/core/entities/insert_result.dart';
import 'package:coupon_collection/core/entities/update_result.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final imageHelperProvider = ImageHelper();

final couponsDBProvider = CouponsDBViewModel();

class NewCouponViewModel extends ChangeNotifier {
  InsertResult? insertResult;

  UpdateResult? updateResult;

  DateTime? _startTime;

  DateTime? get startTime => _startTime;

  DateTime? _endTime;

  DateTime? get entTime => _endTime;

  String? _category;

  String? get category => _category;

  File? _imageFile;

  File? get imageFile => _imageFile;

  String? _saveImagePath;

  String? get saveImagePath => _saveImagePath;

  String? _notValidateMessage;

  String? get notValidateMessage => _notValidateMessage;

  List<String>? _categoryList;

  List<String>? get categoryList => _categoryList;

  Future<void> init(CouponModel coupon) async {
    _startTime = DateTime.fromMillisecondsSinceEpoch(coupon.startTime * 1000);
    _endTime = DateTime.fromMillisecondsSinceEpoch(coupon.endTime * 1000);
    _category = coupon.category;

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(path.join(documentDirectory.path, coupon.imagePath));

    if (file.existsSync()) {
      _imageFile = file;
    } else {
      _imageFile = null;
    }
    notifyListeners();
  }

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
    final result = await imageHelperProvider.getImage(fromCamera: fromCamera);
    _imageFile = result.first;
    _saveImagePath = result.second;
    notifyListeners();
  }

  Future<void> addCoupon(
      {required String storeName, required String content}) async {
    CouponModel couponModel = CouponModel(
        storeName: storeName,
        category: _category!,
        startTime: _startTime!.millisecondsSinceEpoch ~/ 1000,
        endTime: _endTime!.millisecondsSinceEpoch ~/ 1000,
        createTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        content: content,
        imagePath: _saveImagePath);
    insertResult = await couponsDBProvider.newCoupon(couponModel);
    await handleTemporaryDirectory();
    await copyImageToDocumentDirectory();
    notifyListeners();
  }

  Future<void> updateCoupon(
      {required CouponModel coupon,
      required String storeName,
      required String content}) async {
    int? id = await couponsDBProvider.getId(coupon);
    if (id != null) {
      final result = CouponModel(
          storeName: storeName,
          category: _category!,
          startTime: (_startTime!.millisecondsSinceEpoch ~/ 1000),
          endTime: (_endTime!.millisecondsSinceEpoch ~/ 1000),
          createTime: coupon.createTime,
          imagePath: _saveImagePath,
          content: content);
      updateResult = await couponsDBProvider.updateCoupon(result, id);
    }
    await handleTemporaryDirectory();
    await copyImageToDocumentDirectory();
    notifyListeners();
  }

  Future<void> handleTemporaryDirectory() async {
    Directory temporaryDirectory = await getTemporaryDirectory();
    if (temporaryDirectory.existsSync()) {
      List<FileSystemEntity> files =
          temporaryDirectory.listSync(recursive: false);
      for (FileSystemEntity file in files) {
        if (file is File) {
          await file.delete();
        }
      }
    }
  }

  Future<void> copyImageToDocumentDirectory() async {
    if (_saveImagePath != null && _imageFile != null) {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      await _imageFile!
          .copy(path.join(documentDirectory.path, _saveImagePath!));
    }
  }
}
