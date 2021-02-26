import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingBookingDoctorViewModel extends BaseModel {
  INotifyRepo _notifyRepo = NotifyRepo();

  String _tokenNotiDoctor;

  Future<void> getDoctorToken(String token) async {
    _tokenNotiDoctor = token;
  }

  Future<void> cancelBooking(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usNotiToken = prefs.getString("usNotiToken");
    var transactionID = prefs.getString("usTransaction");
    print(
        'info: $usNotiToken transaciont: $transactionID doctor noti:$_tokenNotiDoctor');
    _notifyRepo.cancelBooking(_tokenNotiDoctor, transactionID, usNotiToken);

    Navigator.pop(context);
  }
}
