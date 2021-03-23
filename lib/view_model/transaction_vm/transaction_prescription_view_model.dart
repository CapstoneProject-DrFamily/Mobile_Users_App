import 'package:drFamily_app/model/prescription_model.dart';
import 'package:drFamily_app/repository/prescription_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class TransactionPrescriptionViewModel extends BaseModel {
  bool init = true;
  List<PrescriptionModel> list;
  IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();
  String description;

  fetchData(String transactionId) async {
    if (init) {
      List<dynamic> result =
          await _prescriptionRepo.getPrescriptionDetail(transactionId);
      list = result[0];
      description = result[1];
      print(description);

      this.init = false;
      notifyListeners();
    }
  }
}
