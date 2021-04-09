import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/patient_schedule_model/patient_schedule_model.dart';
import 'package:drFamily_app/repository/schedule_repo.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScheduleAppointmentViewModel extends BaseModel {
  final IProfileRepo profileRepo = ProfileRepo();
  final ITransactionRepo transactionRepo = TransactionRepo();
  final IScheduleRepo scheduleRepo = ScheduleRepo();
  List<PatientScheduleModel> list = [];
  bool init = true;

  Map<String, List<PatientScheduleModel>> schedules =
      Map<String, List<PatientScheduleModel>>();

  String _fullUserName;
  String get fullUserName => _fullUserName;
  int _profileId;
  int _patientId;
  int _status = 0;
  int get status => _status;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  void changePatients(
      BuildContext context, int profileId, String fullName) async {
    _status = 0;
    _isLoading = true;
    _isNotHave = false;
    Navigator.pop(context);
    notifyListeners();
    _fullUserName = fullName;
    _profileId = profileId;
    _patientId = await profileRepo.getPatientId(_profileId.toString());

    list = await scheduleRepo.getListScheduleByPatientIdUpComing(_patientId);

    this.schedules = Map<String, List<PatientScheduleModel>>();

    for (int i = 1; i < list.length; i++) {
      convert(list[i]);
    }

    // _listTransaction = await transactionRepo.getListTransactionHistory(
    //     _patientId.toString(), -1);

    // if (_listTransaction == null) {
    //   _isNotHave = true;
    // }

    _isLoading = false;
    _isFirst = false;
    notifyListeners();
  }

  Future<void> fetchData() async {
    if (init) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int patientId = prefs.getInt('usPatientID');

      // int patientId = 30;

      list = await scheduleRepo.getListScheduleByPatientIdUpComing(patientId);

      for (int i = 1; i < list.length; i++) {
        convert(list[i]);
      }

      init = false;
      notifyListeners();
    }
  }

  void convert(PatientScheduleModel model) {
    String appointmentDay = model.schedule.appointmentTime.substring(0, 10);

    if (!schedules.containsKey(appointmentDay)) {
      List<PatientScheduleModel> listItem = [];
      listItem.add(model);
      schedules[appointmentDay] = listItem;
    } else {
      List<PatientScheduleModel> listTemp = schedules[appointmentDay];
      listTemp.add(model);
      schedules[appointmentDay] = listTemp;
    }
  }
}
