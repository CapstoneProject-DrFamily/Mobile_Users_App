import 'dart:convert';

import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/model/sign_up/signup_model.dart';
import 'package:drFamily_app/repository/setting/dependent_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDependentProfileScreenViewModel extends BaseModel {
  IDependentRepo _dependentRepo = DependentRepo();
  SignUpModel _signUpModel;

  // controller
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController get relationshipController => _relationshipController;
  //listrealtion
  List<String> _relationshipList = [
    'Father',
    'Mother',
    'Grandmother',
    'Grandfather',
    'Sister',
    'Brother',
    'Child',
  ];
  List<String> get relationshipList => _relationshipList;

  //string value text field
  String _relationshipValue;
  String get relationshipValue => _relationshipValue;
  String _fullNameValue;
  String get fullNameValue => _fullNameValue;
  String _phoneNumValue;
  String get phoneNumValue => _phoneNumValue;

  Validate _fullName = Validate(null, null);
  Validate _phone = Validate(null, null);
  Validate get fullName => _fullName;
  Validate get phone => _phone;

  //Constructor
  AddDependentProfileScreenViewModel() {
    _fullNameController.addListener(() {
      _fullNameValue = _fullNameController.text;
      notifyListeners();
    });
    _phoneController.addListener(() {
      _phoneNumValue = _phoneController.text;
      notifyListeners();
    });
    _relationshipController.addListener(() {
      _relationshipValue = _relationshipController.text;
      notifyListeners();
    });
  }
  //function choose relationship
  void chooseRelationship(String newValue) {
    _relationshipController.text = newValue;
    notifyListeners();
  }

  void validateFullname(String value) {
    if (value == null || value.length == 0) {
      _fullName = Validate(null, "Full name can't be blank.");
    } else {
      _fullName = Validate(value, null);
    }
    notifyListeners();
  }

  void validatePhone(String value) {
    if (value == null || value.length < 10) {
      _phone = Validate(null, "Phone number must be 10 numbers.");
    } else {
      _phone = Validate(value, null);
    }
    notifyListeners();
  }

  void completeProcess() {
    // if (_error.value == null) {
    //   print("----Quantity---");
    //   print(_error.value);
    //   validateFullname(null);
    // }
  }

  bool _isReady;
  bool get isReady => _isReady;

  Future<bool> createDependent() async {
    _isReady = true;

    if (_fullName.value == null) {
      validateFullname(null);
      _isReady = false;
    }

    if (_phone.value == null) {
      validatePhone(null);
      _isReady = false;
    }

    bool check;
    if (_isReady == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int accountID = prefs.getInt("usAccountID");
      print("_isReady " + _isReady.toString());
      _signUpModel = new SignUpModel(
        fullName: _fullNameController.text,
        dob: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        gender: null,
        phone: _phoneController.text,
        image: null,
        email: null,
        idCard: null,
        accountID: accountID,
      );

      String addProfileJson = jsonEncode(_signUpModel.toJson());
      print(addProfileJson + "\n");

      check = await _dependentRepo.createDependentProfile(addProfileJson);

      if (check == true)
        check = await _dependentRepo.createPatient(_relationshipValue);

      if (check == true) check = await _dependentRepo.createHealthRecord();
    }

    return check;
  }
}
