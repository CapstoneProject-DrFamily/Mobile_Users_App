import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class DoctorDetailScheduleViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();

  DoctorDetailModel _doctor;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getDoctorDetail(int doctorId) async {
    _doctor = await _doctorRepo.getDoctor(doctorId);

    print("done");
  }
}
