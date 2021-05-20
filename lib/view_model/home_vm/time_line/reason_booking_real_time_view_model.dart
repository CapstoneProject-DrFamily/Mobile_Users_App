import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/waiting_booking_doctor_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonBookingRealTimeViewModel extends BaseModel {
  final INotifyRepo notifyRepo = NotifyRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();

  String note = "";

  bool isLoading = false;
  DatabaseReference _doctorRequest;

  SharedPreferences prefs;

  bool initReason = true;

  Future<void> init() async {
    if (initReason) {
      prefs = await SharedPreferences.getInstance();
      String noteHistory = prefs.getString("noteHistory");
      if (noteHistory != null) note = noteHistory;
      print("note $note");
      initReason = false;
    }
  }

  Future<void> bookingDoctor(
      int id, String token, String fbId, BuildContext context) async {
    bool isOnline = false;
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    await _doctorRequest.child(fbId).once().then(
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
      print("offline");
      // waitDialog(context, duration: Duration(milliseconds: 500));
      // Navigator.of(context).pop();

      await CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "This doctor is not online!",
          backgroundColor: Colors.lightBlue[200],
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
          });
    } else {
      print("online");

      waitDialog(context);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var usNotiToken = prefs.getString("usNotiToken");
      String transactionID;

      transactionID = await newTransaction(id, prefs, context);

      print(transactionID);

      await addTransactionToFb(transactionID, fbId, usNotiToken);

      Navigator.of(context).pop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WaitingBookingDoctorScreen(
            token: token,
            doctorFbId: fbId,
          ),
        ),
      );
      prefs.remove("noteHistory");

      await _notifyRepo.bookDoctor(token);
    }
  }

  Future<String> newTransaction(
    int doctorId,
    SharedPreferences prefs,
    BuildContext context,
  ) async {
    waitDialog(
      context,
    );

    var usServiceID = prefs.getInt("usServiceID");

    String transaction;

    var usPatientID = prefs.getInt("usPatientID");
    var usLocation = prefs.getString("usLocation");
    var doctorID = doctorId;

    transaction = jsonEncode({
      "doctorId": doctorID,
      "patientId": usPatientID,
      "status": 0,
      "location": usLocation,
      "note": note,
      "serviceId": usServiceID,
    });

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
