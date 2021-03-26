import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class ListDoctorScheduleViewModel extends BaseModel {
  IDoctorRepo _doctorRepo = DoctorRepo();
  bool init = true;
  List<DoctorScheduleModel> listResult = [];

  Future<void> fetchData(int specialityId) async {
    if (init) {
      this.listResult = await _doctorRepo.getDoctorsBySpeciality(specialityId);
      print(this.listResult.length);
      this.init = false;
      notifyListeners();
    }
  }
}
