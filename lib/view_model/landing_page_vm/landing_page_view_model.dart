import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/screens/landing_page/home_page.dart';
import 'package:drFamily_app/screens/landing_page/map_tracking_screen.dart';
import 'package:drFamily_app/model/home/landing_model.dart';
import 'package:drFamily_app/repository/langding/landing_repo.dart';
import 'package:drFamily_app/screens/setting/setting_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/map_tracking_screen_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageViewModel extends BaseModel {
  FirebaseUser _firebaseuser;

  PageController _pageController = PageController();

  int _currentIndex = 0;

  final ILangdingRepo _langdingRepo = LangdingRepo();
  LandingModel _landingModel;

  String _fullName, _img;
  String get fullName => _fullName;
  String get img => _img;

  final List<Widget> page = [
    HomeScreen(),
    SettingPage(),
    HomeScreen(),
    SettingPage(),
  ];

  LandingPageViewModel() {
    if (PushNotifycationService.usStatus.contains("Changing")) {
      changingPage();
    } else {
      init();
    }
  }

  Future<void> init() async {
    DateTime.now().add(Duration(seconds: 1689));
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

    _landingModel = await _langdingRepo.getPatientProfile(profileID.toString());
    _fullName = _landingModel.fullName;
    _img = _landingModel.image;

    prefs.setString("usFullName", fullName);
    prefs.setString("usImg", img);

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
    String transactionId = PushNotifycationService.usTransactionID;
    await Future.delayed(Duration(milliseconds: 500));
    Get.to(() => MapTrackingScreen(
          model: MapTrackingScreenViewModel(transactionId),
        )).then((value) {
      notifyListeners();
    });
  }
}
