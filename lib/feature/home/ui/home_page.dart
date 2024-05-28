import 'package:auto_route/auto_route.dart';
import 'package:coupon_collection/core/styles/textgetter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = [
    "全部",
    "電子產品",
    "美妝",
    "生活百貨",
    "食品",
    "服飾",
    "其他",
  ];
  String? selectedValue;

  final List<String> items2 = [
    "全部",
    "可使用",
    "已過期",
  ];
  String? selectedValue2;

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffEE95A4),
          title: Text(
            "我的優惠券",
            style: textgetter.titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
        body: Stack(
          children: [
            Image.asset(
              "image/background.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  color: Colors.white,
                  height: 40,
                  child: Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text('優惠券分類',
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Color(0xff2E2E2E))),
                          items: _addDividersAfterItems(items),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
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
                            // maxHeight: 250,
                            width: MediaQuery.of(context).size.width,
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights(),
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
                          hint: Text('使用效期',
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Color(0xff2E2E2E))),
                          items: _addDividersAfterItems2(items2),
                          value: selectedValue2,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue2 = value;
                            });
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
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights2(),
                          ),
                          iconStyleData: const IconStyleData(
                            iconSize: 30,
                            openMenuIcon: Icon(Icons.arrow_drop_up),
                          ),
                        ),
                      ),
                      const Spacer(),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          customButton:
                              Image.asset("image/filter_list_off.png"),
                          isExpanded: true,
                          hint: Text('使用效期',
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Color(0xff2E2E2E))),
                          items: _addDividersAfterItems2(items2),
                          value: selectedValue2,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue2 = value;
                            });
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
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights2(),
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
                Container(
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
                        padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                        child: Image.asset("image/point_arrow.png"),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "image/super_sale_discount_coupon.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      DottedBorder(
                        dashPattern: const [8, 4],
                        strokeWidth: 2,
                        color: const Color(0xffD2D2D2),
                        radius: const Radius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            "紀錄第一筆優惠券",
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
            ),
          ],
        ));
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Center(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),

          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 1,
                color: Color(0xffECECEC),
              ),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(50);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(2);
      }
    }

    return itemsHeights;
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems2(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items2) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Center(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),

          //If it's last item, we will not add Divider after it.
          if (item != items2.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 1,
                color: Color(0xffECECEC),
              ),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights2() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items2.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(50);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(2);
      }
    }
    return itemsHeights;
  }
}
