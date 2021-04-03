import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';

class AppointmentViewModel extends BaseModel {
  DoctorScheduleModel doctorScheduleModel;
  String selectedValue;

  Map<String, List<ScheduleModel>> schedules =
      Map<String, List<ScheduleModel>>();

  void fetchData(DoctorScheduleModel model) {
    print('doctorschedulemodel ${model.doctorDetail.doctorId}');
    this.doctorScheduleModel = model;

    for (int i = 0; i < doctorScheduleModel.schedules.length; i++) {
      ScheduleModel schedule = doctorScheduleModel.schedules[i];
      convert(schedule);
    }
    // schedules.forEach((key, value) {
    //   print(key);
    //   print(value.toList());
    // });
    notifyListeners();
  }

  void changeSelectedDay(String value) {
    this.selectedValue = value;

    notifyListeners();
  }

  void convert(ScheduleModel schedule) {
    String appointmentDay = schedule.appointmentTime.substring(0, 10);

    if (!schedules.containsKey(appointmentDay)) {
      List<ScheduleModel> listTime = [];
      listTime.add(schedule);
      schedules[appointmentDay] = listTime;
    } else {
      List<ScheduleModel> listTemp = schedules[appointmentDay];
      listTemp.add(schedule);
      schedules[appointmentDay] = listTemp;
    }
  }

  void nextStep(
    BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel,
  ) {
    print("schedule $schedules");
    baseTimeLineAppoinmentViewModel.schedules = schedules;
    baseTimeLineAppoinmentViewModel.selectedValue = selectedValue;
    baseTimeLineAppoinmentViewModel.nextStep();
  }
}
