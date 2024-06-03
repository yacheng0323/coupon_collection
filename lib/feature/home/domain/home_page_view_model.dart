import 'package:coupon_collection/core/database/coupons_db_view_model.dart';
import 'package:coupon_collection/core/date_extension.dart';
import 'package:coupon_collection/core/entities/coupon_model.dart';
import 'package:flutter/material.dart';

final couponsDBProvider = CouponsDBViewModel();

class HomePageViewModel extends ChangeNotifier {
  List<CouponModel>? couponList;

  String? _category;

  String? get category => _category;

  String? _validity;

  String? get validity => _validity;

  String? _sortoption;

  String? get sortoption => _sortoption;

  void setCategory({required String value}) {
    _category = value;
    notifyListeners();
  }

  void setValidity({required String value}) {
    _validity = value;
    notifyListeners();
  }

  void setSortoption({required String value}) {
    _sortoption = value;
    notifyListeners();
  }

  Future<void> fetchAllCoupon() async {
    couponList = await couponsDBProvider.fetchCoupons();
    if (couponList?.isEmpty == true) {
      couponList = null;
    }
    couponList?.sort((a, b) => a.createTime.compareTo(b.createTime));
    notifyListeners();
    filterWithCategory();
  }

  Future<void> filterWithCategory() async {
    await fetchAllCoupon();

    List<CouponModel>? filterList = couponList;

    if (_category != null && _category != "All") {
      filterList = couponList?.where((e) => e.category == _category).toList();
    }

    if (_validity != null && _validity != "All") {
      final isAvailable = _validity == "Available";

      filterList = filterList?.where((e) {
        final isExpired =
            DateTime.fromMillisecondsSinceEpoch(e.endTime * 1000).isExpired();
        return isAvailable ? !isExpired : isExpired;
      }).toList();
    }

    if (_sortoption != null) {
      switch (_sortoption) {
        case "Started AtZ":
          filterList?.sort((a, b) => a.startTime.compareTo(b.startTime));
          break;
        case "Started ZtA":
          filterList?.sort((a, b) => b.startTime.compareTo(a.startTime));
          break;
        case "Expired AtZ":
          filterList?.sort((a, b) => a.endTime.compareTo(b.endTime));
          break;
        case "Expired ZtA":
          filterList?.sort((a, b) => b.endTime.compareTo(a.endTime));
          break;
        default:
          break;
      }
    }

    couponList = filterList;
    notifyListeners();
  }

  Future<void> deleteData(CouponModel data) async {
    int? id = await couponsDBProvider.getId(data);

    if (id != null) {
      await couponsDBProvider.deleteCoupon(data, id);
    }

    await fetchAllCoupon();

    notifyListeners();
  }
}
