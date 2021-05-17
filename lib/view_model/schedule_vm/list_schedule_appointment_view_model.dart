import 'dart:convert';
import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/model/patient_schedule_model/patient_schedule_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/patient_repo.dart';
import 'package:drFamily_app/repository/schedule_repo.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScheduleAppointmentViewModel extends BaseModel {
  final IProfileRepo profileRepo = ProfileRepo();
  final ITransactionRepo transactionRepo = TransactionRepo();
  final IScheduleRepo scheduleRepo = ScheduleRepo();
  final IPatientRepo patientRepo = PatientRepo();
  final IDoctorRepo doctorRepo = DoctorRepo();
  final INotifyRepo notifyRepo = NotifyRepo();

  List<PatientScheduleModel> list = [];

  bool init = true;

  String reasonCancel;

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
    // _patientId = await profileRepo.getPatientId(_profileId.toString());

    list = await scheduleRepo.getListScheduleByPatientIdUpComing(_profileId);

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

  Future<void> cancelBooking(
      BuildContext context,
      int scheduleId,
      String appointmentTime,
      String location,
      String note,
      int doctorId,
      String transactionID) async {
    // lấy noti token

    waitDialog(context, message: "Canceling booking please wait...");

    String notiToken = await doctorRepo.getNotiToken(doctorId);
    print(notiToken);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int patientId = prefs.getInt('usPatientID');

    String name = await patientRepo.getPatientName(patientId);

    String updateScheduleJson = jsonEncode({
      "scheduleId": scheduleId,
      "doctorId": doctorId,
      "appointmentTime": appointmentTime,
      "status": 0,
      "insBy": null,
      "updBy": name,
    });

    print('update Schedule $updateScheduleJson');

    bool isUpdateSchedule =
        await scheduleRepo.updateSchedules(updateScheduleJson);

    var transactionTemp = {
      'doctorId': doctorId,
      'location': location,
      'note': note,
      'patientId': patientId,
      'status': 4,
      'id': transactionID,
      'scheduleId': scheduleId,
      'estimatedTime': null,
      'reasonCancel': reasonCancel
    };

    print("UpdUserJson: " + jsonEncode(transactionTemp));

    bool isUpdateTransaction =
        await transactionRepo.updateTransaction(jsonEncode(transactionTemp));

    if (isUpdateSchedule && isUpdateTransaction) {
      // gọi API cancel noti
      // copy cái doc

      notifyRepo.cancelSchedule(notiToken, name, appointmentTime);

      print("oke udpate transaction");
      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Cancel booking Success!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );

      Navigator.pop(context);
      Navigator.pop(context);
      this.list = [];
      schedules = Map<String, List<PatientScheduleModel>>();
      init = true;
      notifyListeners();
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Sorry, something went wrong. Please try again",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future<void> fetchData() async {
    if (init) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _patientId = prefs.getInt('usPatientID');
      var userName = prefs.getString('usFullName');
      _fullUserName = userName;
      print(_patientId);

      // int patientId = 30;

      list = await scheduleRepo.getListScheduleByPatientIdUpComing(_patientId);

      for (int i = 1; i < list.length; i++) {
        convert(list[i]);
      }

      init = false;
      notifyListeners();
    }
  }

  Future<void> loadBackData() async {
    init = true;
    list = [];
    schedules = {};
    notifyListeners();
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
