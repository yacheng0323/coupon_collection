// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:coupon_collection/core/entities/coupon_model.dart' as _i5;
import 'package:coupon_collection/feature/home/domain/home_page_view_model.dart'
    as _i6;
import 'package:coupon_collection/feature/home/ui/home_page.dart' as _i1;
import 'package:coupon_collection/feature/new_coupon/ui/new_coupon_page.dart'
    as _i2;
import 'package:flutter/cupertino.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    NewCouponPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewCouponPageRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.NewCouponPage(
          key: args.key,
          coupon: args.coupon,
          isEditing: args.isEditing,
          homePageViewModel: args.homePageViewModel,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i3.PageRouteInfo<void> {
  const HomePageRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NewCouponPage]
class NewCouponPageRoute extends _i3.PageRouteInfo<NewCouponPageRouteArgs> {
  NewCouponPageRoute({
    _i4.Key? key,
    _i5.CouponModel? coupon,
    required bool isEditing,
    required _i6.HomePageViewModel homePageViewModel,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          NewCouponPageRoute.name,
          args: NewCouponPageRouteArgs(
            key: key,
            coupon: coupon,
            isEditing: isEditing,
            homePageViewModel: homePageViewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'NewCouponPageRoute';

  static const _i3.PageInfo<NewCouponPageRouteArgs> page =
      _i3.PageInfo<NewCouponPageRouteArgs>(name);
}

class NewCouponPageRouteArgs {
  const NewCouponPageRouteArgs({
    this.key,
    this.coupon,
    required this.isEditing,
    required this.homePageViewModel,
  });

  final _i4.Key? key;

  final _i5.CouponModel? coupon;

  final bool isEditing;

  final _i6.HomePageViewModel homePageViewModel;

  @override
  String toString() {
    return 'NewCouponPageRouteArgs{key: $key, coupon: $coupon, isEditing: $isEditing, homePageViewModel: $homePageViewModel}';
  }
}
