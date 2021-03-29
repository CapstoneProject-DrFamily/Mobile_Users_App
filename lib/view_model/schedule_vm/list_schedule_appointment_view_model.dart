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
  bool init = true;

  String _fullUserName;
  String get fullUserName => _fullUserName;
  int _profileId;
  int _patientId;
  int _status = 0;
  int get status => _status;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  bool _isLoading = true;
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

      await scheduleRepo.getListScheduleByPatientId(patientId);
      init = false;
      notifyListeners();
    }
  }
}
