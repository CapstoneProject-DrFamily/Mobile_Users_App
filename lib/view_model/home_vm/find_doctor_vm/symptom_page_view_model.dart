import 'package:drFamily_app/model/symptom_model.dart';
import 'package:drFamily_app/screens/home/find_doctor/map_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';

class SymptomePageViewModel extends BaseModel {
  List<SymptomModel> symtoms = [
    SymptomModel(headerValue: 'General Symtoms', expandedValue: [
      'Dificulty Sleeping',
      'Fatigue / weakness',
      'Fever',
      'Night sweats'
    ]),
    SymptomModel(headerValue: 'Head / Neck', expandedValue: [
      'Congestion / sinus problem',
      'Difficulty / pain swallowing',
      'Ear drainage',
      'Ear pain',
    ])
  ];

  List<String> _savedValue = [];

  List<String> get savedValue => _savedValue;

  bool _checked = false;

  bool get checked => _checked;

  // List<SymptomModel> get symtoms => _symtoms;

  void changeChecked(String value) {
    if (_savedValue.contains(value))
      _savedValue.remove(value);
    else
      _savedValue.add(value);
    notifyListeners();
  }

  void continuePage(BuildContext context) {
    print(_savedValue);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );
  }
}
