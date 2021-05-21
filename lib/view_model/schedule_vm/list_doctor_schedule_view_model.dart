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
  int status = 0;
  List tab = ['All doctor', 'Old doctor', 'Most booked'];

  Future<void> fetchData(int specialityId) async {
    if (init) {
      listResult = [];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("specialityId $specialityId");
      int patientid = prefs.getInt('usPatientID');
      int accountId = prefs.getInt('usAccountID');
      var isDefault = prefs.getBool("isServiceDefault");
      int doctorDefaultId = prefs.getInt("chooseDoctorId");

      print("accountId $accountId $isDefault $doctorDefaultId");

      print("patientID : " +
          patientid.toString() +
          "isDefaultService" +
          isDefault.toString());

      switch (status) {
        case 0:
          if (isDefault) {
            this.listResult = await _doctorRepo.getDoctorsBySpeciality(-1);

            Comparator<DoctorScheduleModel> timeComparator = (a, b) => a
                .schedules[0].appointmentTime
                .compareTo(b.schedules[0].appointmentTime);

            this.listResult.sort(timeComparator);
          } else {
            this.listResult =
                await _doctorRepo.getDoctorsBySpeciality(specialityId);

            Comparator<DoctorScheduleModel> timeComparator = (a, b) => a
                .schedules[0].appointmentTime
                .compareTo(b.schedules[0].appointmentTime);
            this.listResult.sort(timeComparator);
          }

          break;
        case 1:
          print("account ID : $accountId");
          if (isDefault) {
            this.listResult = await _doctorRepo.getListOldBookAppointment(
                accountId, 1, 99, -1);
            sortHistoryFirst(doctorDefaultId);
          } else {
            this.listResult = await _doctorRepo.getListOldBookAppointment(
                accountId, 1, 99, specialityId);
            sortHistoryFirst(doctorDefaultId);
          }
          break;
        case 2:
          if (isDefault) {
            this.listResult = await _doctorRepo.getDoctorsBySpeciality(-1);

            Comparator<DoctorScheduleModel> booked = (a, b) => a
                .doctorDetail.transactionBooked
                .compareTo(b.doctorDetail.transactionBooked);

            this.listResult.sort(booked);
            this.listResult = this.listResult.reversed.toList();
          } else {
            this.listResult =
                await _doctorRepo.getDoctorsBySpeciality(specialityId);

            Comparator<DoctorScheduleModel> booked = (a, b) => a
                .doctorDetail.transactionBooked
                .compareTo(b.doctorDetail.transactionBooked);

            this.listResult.sort(booked);
            this.listResult = this.listResult.reversed.toList();
          }
          break;
        default:
      }
      print(this.listResult.length);

      notifyListeners();
      this.init = false;
    }
  }

  void sortHistoryFirst(int doctorDefaultId) {
    if (doctorDefaultId != null) {
      DoctorScheduleModel doctormodel = this.listResult.firstWhere(
          (element) => element.doctorDetail.doctorId == doctorDefaultId);
      this.listResult.removeWhere(
          (element) => element.doctorDetail.doctorId == doctorDefaultId);
      this.listResult.insert(0, doctormodel);
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

  void changeStatus(int index) {
    this.status = index;
    this.init = true;
    notifyListeners();
  }
}
