import 'package:drFamily_app/model/prescription_model.dart';
import 'package:drFamily_app/repository/prescription_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class TransactionPrescriptionViewModel extends BaseModel {
  bool init = true;
  List<PrescriptionModel> list;
  IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();

  fetchData(String transactionId) async {
    if (init) {
      list = await _prescriptionRepo.getPrescriptionDetail(transactionId);

      this.init = false;
      notifyListeners();
    }
  }
}
