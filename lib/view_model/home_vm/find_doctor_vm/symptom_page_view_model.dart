import 'package:drFamily_app/model/home/find_doctor/symptom_model.dart';
import 'package:drFamily_app/repository/symptom_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/map_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomePageViewModel extends BaseModel {
  final ISymptomRepo _symptomRepo = SymptomRepo();

  List<SymtomModel> symptomsDisplay = [];

  List<SymptomModel> symptomsList = [];

  List<String> titleSymptom = [];

  List<String> _savedValue = [];
  List<String> get savedValue => _savedValue;

  bool _checked = false;
  bool get checked => _checked;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  SymptomePageViewModel() {
    init();
  }

  Future<void> init() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();

    symptomsList = await _symptomRepo.getAllSymptom();
    if (symptomsList == null) {
      _isLoading = false;

      _isNotHave = true;
      notifyListeners();
      return;
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

    _isLoading = false;
    notifyListeners();
  }

  void changeChecked(int value) {
    print(_savedValue);
    if (_savedValue.contains(value.toString()))
      _savedValue.remove(value.toString());
    else
      _savedValue.add(value.toString());
    notifyListeners();
  }

  void continuePage(BuildContext context) async {
    if (_savedValue.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please choose Symptoms",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("usServiceID", 1);
      prefs.setStringList("usListSymptomID", _savedValue);
      print(_savedValue);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(),
        ),
      );
    }
  }
}
