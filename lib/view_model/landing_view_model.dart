import 'package:drFamily_app/screens/home_page.dart';
import 'package:drFamily_app/screens/landing_page/setting.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';

class LandingViewModel extends BaseModel {
  int _indexPage = 0;

  int get indexPage => _indexPage;

  final List<Widget> page = [
    HomePage(),
    SettingPage(),
  ];

  void changePage(int currentPage) {
    _indexPage = currentPage;
    notifyListeners();
  }
}
