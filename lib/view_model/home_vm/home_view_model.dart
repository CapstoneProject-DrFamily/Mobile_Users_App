import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseModel {
  int _patientID;
  int get patientID => _patientID;

  String _name = "user";
  String get name => _name;

  HomeViewModel() {
    init();
    print("init home model");
  }

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int profileId = prefs.getInt("usProfileID");
    String fullname = prefs.getString("usFullName");
    print("profileId $profileId");
    List fullnameSplit = fullname.split(" ");
    print("name " + fullnameSplit[fullnameSplit.length - 1].toString());
    _name = fullnameSplit[fullnameSplit.length - 1];
    notifyListeners();

    prefs.setInt("usPatientID", profileId);
  }

  Future<void> choosePatient(int patientId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(patientId);
    _patientID = patientId;
    prefs.setInt("usPatientID", _patientID);
    notifyListeners();
  }

  Future<void> initTransaction(int typeFindDoctor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usTransactionStatus", "init");
    prefs.setInt("typeFindDoctor", typeFindDoctor);
  }

  Future<void> bookingTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usTransactionStatus", "booking");
  }
}
