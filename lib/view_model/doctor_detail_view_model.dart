import 'package:drFamily_app/model/doctor.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class DoctorDetailViewModel extends BaseModel {
  Doctor doctor = new Doctor.fullInfo();

  DoctorDetailViewModel();

  Future<Doctor> loadDoctor(id) async {
    if (id == 1) {
      doctor = Doctor.fullInfo(
          id: 1,
          name: 'Dr Trần Anh Khoa',
          speciality: 'Khoa Nhi',
          year: 10,
          url:
              'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg',
          rating: 4,
          description:
              'Spending time at national parks can be an exciting adventure, but this wasnt the type of excitement she was hoping to experience.',
          degree: 'Bác sĩ Chuyên Khoa I',
          schoolStudy: 'ĐH Y Dược TP.HCM');
      return doctor;
    } else if (id == 2) {
      doctor = Doctor.fullInfo(
          id: 1,
          name: 'Dr Jun',
          speciality: 'Khoa Nội',
          year: 3,
          url:
              'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg',
          rating: 4,
          description: 'Chuyên điều trị các bệnh......',
          degree: 'Kỹ sư phần mềm',
          schoolStudy: 'ĐH Công nghệ thông tin');
      return doctor;
    }
    return doctor;
  }
}
