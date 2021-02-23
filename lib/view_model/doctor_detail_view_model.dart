import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class DoctorDetailViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();

  DoctorDetailModel _doctor;
  DoctorDetailModel get doctor => _doctor;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _tokenNotiDoctor;

  DoctorDetailViewModel();

  Future<void> getDoctorDetail(int doctorId, String token) async {
    _doctor = await _doctorRepo.getDoctor(doctorId);
    _tokenNotiDoctor = token;
    print(_tokenNotiDoctor);
  }

  Future<void> confirmBooking() async {
    print("in noti");
    await _notifyRepo.bookDoctor(_tokenNotiDoctor, 5);
  }
}
