import 'package:drFamily_app/screens/share/base_model.dart';

class PopUpChoosePatientViewModel extends BaseModel {
  int _patientChoose = -1;

  int get patientChoose => _patientChoose;

  void choosePatient(int patient) {
    _patientChoose = patient;
    notifyListeners();
  }
}
