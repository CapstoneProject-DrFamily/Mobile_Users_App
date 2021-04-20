import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/home/find_doctor/map_page.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/specialty_service_screen.dart';
import 'package:drFamily_app/screens/schedule/appointment_screen.dart';
import 'package:drFamily_app/screens/schedule/doctor_detail_schedule_screen.dart';
import 'package:drFamily_app/screens/schedule/list_doctor_in_schedule_screen.dart';
import 'package:drFamily_app/screens/schedule/reason_appointment_screen.dart';
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

  int specialty;

  DoctorScheduleModel doctorScheduleModel;

  int selectedValue;

  Map<String, List<ScheduleModel>> schedules = {};

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
    if (index <= 2) {
      oldStep.removeWhere((element) => element == 3);
      oldStep.removeWhere((element) => element == 4);
      oldStep.removeWhere((element) => element == 5);
    }
    initStep = index;
    notifyListeners();
  }

  Widget buildWidget(index, BaseTimeLineAppoinmentViewModel model) {
    switch (index) {
      case 0:
        return SpecialtyServiceScreen(
          baseTimeLineAppoinmentViewModel: model,
        );
        break;
      case 1:
        return MapScreen(
          baseTimeLineAppoinmentViewModel: model,
        );
        break;
      case 2:
        return ListDoctorScheduleScreen(
          specialityId: specialty,
          baseTimeLineAppoinmentViewModel: model,
        );
        break;
      case 3:
        return DoctorDetailScheduleScreen(
          doctorScheduleModel: doctorScheduleModel,
          baseTimeLineAppoinmentViewModel: model,
        );
        break;
      case 4:
        return AppointmentScreen(
          doctorScheduleModel: doctorScheduleModel,
          baseTimeLineAppoinmentViewModel: model,
        );
        break;
      case 5:
        return ReasonAppointmentScreen(
          doctorScheduleModel: doctorScheduleModel,
          schedules: schedules,
          selectedValue: selectedValue,
        );
        break;
      default:
        return null;
        break;
    }
  }
}
