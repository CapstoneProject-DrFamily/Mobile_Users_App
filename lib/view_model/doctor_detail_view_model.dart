import 'dart:convert';

import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/waiting_booking_doctor_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<void> confirmBooking(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usTransactionStatus = prefs.getString("usTransactionStatus");
    var usNotiToken = prefs.getString("usNotiToken");
    String transactionID;
    print('transactionStatus $usTransactionStatus');

    if (usTransactionStatus.endsWith("waiting")) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WaitingBookingDoctorScreen(
                  token: _tokenNotiDoctor,
                )),
      );
      transactionID = prefs.getString("usTransaction");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WaitingBookingDoctorScreen(
                  token: _tokenNotiDoctor,
                )),
      );
      transactionID = await newTransaction(prefs);
    }

    print(transactionID);

    await _notifyRepo.bookDoctor(_tokenNotiDoctor, transactionID, usNotiToken);
  }

  Future<String> newTransaction(SharedPreferences prefs) async {
    prefs.setString("usTransactionStatus", "waiting");

    var usServiceID = prefs.getInt("usServiceID");

    String transaction;

    if (usServiceID == 1) {
      var usListSymptomID = prefs.getStringList("usListSymptomID");
      var usPatientID = prefs.getInt("usPatientID");
      var usLocation = prefs.getString("usLocation");
      var doctorID = _doctor.doctorId;

      List<SymptomTemp> listSymptom = [];

      for (var item in usListSymptomID) {
        listSymptom.add(SymptomTemp(id: int.parse(item)));
      }

      transaction = jsonEncode({
        "doctorId": doctorID,
        "patientId": usPatientID,
        "status": 0,
        "location": usLocation,
        "note": "Nothing",
        "serviceId": usServiceID,
        "symptomDetails": listSymptom,
      });
    } else {
      var usPatientID = prefs.getInt("usPatientID");
      var usLocation = prefs.getString("usLocation");
      var doctorID = _doctor.doctorId;

      transaction = jsonEncode({
        "doctorId": doctorID,
        "patientId": usPatientID,
        "status": 0,
        "location": usLocation,
        "note": "Nothing",
        "serviceId": usServiceID,
      });
    }

    print("transaction: " + transaction);

    String transactionID = await _transactionRepo.addTransaction(transaction);

    prefs.setString("usTransaction", transactionID);

    return transactionID;
  }
}

class SymptomTemp {
  final int id;
  SymptomTemp({this.id});

  Map<String, dynamic> toJson() => {
        "symptomId": this.id,
      };
}
