import 'dart:ffi';

import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseModel {
  int _patientID;
  int get patientID => _patientID;

  HomeViewModel() {
    print("init home model");
  }

  void choosePatient(int patientId) {
    print(patientId);
    _patientID = patientId;
    notifyListeners();
  }
}
