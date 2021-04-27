import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDoctorScheduleViewModel extends BaseModel {
  IDoctorRepo _doctorRepo = DoctorRepo();
  bool init = true;
  List<DoctorScheduleModel> listResult = [];
  bool loadBack = false;

  Future<void> fetchData(int specialityId) async {
    if (init) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("specialityId $specialityId");
      int patientid = prefs.getInt('usPatientID');
      var isDefault = prefs.getBool("isServiceDefault");
      print("patientID : " +
          patientid.toString() +
          "isDefaultService" +
          isDefault.toString());
      if (isDefault) {
        this.listResult = await _doctorRepo.getDoctorsBySpeciality(-1);
      } else {
        this.listResult =
            await _doctorRepo.getDoctorsBySpeciality(specialityId);
      }
      print(this.listResult.length);
      this.init = false;
      notifyListeners();
    }
  }

  void loadBackList(int specialityId) async {
    loadBack = true;
    notifyListeners();
    listResult = [];
    this.listResult = await _doctorRepo.getDoctorsBySpeciality(specialityId);

    loadBack = false;
    notifyListeners();
  }

  void nextStep(BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel,
      DoctorScheduleModel doctorScheduleModel) {
    baseTimeLineAppoinmentViewModel.doctorScheduleModel = doctorScheduleModel;
    baseTimeLineAppoinmentViewModel.nextStep();
  }
}
