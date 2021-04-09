import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/waiting_booking_doctor_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _fbId;

  DatabaseReference _doctorRequest;

  DoctorDetailViewModel();

  Future<void> getDoctorDetail(int doctorId, String token, String fbID) async {
    _doctor = await _doctorRepo.getDoctor(doctorId);
    _fbId = fbID;
    _tokenNotiDoctor = token;
    print('notiToken: $_tokenNotiDoctor - fbId: $fbID');
  }

  Future<void> confirmBooking(
      BuildContext context, BaseTimeLineViewModel baseTimeLineViewModel) async {
    baseTimeLineViewModel.nextStep();
  }

  Future<String> newTransaction(
      SharedPreferences prefs, BuildContext context) async {
    waitDialog(
      context,
    );

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

    Navigator.pop(context);

    return transactionID;
  }

  Future<void> addTransactionToFb(
      String transactionId, String doctorFBId, String usNotitoken) async {
    await _doctorRequest
        .child(doctorFBId)
        .child("transaction")
        .child(transactionId)
        .set({"status": "waiting", "usNotiToken": usNotitoken});
  }
}

class SymptomTemp {
  final int id;
  SymptomTemp({this.id});

  Map<String, dynamic> toJson() => {
        "symptomId": this.id,
      };
}
