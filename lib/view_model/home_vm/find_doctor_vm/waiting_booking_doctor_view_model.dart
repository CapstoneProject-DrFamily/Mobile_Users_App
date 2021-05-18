import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global_variable.dart';

class WaitingBookingDoctorViewModel extends BaseModel {
  static String screenStatus = "";
  static String doctorFBId = "";
  static String homeTransactionId = "";
  INotifyRepo _notifyRepo = NotifyRepo();

  String _tokenNotiDoctor;
  String _doctorFbId;
  String _transactionId;

  DatabaseReference _doctorRequest;

  WaitingBookingDoctorViewModel() {
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");
  }

  Future<void> initWaitingScreen(String token, String doctorFbId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenNotiDoctor = token;
    _doctorFbId = doctorFbId;
    _transactionId = prefs.getString("usTransaction");
    prefs.setString("doctorFBId", doctorFbId);

    liveCheckingTransaction();
  }

  Future<void> cancelBooking(BuildContext context) async {
    HelperMethod.disablUpdateDoctorTransaction();
    await cancelTransactionOnFb(_transactionId, _doctorFbId);

    print(' transacion: $_transactionId doctor noti:$_tokenNotiDoctor');
    _notifyRepo.cancelBooking(_tokenNotiDoctor);

    Navigator.pop(context);
  }

  Future<void> cancelTransactionOnFb(
      String transactionId, String doctorFBId) async {
    await _doctorRequest
        .child(doctorFBId)
        .child("transaction")
        .child(transactionId)
        .remove();
  }

  void liveCheckingTransaction() {
    print("in live");
    updateDoctorTransaction = _doctorRequest
        .child(_doctorFbId)
        .child("transaction")
        .child(_transactionId)
        .onChildChanged
        .listen(
      (event) {
        print(' status: ${event.snapshot.value}');
        if (event.snapshot.value == 'accept') {
          screenStatus = "Map Changing";
          homeTransactionId = _transactionId;
          doctorFBId = _doctorFbId;
          HelperMethod.disablUpdateDoctorTransaction();
          Get.offAll(LandingScreen());
        } else if (event.snapshot.value == 'offline') {
          HelperMethod.disablUpdateDoctorTransaction();
          Fluttertoast.showToast(
            msg: "Doctor has gone offline",
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER,
          );
          Get.back();
        } else if (event.snapshot.value == "notbook") {
          HelperMethod.disablUpdateDoctorTransaction();
          Fluttertoast.showToast(
            msg: "Doctor has cancel your booking",
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER,
          );
          Get.back();
        } else {
          HelperMethod.disablUpdateDoctorTransaction();
          Fluttertoast.showToast(
            msg: "Doctor have already been booked",
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER,
          );
          Get.back();
        }
      },
    );
  }
}
