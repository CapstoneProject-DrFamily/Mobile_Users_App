import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class AppointmentViewModel extends BaseModel {
  DoctorScheduleModel doctorScheduleModel;
  int selectedValue;

  Map<String, List<ScheduleModel>> schedules =
      Map<String, List<ScheduleModel>>();
  void fetchData(DoctorScheduleModel model) {
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

  void changeSelectedDay(int value) {
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
}
