import 'package:drFamily_app/model/home/find_doctor/symptom_model.dart';
import 'package:drFamily_app/model/service_specialty_model.dart';
import 'package:drFamily_app/repository/service_repo.dart';
import 'package:drFamily_app/repository/symptom_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomScreenViewModel extends BaseModel {
  final ISymptomRepo _symptomRepo = SymptomRepo();
  final IServiceRepo _serviceRepo = ServiceRepo();

  List<SymtomModel> symptomsDisplay = [];

  List<SymptomModel> symptomsList = [];

  List<String> titleSymptom = [];

  List<String> _savedValue = [];
  List<String> get savedValue => _savedValue;

  bool initSymptom = true;

  int indexFather = 0;

  ServiceSpecialtyModel serviceModel;

  Future<void> initData(BaseTimeLineViewModel baseTimeLineViewModel) async {
    if (this.initSymptom) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      serviceModel = await _serviceRepo.getSymptomService();

      if (baseTimeLineViewModel.oldStep.isNotEmpty) {
        _savedValue = prefs.getStringList("usListSymptomID");
      }
      symptomsList = await _symptomRepo.getAllSymptom();
      if (symptomsList == null) {
        //error Page
      }

      bool first = true;
      SymtomModel symptom;
      String sympTitle;
      Map<int, String> sympName;
      for (int i = 0; i < symptomsList.length; i++) {
        if (titleSymptom.contains(symptomsList[i].symptomType)) {
          sympName.putIfAbsent(
              symptomsList[i].symptomId, () => symptomsList[i].symptomName);
          first = false;
        } else {
          if (first == true) {
            titleSymptom.add(symptomsList[i].symptomType);
            sympTitle = symptomsList[i].symptomType;
            sympName = {};
            sympName.putIfAbsent(
                symptomsList[i].symptomId, () => symptomsList[i].symptomName);
          } else {
            first = true;
            symptom =
                SymtomModel(headerValue: sympTitle, expandedValue: sympName);
            symptomsDisplay.add(symptom);
            titleSymptom.add(symptomsList[i].symptomType);
            sympTitle = symptomsList[i].symptomType;
            sympName = {};
            sympName.putIfAbsent(
                symptomsList[i].symptomId, () => symptomsList[i].symptomName);
          }
        }
      }
      symptom = SymtomModel(headerValue: sympTitle, expandedValue: sympName);
      symptomsDisplay.add(symptom);
      print(symptomsDisplay.length);
      var test = symptomsDisplay[0].expandedValue.values.toList()[2];
      print(test);

      this.initSymptom = false;
    }
  }

  void changeChecked(int value) {
    print(_savedValue);
    if (_savedValue.contains(value.toString()))
      _savedValue.remove(value.toString());
    else {
      if (_savedValue.length >= 10) {
        Fluttertoast.showToast(
          msg: "You have reach max 10 symptom",
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
        );
      } else {
        _savedValue.add(value.toString());
      }
    }
    notifyListeners();
  }

  void changeFatherSymptom(int index) {
    indexFather = index;
    notifyListeners();
  }

  void continuePage(
      BuildContext context, BaseTimeLineViewModel baseTimeLineViewModel) async {
    if (_savedValue.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please choose Symptoms",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER,
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("usServiceID", 1);
      prefs.setStringList("usListSymptomID", _savedValue);
      print(_savedValue);
      baseTimeLineViewModel.nextStep();
    }
  }
}
