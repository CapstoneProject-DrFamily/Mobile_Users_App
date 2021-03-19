import 'package:drFamily_app/model/dependent_model.dart';
import 'package:drFamily_app/repository/patient_repo.dart';
import 'package:drFamily_app/screens/landing_page/add_dependent_profile_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUpChoosePatientViewModel extends BaseModel {
  final IPatientRepo _patientRepo = PatientRepo();

  List<DependentModel> _listDependent = [];
  List<DependentModel> get listDependent => _listDependent;

  int _patientChoose = 0;
  int get patientChoose => _patientChoose;

  DependentModel _tempPatientChoose;
  DependentModel get tempPatientChoose => _tempPatientChoose;

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
    _tempPatientChoose = _listDependent[0];
    notifyListeners();
  }

  void choosePatient(int patient, DependentModel patientModel) {
    print('Patient Model: ${patientModel.patientID}');
    _patientChoose = patient;
    _tempPatientChoose = patientModel;
    notifyListeners();
  }

  void addPatient(
    BuildContext dialogContext,
  ) {
    Navigator.push(
      dialogContext,
      MaterialPageRoute(
        builder: (dialogContex) => AddDependentProfilePage(),
      ),
    ).then((value) async {
      await init();
    });
  }
}
