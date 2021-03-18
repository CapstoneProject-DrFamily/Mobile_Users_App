import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingBookingDoctorViewModel extends BaseModel {
  INotifyRepo _notifyRepo = NotifyRepo();

  String _tokenNotiDoctor;
  String _doctorFbId;

  DatabaseReference _doctorRequest;

  WaitingBookingDoctorViewModel() {
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");
  }

  Future<void> initWaitingScreen(String token, String doctorFbId) async {
    _tokenNotiDoctor = token;
    _doctorFbId = doctorFbId;
  }

  Future<void> cancelBooking(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usNotiToken = prefs.getString("usNotiToken");
    var transactionID = prefs.getString("usTransaction");
    await cancelTransactionOnFb(transactionID, _doctorFbId);

    print(
        'info: $usNotiToken transaciont: $transactionID doctor noti:$_tokenNotiDoctor');
    _notifyRepo.cancelBooking(_tokenNotiDoctor, transactionID, usNotiToken);

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
}
