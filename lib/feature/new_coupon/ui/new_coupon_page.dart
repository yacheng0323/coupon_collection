import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:coupon_collection/core/custom/show_snackbar.dart';
import 'package:coupon_collection/core/styles/textgetter.dart';
import 'package:coupon_collection/core/utils/dropdown_item.dart';
import 'package:coupon_collection/feature/new_coupon/domain/new_coupon_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@RoutePage()
class NewCouponPage extends StatefulWidget {
  const NewCouponPage({super.key});

  @override
  State<NewCouponPage> createState() => _NewCouponPageState();
}

class _NewCouponPageState extends State<NewCouponPage> {
  final formKey = GlobalKey<FormState>();
  late final storeNameController = TextEditingController();
  late final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    storeNameController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);
    return PopScope(
      canPop: false,
      child: ChangeNotifierProvider(
        create: (context) {
          NewCouponViewModel newCouponViewModel = NewCouponViewModel();

          return newCouponViewModel;
        },
        builder: (context, child) {
          return Consumer<NewCouponViewModel>(
            builder: (context, provider, child) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xffEE95A4),
                  iconTheme: const IconThemeData(color: Colors.white),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text("Quit"),
                              content: const Text(
                                  "Are you sure to leave right now？"),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                  title: Text(
                    "Add New",
                    style: textgetter.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            provider.validateForm();

                            if (provider.notValidateMessage!.isNotEmpty) {
                              ShowSnackBarHelper.errorSnackBar(context: context)
                                  .showSnackbar(
                                      provider.notValidateMessage ?? "");
                            } else {
                              await provider.addCoupon(
                                  storeName: storeNameController.text);

                              if (provider.insertResult?.isSuccess == true) {
                                ShowSnackBarHelper.successSnackBar(
                                        context: context)
                                    .showSnackbar("Addition successful.");
                                Navigator.pop(context);
                              } else {
                                ShowSnackBarHelper.errorSnackBar(
                                        context: context)
                                    .showSnackbar("Addition failed.");
                              }
                            }
                          }
                        },
                        child: Text(
                          "Done",
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
                        key: formKey,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: storeNameController,
                                style: textgetter.bodyLarge?.copyWith(
                                    color: Color(0xff6D93F7),
                                    fontWeight: FontWeight.w700),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(100)
                                ],
                                decoration: InputDecoration(
                                    hintText: "Store Name",
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: textgetter.bodyMedium?.copyWith(
                                        color: const Color(0xffAAAAAA)),
                                    errorStyle: textgetter.bodySmall
                                        ?.copyWith(color: Colors.red),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  return value?.isEmpty == true
                                      ? "店家名稱為必填喔！"
                                      : null;
                                },
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text("Category",
                                        style: textgetter.bodyMedium?.copyWith(
                                            color: const Color(0xffAAAAAA))),
                                    items: categoryList.map((item) {
                                      return DropdownMenuItem<String>(
                                          value: item,
                                          child: Center(
                                            child: Text(
                                              item,
                                              style: provider.category == item
                                                  ? textgetter.bodyMedium
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xff6D93F7))
                                                  : textgetter.bodyMedium
                                                      ?.copyWith(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 32, 25, 25)),
                                            ),
                                          ));
                                    }).toList(),
                                    value: provider.category,
                                    onChanged: (String? value) {
                                      provider.setCategory(value: value ?? "");
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    dropdownStyleData: const DropdownStyleData(
                                      offset: Offset(0, 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      // customHeights: _getCustomItemsHeights(),
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
                              GestureDetector(
                                onTap: () async {
                                  final result =
                                      await showCalendarDatePicker2Dialog(
                                    context: context,
                                    dialogSize: Size(
                                        MediaQuery.of(context).size.width, 300),
                                    config:
                                        CalendarDatePicker2WithActionButtonsConfig(
                                      calendarType:
                                          CalendarDatePicker2Type.range,
                                      calendarViewMode:
                                          CalendarDatePicker2Mode.day,
                                      currentDate: DateTime.now(),
                                      selectedDayHighlightColor:
                                          Color(0xff6D93F7),
                                      dayTextStylePredicate: ({required date}) {
                                        if (date.weekday == DateTime.saturday ||
                                            date.weekday == DateTime.sunday) {
                                          return textgetter.bodyMedium
                                              ?.copyWith(color: Colors.red);
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                  if (result != null) {
                                    provider.setDatePeriod(
                                        dateTimeList: result);
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Validity Period",
                                        style: textgetter.bodyMedium?.copyWith(
                                            color: const Color(0xffAAAAAA)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                        child: VerticalDivider(
                                          thickness: 1,
                                          color: Color(0xffAAAAAA),
                                        ),
                                      ),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(4, 0, 0, 0)),
                                      Text(
                                        DateFormat("yyyy-MM-dd").format(
                                            provider.startTime != null
                                                ? provider.startTime!
                                                : DateTime.now()),
                                        style: textgetter.bodyMedium?.copyWith(
                                            color: provider.startTime != null
                                                ? Color(0xff6D93F7)
                                                : const Color(0xffAAAAAA)),
                                      ),
                                      Text(
                                        "～",
                                        style: textgetter.bodyMedium?.copyWith(
                                            color: Color(0xffAAAAAA)),
                                      ),
                                      Text(
                                        DateFormat("yyyy-MM-dd").format(
                                            provider.entTime != null
                                                ? provider.entTime!
                                                : DateTime.now()),
                                        style: textgetter.bodyMedium?.copyWith(
                                            color: provider.startTime != null
                                                ? Color(0xff6D93F7)
                                                : Color(0xffAAAAAA)),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.date_range_sharp,
                                        color: Color(0xffAAAAAA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(36, 8, 36, 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Coupon Details",
                                      style: textgetter.titleLarge?.copyWith(
                                          color: const Color(0xff2E2E2E)),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        //TODO: 上傳圖片
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoActionSheet(
                                            title: const Text(
                                                "Please select upload method"),
                                            actions: [
                                              CupertinoActionSheetAction(
                                                child: const Text(
                                                    "From Photo Library"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  provider.setImage(
                                                      fromCamera: false);
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: const Text("Take Photo"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  provider.setImage(
                                                      fromCamera: true);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: provider.imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                  provider.imageFile ??
                                                      File("")),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffE6E6E6),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "image/image_placeholder.png"),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(4)),
                                                  Text(
                                                    "Upload your coupon",
                                                    style: textgetter.bodyMedium
                                                        ?.copyWith(
                                                            color: const Color(
                                                                0xffAAAAAA)),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: TextFormField(
                                        controller: contentController,
                                        minLines: 1,
                                        maxLines: 100,
                                        decoration: InputDecoration(
                                            hintStyle: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: const Color(
                                                        0xffAAAAAA)),
                                            hintText:
                                                "Please enter the coupon content.",
                                            border: const OutlineInputBorder(
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
            },
          );
        },
      ),
    );
  }
}
