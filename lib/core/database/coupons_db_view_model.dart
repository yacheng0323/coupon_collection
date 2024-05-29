import 'package:coupon_collection/core/database/coupons_db.dart';
import 'package:coupon_collection/core/entities/coupon_model.dart';
import 'package:coupon_collection/core/entities/delete_result.dart';
import 'package:coupon_collection/core/entities/insert_result.dart';
import 'package:coupon_collection/core/entities/update_result.dart';
import 'package:flutter/material.dart';

class CouponsDBViewModel extends ChangeNotifier {
  final couponsDB = CouponsDB();

  Future<List<CouponModel>> fetchCoupons() async {
    return await couponsDB.fetchAll();
  }

  Future<InsertResult> newCoupon(CouponModel coupon) async {
    return await couponsDB.insert(
        store_name: coupon.storeName,
        type: coupon.type,
        start_time: coupon.startTime,
        end_time: coupon.endTime,
        content: coupon.content,
        imagepath: coupon.imagePath);
  }

  Future<int?> getId(CouponModel coupon) async {
    try {
      return await couponsDB.getId(coupon.storeName);
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  Future<UpdateResult> updateCoupon(CouponModel coupon, int id) async {
    Map<String, dynamic> item = coupon.toMap();

    try {
      await couponsDB.update(
          id: id,
          store_name: item["store_name"],
          type: item["type"],
          start_time: item["start_time"],
          end_time: item["end_time"],
          content: item["content"],
          image_path: item["image_path"]);
      return UpdateResult(isUpdated: true);
    } catch (err) {
      return UpdateResult(isUpdated: false, errorMessage: "$err");
    }
  }

  Future<DeleteResult> deleteCoupon(CouponModel coupon, int id) async {
    return await couponsDB.delete(id);
  }
}
