import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseModel {
  int _patientID;
  int get patientID => _patientID;

  HomeViewModel() {
    print("init home model");
  }

  Future<void> choosePatient(int patientId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(patientId);
    _patientID = patientId;
    prefs.setInt("usPatientID", _patientID);
    notifyListeners();
  }

  Future<void> initTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usTransactionStatus", "init");
  }

  Future<void> bookingTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usTransactionStatus", "booking");
  }
}
