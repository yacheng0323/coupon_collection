import 'package:auto_route/auto_route.dart';
import 'package:coupon_collection/feature/new_coupon/ui/new_coupon_page.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "page.route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomePageRoute.page, initial: true),
        AutoRoute(page: NewCouponPageRoute.page),
      ];
}
