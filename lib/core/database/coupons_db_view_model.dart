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
        category: coupon.category,
        start_time: coupon.startTime,
        end_time: coupon.endTime,
        create_time: coupon.createTime,
        content: coupon.content,
        imagepath: coupon.imagePath);
  }

  Future<int?> getId(CouponModel coupon) async {
    try {
      return await couponsDB.getId(coupon.createTime);
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
          category: item["category"],
          start_time: item["start_time"],
          end_time: item["end_time"],
          create_time: item["create_time"],
          content: item["content"],
          image_path: item["image_path"]);
      return UpdateResult(isUpdated: true);
    } catch (err) {
      return UpdateResult(isUpdated: false, errorMessage: "Update failed");
    }
  }

  Future<CouponModel> fetchById(int id) async {
    try {
      return await couponsDB.fetchById(id);
    } catch (err, s) {
      Error.throwWithStackTrace(err, s);
    }
  }

  Future<DeleteResult> deleteCoupon(CouponModel coupon, int id) async {
    return await couponsDB.delete(id);
  }
}
