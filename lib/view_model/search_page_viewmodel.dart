import 'package:drFamily_app/model/doctor.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class SearchPageViewModel extends BaseModel {
  List<Doctor> listDoctor;

  Future<List<Doctor>> loadDoctor() async {
    Doctor doctor1 = new Doctor(
        id: 1,
        name: 'Dr Trần Anh Khoa',
        speciality: 'Khoa Nhi',
        year: 10,
        url:
            'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg');
    listDoctor.add(doctor1);

    Doctor doctor2 = new Doctor(
        id: 2,
        name: 'Dr Jun',
        speciality: 'Khoa Nội',
        year: 10,
        url:
            'https://taimuihongsg.com/wp-content/uploads/2018/05/Kim-Bun-ThuongE-01.jpg');
    listDoctor.add(doctor2);

    await Future.delayed(Duration(seconds: 1));

    return listDoctor;
  }
}
