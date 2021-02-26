import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/landing_page/home_page.dart';
import 'package:drFamily_app/screens/landing_page/setting.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageViewModel extends BaseModel {
  FirebaseUser _firebaseuser;

  PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<Widget> page = [
    HomeScreen(),
    SettingPage(),
    HomeScreen(),
    SettingPage(),
  ];

  LandingPageViewModel() {
    if (PushNotifycationService.usStatus == "Analysis Symptom Changing") {
      changingPage();
    } else {
      init();
    }
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("usPhone");
    int profileID = prefs.getInt("usProfileID");
    int userID = prefs.getInt("usAccountID");

    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;
    PushNotifycationService pushNotifycationService = PushNotifycationService();

    await pushNotifycationService.initialize();
    String tokenNotifycation = await pushNotifycationService.getToken();

    prefs.setString("usNotiToken", tokenNotifycation);

    print("Phone: " +
        phone +
        " ProfileID: " +
        profileID.toString() +
        " AccountID: " +
        userID.toString());
  }

  List<BottomNavyBarItem> _listItem = [
    BottomNavyBarItem(
        icon: Icon(EvaIcons.cameraOutline),
        title: Text('Doctor'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.gridOutline),
        title: Text('Service'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.calendarOutline),
        title: Text('Appointment'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.settingsOutline),
        title: Text('Setting'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400])
  ];

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  //getters
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;
  List<BottomNavyBarItem> get listItem => _listItem;

  Future<void> changingPage() async {
    await Future.delayed(Duration(milliseconds: 500));
    Get.to(() => TimeLineExamineScreen());
  }
}
