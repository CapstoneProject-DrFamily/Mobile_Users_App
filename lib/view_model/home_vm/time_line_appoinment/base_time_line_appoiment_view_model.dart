import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/specialty_service_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTimeLineAppoinmentViewModel extends BaseModel {
  bool init = true;

  int initStep = 0;

  bool isLoad = true;

  List<int> oldStep = [];

  UserCurrentAddress pickUpInfo = UserCurrentAddress();

  int id;
  String notiToken;
  String fbId;

  List<String> appStepText = [
    "Choose Specialty",
    "Your Location",
    "Meet Our Doctor",
    "Doctor Info",
    "List Schedule",
    ""
  ];

  List<IconData> step = [
    EvaIcons.maximizeOutline,
    Icons.location_on,
    Icons.person_search,
    Icons.person_pin_outlined,
    Icons.perm_contact_calendar_outlined,
    Icons.sticky_note_2_outlined,
  ];

  void nextStep() {
    if (oldStep.contains(initStep)) {
    } else {
      oldStep.add(initStep);
    }
    initStep += 1;

    notifyListeners();
  }

  void backStep(int index) {
    initStep = index;
    notifyListeners();
  }

  Widget buildWidget(index) {
    switch (index) {
      case 0:
        return SpecialtyServiceScreen();
        break;
      // case 1:
      //   return MapScreen(
      //     baseTimeLineViewModel: model,
      //   );
      //   break;
      // case 2:
      //   return ListDoctorPage(
      //       pickUpInfo: pickUpInfo, baseTimeLineViewModel: model);
      //   break;
      // case 3:
      //   return DoctorDetailScreen(
      //     id: id,
      //     token: notiToken,
      //     fbId: fbId,
      //   );
      //   break;
      default:
        return null;
        break;
    }
  }
}
