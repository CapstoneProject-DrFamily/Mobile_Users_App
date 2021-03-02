import 'package:drFamily_app/screens/login/login_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewModel extends BaseModel {
  String _fullName, _img;
  String get fullName => _fullName;
  String get img => _img;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SettingViewModel() {
    getPatientProfile();
  }

  void getPatientProfile() async {
    this._isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _fullName = prefs.getString("usFullName");
    _img = prefs.getString("usImg");

    this._isLoading = false;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}
