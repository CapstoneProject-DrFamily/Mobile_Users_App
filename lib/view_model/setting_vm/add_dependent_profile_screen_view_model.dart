import 'dart:convert';

import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/model/sign_up/signup_model.dart';
import 'package:drFamily_app/repository/app_config_repo.dart';
import 'package:drFamily_app/repository/setting/dependent_repo.dart';
import 'package:drFamily_app/screens/map_choose_profile.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDependentProfileScreenViewModel extends BaseModel {
  IAppConfigRepo _appConfigRepo = AppConfigRepo();
  IDependentRepo _dependentRepo = DependentRepo();
  SignUpModel _signUpModel;

  // controller
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController _dobController = TextEditingController();
  TextEditingController get dobController => _dobController;
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController get relationshipController => _relationshipController;

  TextEditingController _locationChooseController = TextEditingController();
  TextEditingController get locationChooseController =>
      _locationChooseController;
  //listrealtion
  List<dynamic> _relationshipList = [];
  List<dynamic> get relationshipList => _relationshipList;

  //string value text field
  String _relationshipValue;
  String get relationshipValue => _relationshipValue;
  String _fullNameValue;
  String get fullNameValue => _fullNameValue;
  // String _phoneNumValue;
  // String get phoneNumValue => _phoneNumValue;

  Validate _fullName = Validate(null, null);
  // Validate _phone = Validate(null, null);
  Validate get fullName => _fullName;
  // Validate get phone => _phone;

  String location;
  String errorLocation;
  String dobadd;

  //Constructor
  AddDependentProfileScreenViewModel() {
    _fullNameController.addListener(() {
      _fullNameValue = _fullNameController.text;
      notifyListeners();
    });
    // _phoneController.addListener(() {
    //   _phoneNumValue = _phoneController.text;
    //   notifyListeners();
    // });
    _relationshipController.addListener(() {
      _relationshipValue = _relationshipController.text;
      notifyListeners();
    });
    init();
  }

  List _months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  //function choose DOB
  void changeDOB(DateTime datetime) {
    if (datetime.day < 10) {
      _dobController.text = "0" +
          datetime.day.toString() +
          '-' +
          _months[datetime.month - 1] +
          '-' +
          datetime.year.toString();
    } else {
      _dobController.text = datetime.day.toString() +
          '-' +
          _months[datetime.month - 1] +
          '-' +
          datetime.year.toString();
    }
    dobadd = datetime.year.toString() +
        "-" +
        _months[datetime.month - 1] +
        "-" +
        datetime.day.toString();
    notifyListeners();
  }

  void init() async {
    _relationshipList = await _appConfigRepo.appConfigListRelationShip();
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

  // void validatePhone(String value) {
  //   if (value == null || value.length < 10) {
  //     _phone = Validate(null, "Phone number must be 10 numbers.");
  //   } else {
  //     _phone = Validate(value, null);
  //   }
  //   notifyListeners();
  // }

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

    // if (_phone.value == null) {
    //   validatePhone(null);
    //   _isReady = false;
    // }

    if (location == null) {
      errorLocation = "Please Choose Location";
      _isReady = false;
    }

    print(_isReady);

    bool check;
    if (_isReady == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int accountID = prefs.getInt("usAccountID");
      print("_isReady " + _isReady.toString());
      _signUpModel = new SignUpModel(
        fullName: _fullNameController.text,
        dob: dobadd,
        gender: null,
        image: null,
        email: null,
        idCard: null,
        height: null,
        weight: null,
        bloodType: null,
        location: location,
        relationship: _relationshipController.text,
        accountID: accountID,
      );

      String createPatientJson = jsonEncode(_signUpModel.toJson());
      print(createPatientJson + "\n");

      // check = await _dependentRepo.createDependentProfile(addProfileJson);
      check = await _dependentRepo.createPatient(createPatientJson);

      // if (check == true)
      //   check =
      //       await _dependentRepo.createPatient(createPatientJson);

      if (check == true) check = await _dependentRepo.createHealthRecord();
    } else {
      return false;
    }

    return check;
  }

  void chooseMapLocation(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapChooseProfileScreen(),
      ),
    ).then((value) {
      print("value $value");
      if (value != null) {
        location = value;

        _locationChooseController.text =
            value.toString().split(";")[1].trim().split(":")[1].trim();
        notifyListeners();
      }
    });
  }
}
