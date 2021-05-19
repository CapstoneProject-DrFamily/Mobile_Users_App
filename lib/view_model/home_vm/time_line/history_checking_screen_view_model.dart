import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCheckingScreenViewModel extends BaseModel {
  ITransactionRepo _transactionRepo = TransactionRepo();
  bool initHistoryChecking = true;

  int chooseIndex = 0;

  List<TransactionHistoryModel> _listTransaction = [];
  List<TransactionHistoryModel> get listTransaction => _listTransaction;

  SharedPreferences prefs;

  int patientId;

  Future<void> initData() async {
    if (this.initHistoryChecking) {
      prefs = await SharedPreferences.getInstance();

      patientId = prefs.getInt("usPatientID");
      _listTransaction = await getListDoneChecking(patientId);
      this.initHistoryChecking = false;
    }
  }

  Future<List<TransactionHistoryModel>> getListDoneChecking(
      int patientId) async {
    List<TransactionHistoryModel> listTransaction = await _transactionRepo
        .getListTransactionHistory(patientId.toString(), 3);

    print("length ${listTransaction.length}");

    return listTransaction;
  }

  void changeSpecialty(int index) {
    chooseIndex = index;
    notifyListeners();
  }
}
