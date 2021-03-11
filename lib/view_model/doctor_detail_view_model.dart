import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/waiting_booking_doctor_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
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

  Future<void> confirmBooking(BuildContext context) async {
    bool isOnline = false;
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    await _doctorRequest.child(_fbId).once().then(
      (DataSnapshot dataSnapshot) {
        if (dataSnapshot.value == null) {
          isOnline = false;
        } else {
          var status = dataSnapshot.value["doctor_status"];
          if (status == "waiting") {
            isOnline = true;
          } else {
            isOnline = false;
          }
        }
      },
    );

    if (!isOnline) {
      waitDialog(context, duration: Duration(milliseconds: 500));
      Fluttertoast.showToast(
        msg: "Doctor now is not online",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var usTransactionStatus = prefs.getString("usTransactionStatus");
      var usNotiToken = prefs.getString("usNotiToken");
      String transactionID;
      print('transactionStatus $usTransactionStatus');

      if (usTransactionStatus.endsWith("waiting")) {
        print("in waiting");

        waitDialog(
          context,
          duration: Duration(seconds: 1),
        );
        await Future.delayed(const Duration(seconds: 1));

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WaitingBookingDoctorScreen(
                    token: _tokenNotiDoctor,
                  )),
        );
        transactionID = prefs.getString("usTransaction");
      } else {
        print("in else");
        transactionID = await newTransaction(prefs, context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WaitingBookingDoctorScreen(
              token: _tokenNotiDoctor,
            ),
          ),
        );
      }

      print(transactionID);

      await _notifyRepo.bookDoctor(
          _tokenNotiDoctor, transactionID, usNotiToken);
    }
  }

  Future<String> newTransaction(
      SharedPreferences prefs, BuildContext context) async {
    waitDialog(
      context,
    );
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

    Navigator.pop(context);

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
