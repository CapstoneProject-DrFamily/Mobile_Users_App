import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class HistoryCheckingScreenViewModel extends BaseModel {
  bool initHistoryChecking = true;

  int chooseIndex = 0;

    List<TransactionHistoryModel> _listTransaction = [];
  List<TransactionHistoryModel> get listTransaction => _listTransaction;

  Future<void> initData() async {
    if (this.initHistoryChecking) {
      this.initHistoryChecking = false;
    }
  }

  Future<List<TransactionHistoryModel>> getListDoneChecking(int patientId) {
    
  }

  void changeSpecialty(int index) {
    chooseIndex = index;
    notifyListeners();
  }
}
