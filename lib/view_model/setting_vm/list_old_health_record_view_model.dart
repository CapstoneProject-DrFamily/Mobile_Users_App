import 'package:drFamily_app/model/setting/health_record_model.dart';
import 'package:drFamily_app/repository/setting/health_record_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class ListOldHealthRecordViewModel extends BaseModel {
  final IHealthRecordRepo _healthRecordRepo = HealthRecordRepo();
  HealthRecordModel _healthRecordModel;
  int patientID, healthRecordID;

  List<HealthRecordModel> _listOldHealthRecord = [];
  List<HealthRecordModel> get listOldHealthRecord => _listOldHealthRecord;

  bool init = true;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getListOldPersonalHealthRecord(int patientID) async {
    if (init) {
      this.patientID = patientID;
      _listOldHealthRecord =
          await _healthRecordRepo.getListOldHealthRecord(patientID, true);
      this.init = false;
      _isLoading = false;
      notifyListeners();
    }
  }
}
