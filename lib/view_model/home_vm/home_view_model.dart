import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseModel {
  ITransactionRepo _transactionRepo = TransactionRepo();
  int _patientID;
  int get patientID => _patientID;

  String _name = "user";
  String get name => _name;

  List<TransactionHistoryModel> _listDone = [];

  bool isHasCheck = false;
  bool bookingFunction = false;

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

  Future<void> choosePatient(int patientId, String patientName) async {
    isHasCheck = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(patientId);
    _patientID = patientId;
    prefs.setInt("usPatientID", _patientID);
    prefs.setString("usPatientName", patientName);

    _listDone = await _transactionRepo.getListTransactionHistory(
        patientId.toString(), 3);

    print("is done");

    if (_listDone != null) {
      isHasCheck = true;
    }

    notifyListeners();
  }

  Future<void> initTransaction(int typeFindDoctor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("chooseDoctorId");
    prefs.setString("usTransactionStatus", "init");
    prefs.setInt("typeFindDoctor", typeFindDoctor);
  }

  Future<void> bookingTransaction() async {
    this.bookingFunction = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usTransactionStatus", "booking");
  }
}
