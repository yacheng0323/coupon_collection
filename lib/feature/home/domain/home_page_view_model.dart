import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  // final _content = BehaviorSubject<String>.seeded("");

  // BehaviorSubject<String> get content => _content;

  // void sdskd() async {
  //   _content.add("hehehehe");
  // }

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
}
