import 'package:auto_route/auto_route.dart';
import 'package:coupon_collection/core/date_extension.dart';
import 'package:coupon_collection/core/router/app_router.gr.dart';
import 'package:coupon_collection/core/styles/textgetter.dart';
import 'package:coupon_collection/core/utils/category_color.dart';
import 'package:coupon_collection/core/utils/dropdown_item.dart';
import 'package:coupon_collection/feature/home/domain/home_page_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        HomePageViewModel homePageViewModel = HomePageViewModel();
        homePageViewModel.fetchAllCoupon();
        return homePageViewModel;
      },
      builder: (context, child) {
        return Consumer<HomePageViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xffEE95A4),
                  title: Text(
                    "My Coupons",
                    style: textgetter.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          AutoRouter.of(context).push(NewCouponPageRoute(
                              isEditing: false, homePageViewModel: provider));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                      color: Colors.white,
                      height: 40,
                      child: Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text("Category",
                                  style: textgetter.bodyMedium?.copyWith(
                                      color: const Color(0xff2E2E2E))),
                              items: categoryList.map((item) {
                                return DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: Text(item,
                                          style: provider.category == item
                                              ? textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff6D93F7),
                                                  fontWeight: FontWeight.w700)
                                              : textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff2E2E2E))),
                                    ));
                              }).toList(),
                              value: provider.category,
                              onChanged: (String? value) {
                                provider.setCategory(value: value ?? "");
                                provider.filterWithCategory();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 40,
                                width: 120,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                              ),
                              iconStyleData: const IconStyleData(
                                iconSize: 30,
                                openMenuIcon: Icon(Icons.arrow_drop_up),
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text("Validity",
                                  style: textgetter.bodyMedium?.copyWith(
                                      color: const Color(0xff2E2E2E))),
                              items: validityList.map((item) {
                                return DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: Text(item,
                                          style: provider.validity == item
                                              ? textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff6D93F7),
                                                  fontWeight: FontWeight.w700)
                                              : textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff2E2E2E))),
                                    ));
                              }).toList(),
                              value: provider.validity,
                              onChanged: (String? value) {
                                provider.setValidity(value: value ?? "");
                                provider.filterWithCategory();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                height: 40,
                                width: 120,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                // maxHeight: ,
                                width: MediaQuery.of(context).size.width,
                              ),
                              iconStyleData: const IconStyleData(
                                iconSize: 30,
                                openMenuIcon: Icon(Icons.arrow_drop_up),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            provider.sortoption ?? "",
                            style: textgetter.bodyMedium
                                ?.copyWith(color: const Color(0xff8AA9F9)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              customButton: Image.asset(
                                "image/filter_list_off.png",
                                color: provider.sortoption != null
                                    ? const Color(0xff8AA9F9)
                                    : const Color(0xff2E2E2E),
                              ),
                              isExpanded: true,
                              items: sortOptionsList.map((item) {
                                return DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: Text(item,
                                          style: provider.sortoption == item
                                              ? textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff6D93F7),
                                                  fontWeight: FontWeight.w700)
                                              : textgetter.bodyMedium?.copyWith(
                                                  color:
                                                      const Color(0xff2E2E2E))),
                                    ));
                              }).toList(),
                              value: provider.sortoption,
                              onChanged: (String? value) {
                                provider.setSortoption(value: value ?? "");
                                provider.filterWithCategory();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                height: 40,
                                width: 120,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                // maxHeight: ,
                                width: MediaQuery.of(context).size.width,
                              ),
                              iconStyleData: const IconStyleData(
                                iconSize: 30,
                                openMenuIcon: Icon(Icons.arrow_drop_up),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    Image.asset(
                      "image/background.png",
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    provider.couponList != null
                        ? Container(
                            margin: const EdgeInsets.fromLTRB(24, 44, 24, 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.couponList?.length,
                              itemBuilder: (context, index) {
                                final item = provider.couponList![index];
                                return Dismissible(
                                  background: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    alignment: Alignment.centerRight,
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  key: ValueKey<int>(item.createTime),
                                  confirmDismiss: (direction) async {
                                    return await showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title:
                                              const Text("Confirm deletion?"),
                                          content: const Text(
                                              "Are you sure you want to delete this coupon??"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () async {
                                                  if (mounted) {
                                                    await provider
                                                        .deleteData(item);
                                                  }

                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Delete")),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    onTap: () {
                                      AutoRouter.of(context).push(
                                          NewCouponPageRoute(
                                              isEditing: true,
                                              coupon: item,
                                              homePageViewModel: provider));
                                    },
                                    // minVerticalPadding: 4,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            item.storeName,
                                            style: textgetter.titleLarge
                                                ?.copyWith(
                                                    color:
                                                        const Color(0xff2E2E2E),
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          DateTime.fromMillisecondsSinceEpoch(
                                                      item.endTime * 1000)
                                                  .isExpired()
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  color:
                                                      const Color(0xff939393),
                                                  child: Text(
                                                    "Expired",
                                                    style: textgetter.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          const Spacer(),
                                          Container(
                                            color: CategoryColor.getColor(
                                                item.category),
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 2, 4, 2),
                                            child: Text(
                                              item.category,
                                              style: textgetter.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Validity：${DateFormat("yyyy/MM/dd").format(DateTime.fromMillisecondsSinceEpoch(item.startTime * 1000))} ~ ${DateFormat("yyyy/MM/dd").format(DateTime.fromMillisecondsSinceEpoch(item.endTime * 1000))}",
                                              style: textgetter.bodySmall
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xffAAAAAA)),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Symbols.edit_square,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(24, 44, 24, 0),
                            height: 380,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 8, 0),
                                  child: Image.asset("image/point_arrow.png"),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "image/super_sale_discount_coupon.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(12)),
                                DottedBorder(
                                  dashPattern: const [8, 4],
                                  borderType: BorderType.RRect,
                                  strokeWidth: 1,
                                  color: const Color(0xffD2D2D2),
                                  radius: const Radius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 12, 24, 12),
                                    child: Text(
                                      "Add a new Coupon",
                                      style: textgetter.titleMedium?.copyWith(
                                          color: const Color(0xffD2D2D2),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                ));
          },
        );
      },
    );
  }
}
