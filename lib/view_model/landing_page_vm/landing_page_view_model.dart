import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/repository/user_repo.dart';
import 'package:drFamily_app/screens/landing_page/history_record_screen.dart';
import 'package:drFamily_app/screens/landing_page/home_page.dart';
import 'package:drFamily_app/screens/landing_page/map_tracking_screen.dart';
import 'package:drFamily_app/model/home/landing_model.dart';
import 'package:drFamily_app/repository/langding/landing_repo.dart';
import 'package:drFamily_app/screens/schedule/list_schedule_appointment_screen.dart';
import 'package:drFamily_app/screens/setting/setting_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/waiting_booking_doctor_view_model.dart';
import 'package:drFamily_app/view_model/landing_page_vm/map_tracking_screen_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageViewModel extends BaseModel {
  final IUserRepo _userRepo = UserRepo();
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
    ListScheduleAppointmentScreen(),
    HistoryRecordScreen(),
    SettingPage(),
  ];

  LandingPageViewModel() {
    if (WaitingBookingDoctorViewModel.screenStatus.contains("Changing")) {
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
    print('profile $profileID');
    int userID = prefs.getInt("usAccountID");

    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;
    PushNotifycationService pushNotifycationService = PushNotifycationService();

    await pushNotifycationService.initialize();
    String tokenNotifycation = await pushNotifycationService.getToken();

    _userRepo.updateUser(tokenNotifycation);

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
        title: Text('Home'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.calendarOutline),
        title: Text('Schedule'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.clockOutline),
        title: Text('Records'),
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
    String transactionId = WaitingBookingDoctorViewModel.homeTransactionId;
    await Future.delayed(Duration(milliseconds: 500));
    Get.to(() => MapTrackingScreen(
          model: MapTrackingScreenViewModel(
              transactionId, WaitingBookingDoctorViewModel.doctorFBId),
        )).then((value) {
      notifyListeners();
    });
  }
}
