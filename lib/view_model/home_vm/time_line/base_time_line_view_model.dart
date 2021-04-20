import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/home/doctor_detail_screen.dart';
import 'package:drFamily_app/screens/home/find_doctor/list_doctor_page.dart';
import 'package:drFamily_app/screens/home/find_doctor/map_page.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/specialty_service_screen.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/symptoms_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/reason_booking_real_time_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseTimeLineViewModel extends BaseModel {
  bool initMap = false;

  bool init = true;

  int initStep = 0;

  bool isLoad = true;

  List<int> oldStep = [];

  UserCurrentAddress pickUpInfo = UserCurrentAddress();

  int id;
  String notiToken;
  String fbId;
  int doctorId;

  List<String> appStepText = [
    "Choose Specialty",
    "Your Location",
    "Meet Our Doctor",
    "Doctor Info",
    ""
  ];

  String sympton = "Choose Symptoms";

  List<IconData> step = [
    EvaIcons.maximizeOutline,
    Icons.location_on,
    Icons.person_search,
    Icons.person_pin_outlined,
    Icons.sticky_note_2_outlined,
  ];
  //1: symptoms
  //2: specialty
  int typeFindDoctor;

  BaseTimeLineViewModel() {
    initBaseTimeLine();
  }

  void initBaseTimeLine() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    typeFindDoctor = prefs.getInt("typeFindDoctor");
    print('type $typeFindDoctor');
    notifyListeners();
  }

  void nextStep() {
    if (oldStep.contains(initStep)) {
    } else {
      oldStep.add(initStep);
    }
    initStep += 1;

    notifyListeners();
  }

  void backStep(int index) {
    if (index <= 2) {
      oldStep.removeWhere((element) => element == 3);
    }
    initStep = index;
    notifyListeners();
  }

  Widget buildWidget(BaseTimeLineViewModel model, index) {
    switch (index) {
      case 0:
        return (typeFindDoctor == 1)
            ? SymptomsScreen(baseTimeLineViewModel: model)
            : SpecialtyServiceScreen(baseTimeLineViewModel: model);
        break;
      case 1:
        return MapScreen(
          baseTimeLineViewModel: model,
        );
        break;
      case 2:
        return ListDoctorPage(
            pickUpInfo: pickUpInfo, baseTimeLineViewModel: model);
        break;
      case 3:
        return DoctorDetailScreen(
          id: id,
          token: notiToken,
          fbId: fbId,
          baseTimeLineViewModel: model,
        );
        break;
      case 4:
        return ReasonBookingRealTimeScreen(
          id: id,
          token: notiToken,
          fbId: fbId,
        );
        break;
      default:
        return null;
        break;
    }
  }
}
