import 'dart:convert';

import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetailViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();

  INotifyRepo _notifyRepo = NotifyRepo();

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usServiceID = prefs.getInt("usServiceID");
    var usListSymptomID = prefs.getStringList("usListSymptomID");
    var usPatientID = prefs.getInt("usPatientID");
    var usLocation = prefs.getString("usLocation");
    var doctorID = _doctor.doctorId;

    List<SymptomTemp> listSymptom = [];

    for (var item in usListSymptomID) {
      listSymptom.add(SymptomTemp(id: int.parse(item)));
    }

    String transaction = jsonEncode({
      "doctorId": doctorID,
      "patientId": usPatientID,
      "status": 0,
      "location": usLocation,
      "note": "Nothing",
      "serviceId": usServiceID,
      "symptomDetails": listSymptom,
    });

    print("transaction: " + transaction);

    int transactionID = await _transactionRepo.addTransaction(transaction);

    print(transactionID);

    await _notifyRepo.bookDoctor(_tokenNotiDoctor, transactionID);
  }
}

class SymptomTemp {
  final int id;
  SymptomTemp({this.id});

  Map<String, dynamic> toJson() => {
        "symptomId": this.id,
      };
}
