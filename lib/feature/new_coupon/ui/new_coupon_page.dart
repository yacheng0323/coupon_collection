import 'package:auto_route/auto_route.dart';
import 'package:coupon_collection/core/styles/textgetter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NewCouponPage extends StatefulWidget {
  const NewCouponPage({super.key});

  @override
  State<NewCouponPage> createState() => _NewCouponPageState();
}

class _NewCouponPageState extends State<NewCouponPage> {
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
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEE95A4),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "新增優惠券",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "完成",
                style: textgetter.titleMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )),
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
          SingleChildScrollView(
            child: Form(
              // key: ,
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "輸入店家名",
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: textgetter.bodyMedium
                              ?.copyWith(color: Color(0xffAAAAAA)),
                          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text("優惠券分類",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Color(0xffAAAAAA))),
                          items: _addDividersAfterItems(items),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights(),
                          ),
                          iconStyleData: const IconStyleData(
                            iconSize: 30,
                            openMenuIcon: Icon(Icons.arrow_drop_up),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Text(
                            "使用期間",
                            style: textgetter.bodyMedium
                                ?.copyWith(color: Color(0xffAAAAAA)),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
                          SizedBox(
                            height: 16,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                          Text(
                            "${DateFormat("yyyy-MM-dd").format(DateTime(2024, 10, 10))} ~ ${DateFormat("yyyy-MM-dd").format(DateTime(2024, 10, 25))}",
                            style: textgetter.bodyMedium
                                ?.copyWith(color: Color(0xffAAAAAA)),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.date_range_sharp,
                            color: Color(0xffAAAAAA),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(36, 8, 36, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "優惠券詳情",
                            style: textgetter.titleLarge
                                ?.copyWith(color: Color(0xff2E2E2E)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              //TODO: 上傳圖片
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffE6E6E6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("image/image_placeholder.png"),
                                  const Padding(padding: EdgeInsets.all(4)),
                                  Text(
                                    "上傳優惠券",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Color(0xffAAAAAA)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 100,
                              decoration: InputDecoration(
                                  hintStyle: textgetter.bodyMedium
                                      ?.copyWith(color: Color(0xffAAAAAA)),
                                  hintText: "請輸入優惠券內容",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Align(
              alignment: Alignment.centerLeft,
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
}
