import 'package:auto_route/auto_route.dart';
import 'package:coupon_collection/core/styles/textgetter.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewCouponPage extends StatefulWidget {
  const NewCouponPage({super.key});

  @override
  State<NewCouponPage> createState() => _NewCouponPageState();
}

class _NewCouponPageState extends State<NewCouponPage> {
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "新增優惠券",
          style: textgetter.titleLarge?.copyWith(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "完成",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
