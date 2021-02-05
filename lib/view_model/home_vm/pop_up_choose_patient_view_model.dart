import 'package:drFamily_app/model/dependent_model.dart';
import 'package:drFamily_app/repository/patient_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUpChoosePatientViewModel extends BaseModel {
  final IPatientRepo _patientRepo = PatientRepo();

  List<DependentModel> _listDependent = [];
  List<DependentModel> get listDependent => _listDependent;

  int _patientChoose = 0;
  int get patientChoose => _patientChoose;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PopUpChoosePatientViewModel() {
    init();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("usAccountID");
    _isLoading = true;
    notifyListeners();
    _listDependent = await _patientRepo.getDependent(userId).whenComplete(() {
      _isLoading = false;
    });
    notifyListeners();
  }

  void choosePatient(int patient) {
    _patientChoose = patient;
    notifyListeners();
  }
}
