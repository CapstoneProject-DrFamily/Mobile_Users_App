import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';

class ProfileScreenViewModel extends BaseModel {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _identityNumberController = TextEditingController();
  TextEditingController _bloodTpeController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  String _dob = "";
  String _fullName = "";
  String _phoneNum = "";
  String _email = "";
  String _identityNum = "";
  String _bloodType = "";
  String _height = "";
  String _weight = "";

  int _gender = 0;
  List _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<String> listBloodType = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  String _weight1 = "";
  String listWeight = "";

  String _height2 = "";
  String listheight = "";

  //getter
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get dobController => _dobController;
  TextEditingController get phoneNumController => _phoneNumController;
  TextEditingController get emailController => _emailController;
  TextEditingController get identityNumberController =>
      _identityNumberController;
  TextEditingController get bloodTpeController => _bloodTpeController;
  TextEditingController get heightController => _heightController;
  TextEditingController get weightController => _weightController;

  String get fullName => _fullName;
  String get dob => _dob;
  String get phoneNum => _phoneNum;
  String get email => _email;
  String get identityNum => _identityNum;
  String get bloodType => _bloodType;
  String get height => _height;
  String get weight => _weight;

  int get gender => _gender;

  ProfileScreenViewModel() {
    //list for height
    for (int i = 0; i <= 99; i++) {
      if (i == 99)
        this._height2 += i.toString();
      else
        this._height2 += i.toString() + ',';
    }
    //list for weight
    for (int i = 1; i <= 299; i++) {
      if (i == 299)
        this._weight1 += i.toString();
      else
        this._weight1 += i.toString() + ',';
    }
    _fullNameController.addListener(() {
      _fullName = _fullNameController.text;
      notifyListeners();
    });
    _dobController.addListener(() {
      _dob = _dobController.text;
      notifyListeners();
    });
    _phoneNumController.addListener(() {
      _phoneNum = _phoneNumController.text;
      notifyListeners();
    });
    _emailController.addListener(() {
      _email = _emailController.text;
      notifyListeners();
    });
    _identityNumberController.addListener(() {
      _identityNum = _identityNumberController.text;
      notifyListeners();
    });
    _bloodTpeController.addListener(() {
      _bloodType = _bloodTpeController.text;
      notifyListeners();
    });
    _heightController.addListener(() {
      _height = _heightController.text;
      notifyListeners();
    });
    _weightController.addListener(() {
      _weight = _weightController.text;
      notifyListeners();
    });
    //init list weight
    this.listheight = '''
      [
          [
              1,
              2
          ],
          [
              "."
          ],
          [
              $_height2
          ],
          [
            "cm"
          ]
      ]
          ''';
    //init list height
    this.listWeight = '''
      [
          [
              $_weight1
          ],
          [
              "."
          ],
          [
              1,
              2,
              3,
              4,
              5,
              6,
              7,
              8,
              9
          ],
          [
            "kg"
          ]
      ]
          ''';
  }

  void changeGender(int gen) {
    print(gen);
    _gender = gen;
    notifyListeners();
  }

  void changeDOB(DateTime datetime) {
    _dobController.text = datetime.year.toString() +
        '-' +
        _months[datetime.month - 1] +
        '-' +
        datetime.day.toString();
    notifyListeners();
  }

  void changeBloodType(String type) {
    _bloodTpeController.text = type;
    notifyListeners();
  }

  void changeHeight(List<dynamic> value) {
    _heightController.text = value[0] + value[2] + value[3];
    _height = value[0] + value[2];
    notifyListeners();
  }

  void changeWeight(List<dynamic> value) {
    _weightController.text = value[0] + value[1] + value[2] + value[3];
    _weight = value[0] + value[2];
    notifyListeners();
  }
}
