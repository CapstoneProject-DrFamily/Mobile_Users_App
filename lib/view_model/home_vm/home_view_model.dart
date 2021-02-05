import 'package:drFamily_app/screens/share/base_model.dart';

class HomeViewModel extends BaseModel {
  int _patientID;

  int get patientID => _patientID;

  void choosePatient(int patientId) {
    print(patientId);
    _patientID = patientId;
    notifyListeners();
  }
}
