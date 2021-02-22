import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class DoctorDetailViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  DoctorDetailModel _doctor;
  DoctorDetailModel get doctor => _doctor;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DoctorDetailViewModel();

  Future<void> getDoctorDetail(int doctorId) async {
    _doctor = await _doctorRepo.getDoctor(doctorId);
  }

  // Future<DoctorModel> loadDoctor(id) async {
  //   if (id == 1) {
  //     doctor = DoctorModel.fullInfo(
  //         id: 1,
  //         name: 'Dr Trần Anh Khoa',
  //         speciality: 'Khoa Nhi',
  //         year: 10,
  //         image:
  //             'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg',
  //         rating: 4,
  //         description:
  //             'Spending time at national parks can be an exciting adventure, but this wasnt the type of excitement she was hoping to experience.',
  //         degree: 'Bác sĩ Chuyên Khoa I',
  //         schoolStudy: 'ĐH Y Dược TP.HCM');
  //     return doctor;
  //   } else if (id == 2) {
  //     doctor = DoctorModel.fullInfo(
  //         id: 1,
  //         name: 'Dr Jun',
  //         speciality: 'Khoa Nội',
  //         year: 3,
  //         image:
  //             'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg',
  //         rating: 4,
  //         description: 'Chuyên điều trị các bệnh......',
  //         degree: 'Kỹ sư phần mềm',
  //         schoolStudy: 'ĐH Công nghệ thông tin');
  //     return doctor;
  //   }
  //   return doctor;
  // }
}
