import 'package:drFamily_app/model/setting/health_record_model.dart';
import 'package:drFamily_app/repository/setting/health_record_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OldHealthRecordViewModel extends BaseModel {
  final IHealthRecordRepo _healthRecordRepo = HealthRecordRepo();
  HealthRecordModel _healthRecordModel;
  int patientID, healthRecordID;

  List<HealthRecordModel> _listOldHealthRecord = [];
  List<HealthRecordModel> get listOldHealthRecord => _listOldHealthRecord;

  bool init = true;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //Tab History & Allergy
  TextEditingController _conditionAtBirthController = TextEditingController();
  TextEditingController _birthWeightController = TextEditingController();
  TextEditingController _birthHeightController = TextEditingController();
  TextEditingController _birthDefectsController = TextEditingController();
  TextEditingController _otherDefectsController = TextEditingController();
  TextEditingController _medicineAllergyController = TextEditingController();
  TextEditingController _chemicalAllergyController = TextEditingController();
  TextEditingController _foodAllergyController = TextEditingController();
  TextEditingController _otherAllergyController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _cancerController = TextEditingController();
  TextEditingController _tuberculosisController = TextEditingController();
  TextEditingController _otherDiseasesController = TextEditingController();
  TextEditingController _hearingController = TextEditingController();
  TextEditingController _eyesightController = TextEditingController();
  TextEditingController _handController = TextEditingController();
  TextEditingController _legController = TextEditingController();
  TextEditingController _scoliosisController = TextEditingController();
  TextEditingController _cleftLipController = TextEditingController();
  TextEditingController _otherDisabilitiesController = TextEditingController();
  TextEditingController _surgeryHistoryController = TextEditingController();
  TextEditingController _medicineAllergyFamilyController =
      TextEditingController();
  TextEditingController _chemicalAllergyFamilyController =
      TextEditingController();
  TextEditingController _foodAllergyFamilyController = TextEditingController();
  TextEditingController _otherAllergyFamilyController = TextEditingController();
  TextEditingController _diseaseFamilyController = TextEditingController();
  TextEditingController _cancerFamilyController = TextEditingController();
  TextEditingController _tuberculosisFamilyController = TextEditingController();
  TextEditingController _otherDiseasesFamilyController =
      TextEditingController();
  TextEditingController _otherController = TextEditingController();
  TextEditingController _exposureElementController = TextEditingController();
  TextEditingController _contactTimeController = TextEditingController();
  TextEditingController _toiletTypeController = TextEditingController();
  TextEditingController _otherRisksController = TextEditingController();

  String _conditionAtBirth = "Spontaneous delivery";

  //Getter
  TextEditingController get conditionAtBirthController =>
      _conditionAtBirthController;
  TextEditingController get birthWeightController => _birthWeightController;
  TextEditingController get birthHeightController => _birthHeightController;
  TextEditingController get birthDefectsController => _birthDefectsController;
  TextEditingController get otherDefectsController => _otherDefectsController;
  TextEditingController get medicineAllergyController =>
      _medicineAllergyController;
  TextEditingController get chemicalAllergyController =>
      _chemicalAllergyController;
  TextEditingController get foodAllergyController => _foodAllergyController;
  TextEditingController get otherAllergyController => _otherAllergyController;
  TextEditingController get diseaseController => _diseaseController;
  TextEditingController get cancerController => _cancerController;
  TextEditingController get tuberculosisController => _tuberculosisController;
  TextEditingController get otherDiseasesController => _otherDiseasesController;
  TextEditingController get hearingController => _hearingController;
  TextEditingController get eyesightController => _eyesightController;
  TextEditingController get handController => _handController;
  TextEditingController get legController => _legController;
  TextEditingController get scoliosisController => _scoliosisController;
  TextEditingController get cleftLipController => _cleftLipController;
  TextEditingController get otherDisabilitiesController =>
      _otherDisabilitiesController;
  TextEditingController get surgeryHistoryController =>
      _surgeryHistoryController;
  TextEditingController get medicineAllergyFamilyController =>
      _medicineAllergyFamilyController;
  TextEditingController get chemicalAllergyFamilyController =>
      _chemicalAllergyFamilyController;
  TextEditingController get foodAllergyFamilyController =>
      _foodAllergyFamilyController;
  TextEditingController get otherAllergyFamilyController =>
      _otherAllergyFamilyController;
  TextEditingController get diseaseFamilyController => _diseaseFamilyController;
  TextEditingController get cancerFamilyController => _cancerFamilyController;
  TextEditingController get tuberculosisFamilyController =>
      _tuberculosisFamilyController;
  TextEditingController get otherDiseasesFamilyController =>
      _otherDiseasesFamilyController;
  TextEditingController get otherController => _otherController;
  TextEditingController get exposureElementController =>
      _exposureElementController;
  TextEditingController get contactTimeController => _contactTimeController;
  TextEditingController get toiletTypeController => _toiletTypeController;
  TextEditingController get otherRisksController => _otherRisksController;

  String get conditionAtBirth => _conditionAtBirth;
  //----------------------------------------------------------------------------

  //Tab Exposure
  int _choiceCigarette = 0;
  int _choiceWine = 0;
  int _choiceDrug = 0;
  int _choiceActivity = 0;

  String strCigarette;
  String strWine;
  String strDrug;
  String strActivity;

  int get choiceCigarette => _choiceCigarette;
  int get choiceWine => _choiceWine;
  int get choiceDrug => _choiceDrug;
  int get choiceActivity => _choiceActivity;
  //----------------------------------------

  Future<void> getListOldPersonalHealthRecord(int patientID) async {
    _isLoading = true;
    notifyListeners();
    if (init) {
      this.patientID = patientID;
      _listOldHealthRecord =
          await _healthRecordRepo.getListOldHealthRecord(patientID, true);
      this.init = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getPersonalHealthRecordByID(int healthRecordID) async {
    _isLoading = true;
    notifyListeners();
    if (init) {
      this.healthRecordID = healthRecordID;

      _healthRecordModel =
          await _healthRecordRepo.getHealthRecordByID(healthRecordID);

      _conditionAtBirthController.text = _healthRecordModel.conditionAtBirth;
      _conditionAtBirth = _conditionAtBirthController.text;

      _birthWeightController.text = _healthRecordModel.birthWeight.toString();
      if (_birthWeightController.text == "null" ||
          _birthWeightController.text == "0") {
        _birthWeightController.text = "";
      }
      _birthHeightController.text = _healthRecordModel.birthHeight.toString();
      if (_birthHeightController.text == "null" ||
          _birthHeightController.text == "0") {
        _birthHeightController.text = "";
      }
      _birthDefectsController.text = _healthRecordModel.birthDefects;
      _otherDefectsController.text = _healthRecordModel.otherDefects;
      _medicineAllergyController.text = _healthRecordModel.medicineAllergy;
      _chemicalAllergyController.text = _healthRecordModel.chemicalAllergy;
      _foodAllergyController.text = _healthRecordModel.foodAllergy;
      _otherAllergyController.text = _healthRecordModel.otherAllergy;
      _diseaseController.text = _healthRecordModel.disease;
      _cancerController.text = _healthRecordModel.cancer;
      _tuberculosisController.text = _healthRecordModel.tuberculosis;
      _otherDiseasesController.text = _healthRecordModel.otherDiseases;
      _hearingController.text = _healthRecordModel.hearing;
      _eyesightController.text = _healthRecordModel.eyesight;
      _handController.text = _healthRecordModel.hand;
      _legController.text = _healthRecordModel.leg;
      _scoliosisController.text = _healthRecordModel.scoliosis;
      _cleftLipController.text = _healthRecordModel.cleftLip;
      _otherDisabilitiesController.text = _healthRecordModel.otherDisabilities;
      _surgeryHistoryController.text = _healthRecordModel.surgeryHistory;
      _medicineAllergyFamilyController.text =
          _healthRecordModel.medicineAllergyFamily;
      _chemicalAllergyFamilyController.text =
          _healthRecordModel.chemicalAllergyFamily;
      _foodAllergyFamilyController.text = _healthRecordModel.foodAllergyFamily;
      _otherAllergyFamilyController.text =
          _healthRecordModel.otherAllergyFamily;
      _diseaseFamilyController.text = _healthRecordModel.diseaseFamily;
      _cancerFamilyController.text = _healthRecordModel.cancerFamily;
      _tuberculosisFamilyController.text =
          _healthRecordModel.tuberculosisFamily;
      _otherDiseasesFamilyController.text =
          _healthRecordModel.otherDiseasesFamily;
      _otherController.text = _healthRecordModel.other;

      if (_healthRecordModel.smokingFrequency == "No") {
        changeChoiceCigarette(0);
      } else if (_healthRecordModel.smokingFrequency == "Yes") {
        changeChoiceCigarette(1);
      } else if (_healthRecordModel.smokingFrequency == "Smoke often") {
        changeChoiceCigarette(2);
      } else {
        changeChoiceCigarette(3);
      }

      if (_healthRecordModel.drinkingFrequency == "Yes") {
        changeChoiceWine(0);
      } else if (_healthRecordModel.drinkingFrequency == "No") {
        changeChoiceWine(1);
      } else {
        changeChoiceWine(2);
      }

      if (_healthRecordModel.drugFrequency == "No") {
        changeChoiceDrug(0);
      } else if (_healthRecordModel.drugFrequency == "Yes") {
        changeChoiceDrug(1);
      } else if (_healthRecordModel.drugFrequency == "Usually use") {
        changeChoiceDrug(2);
      } else {
        changeChoiceDrug(3);
      }

      if (_healthRecordModel.activityFrequency == "No") {
        changeChoiceActivity(0);
      } else if (_healthRecordModel.activityFrequency == "Yes") {
        changeChoiceActivity(1);
      } else {
        changeChoiceActivity(2);
      }

      _exposureElementController.text = _healthRecordModel.exposureElement;
      _contactTimeController.text = _healthRecordModel.contactTime;
      _toiletTypeController.text = _healthRecordModel.toiletType;
      _otherRisksController.text = _healthRecordModel.otherRisks;
      this.init = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeConditionAtBirth(String newChoice) {
    _conditionAtBirthController.text = newChoice;
  }

  void changeChoiceCigarette(int newChoice) {
    _choiceCigarette = newChoice;
    if (_choiceCigarette == 0)
      strCigarette = "No";
    else if (_choiceCigarette == 1)
      strCigarette = "Yes";
    else if (_choiceCigarette == 2)
      strCigarette = "Smoke often";
    else
      strCigarette = "Quit";
  }

  void changeChoiceWine(int newChoice) {
    _choiceWine = newChoice;
    if (_choiceWine == 0)
      strWine = "Yes";
    else if (_choiceWine == 1)
      strWine = "No";
    else
      strWine = "Quit";
  }

  void changeChoiceDrug(int newChoice) {
    _choiceDrug = newChoice;
    if (_choiceDrug == 0)
      strDrug = "No";
    else if (_choiceDrug == 1)
      strDrug = "Yes";
    else if (_choiceDrug == 2)
      strDrug = "Usually use";
    else
      strDrug = "Quit";
  }

  void changeChoiceActivity(int newChoice) {
    _choiceActivity = newChoice;
    if (_choiceActivity == 0)
      strActivity = "No";
    else if (_choiceActivity == 1)
      strActivity = "Yes";
    else
      strActivity = "Regularly";
  }
}
