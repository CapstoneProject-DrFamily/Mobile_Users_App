import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/screens/map_choose_profile.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:drFamily_app/model/setting/addition_info_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependentProfileViewModel extends BaseModel {
  final IProfileRepo _profileRepo = ProfileRepo();
  ProfileModel _profileModel;
  AdditionInfoModel _additionInfoModel;

  int dependentPatientID, patientID, recordId, accountId;
  String relationship;

  File _image;
  File get image => _image;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  String _height = "";
  String _weight = "";
  String _currentImage = DEFAULT_IMG;
  String _selectGender;
  String location = "";
  String dob;

  Validate _fullName = Validate(null, null);
  Validate _email = Validate(null, null);
  Validate _idCard = Validate(null, null);

  int _gender = 0;
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
  TextEditingController get idCardController => _idCardController;
  TextEditingController get bloodTypeController => _bloodTypeController;
  TextEditingController get heightController => _heightController;
  TextEditingController get weightController => _weightController;
  TextEditingController get locationController => _locationController;

  String get currentImage => _currentImage;
  String get height => _height;
  String get weight => _weight;
  String get selectGender => _selectGender;

  Validate get fullName => _fullName;
  Validate get email => _email;
  Validate get idCard => _idCard;

  int get gender => _gender;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _check;
  bool get check => _check;

  DependentProfileViewModel() {
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
    _fullNameController.addListener(() {
      _fullName = Validate(_fullNameController.text, null);
      notifyListeners();
    });
    _idCardController.addListener(() {
      _idCard = Validate(_idCardController.text, null);
      notifyListeners();
    });
    _emailController.addListener(() {
      _email = Validate(_emailController.text, null);
      notifyListeners();
    });
    getDependentProfile();
  }

  void getDependentProfile() async {
    this._isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dependentPatientID = prefs.getInt("dependentPatientID");
    accountId = prefs.getInt("usAccountID");

    //Get user profile
    _profileModel =
        await _profileRepo.getBasicInfo(dependentPatientID.toString());
    fullNameController.text = _profileModel.fullName;

    DateTime date =
        DateTime.parse(_profileModel.dob == null ? "" : _profileModel.dob);
    changeDOB(date);

    if (_profileModel.gender == "Male") {
      changeGender(0);
    } else if (_profileModel.gender == "Female") {
      changeGender(1);
    } else {
      changeGender(2);
    }

    // phoneNumController.text = _profileModel.phone;

    if (_profileModel.image != null) {
      _currentImage = _profileModel.image;
    }

    emailController.text = _profileModel.email;
    idCardController.text = _profileModel.idCard;

    //Get user additional infomation
    _additionInfoModel = _profileModel.additionInfoModel;

    patientID = _additionInfoModel.patientId;
    relationship = _additionInfoModel.relationship;

    _bloodTypeController.text = _additionInfoModel.bloodType;

    // int convertHeight = _additionInfoModel.height.toInt();
    // _heightController.text = convertHeight.toString();
    _heightController.text = _additionInfoModel.height.toString() == "null"
        ? ""
        : _additionInfoModel.height.toString();

    _weightController.text = _additionInfoModel.weight.toString() == "null"
        ? ""
        : _additionInfoModel.weight.toString();

    if (_additionInfoModel.location == null ||
        _additionInfoModel.location == "") {
      _locationController.text = "Not choose yet";
    } else {
      location = _additionInfoModel.location;
      _locationController.text = _additionInfoModel.location
          .toString()
          .split(";")[1]
          .trim()
          .split(":")[1]
          .trim();
    }

    this._isLoading = false;
    notifyListeners();
  }

  void changeGender(int gen) {
    print(gen);
    _gender = gen;
    if (_gender == 0) {
      _selectGender = "Male";
    } else if (_gender == 1) {
      _selectGender = "Female";
    } else {
      _selectGender = "Other";
    }
    notifyListeners();
  }

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
    dob = datetime.year.toString() +
        "-" +
        _months[datetime.month - 1] +
        "-" +
        datetime.day.toString();
    notifyListeners();
  }

  void changeBloodType(String type) {
    _bloodTypeController.text = type;
    notifyListeners();
  }

  void changeHeight(List<dynamic> value) {
    _heightController.text = value[0] + value[1] + value[2];
    _height = value[0] + value[1] + value[2];
    notifyListeners();
  }

  void changeWeight(List<dynamic> value) {
    _weightController.text = value[0] + value[1] + value[2] + value[3];
    _weight = value[0] + value[1] + value[2] + value[3];
    notifyListeners();
  }

  Future getUserImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    notifyListeners();
  }

  Future<String> upLoadImage() async {
    String basename = path.basename(_image.path);
    // StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageReference reference =
        FirebaseStorage.instance.ref().child("UserStorage/" + basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  void checkFullName(String fullName) {
    print(fullName);
    if (fullName == null || fullName.length == 0) {
      _fullName = Validate(null, "Fullname can't be blank");
    } else {
      _fullName = Validate(fullName, null);
    }
    notifyListeners();
  }

  void checkIDCard(String idCard) {
    print(idCard);
    if (idCard == null || idCard.length == 0) {
      _idCard = Validate(null, "ID Card can't be blank");
    } else {
      _idCard = Validate(idCard, null);
    }
    notifyListeners();
  }

  void checkEmail(String email) {
    String check = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(check);
    if (email == null || email.length == 0) {
      _email = Validate(null, "Email can't be blank");
    } else if (!regExp.hasMatch(email)) {
      _email = Validate(null, "Invalid Email!");
    } else {
      _email = Validate(email, null);
    }
    notifyListeners();
  }

  bool _isReady;
  bool get isReady => _isReady;

  String _error;
  String get error => _error;

  Future<bool> updateInformation() async {
    _isReady = true;

    if (_fullName.value == null || _fullName.value == "") {
      checkFullName(null);
      _isReady = false;
    }

    if (_idCard.value == null || _idCard.value == "") {
      checkIDCard(null);
      _isReady = false;
    }

    if (_email.value == null || _email.value == "") {
      checkEmail(null);
      _isReady = false;
    }

    print('isReady: $_isReady');

    bool check = false;
    if (_isReady == true) {
      String uploadImage;

      if (_image != null) {
        var url = await upLoadImage();
        uploadImage = url.toString();
      } else {
        uploadImage = currentImage;
      }

      var jsonDependentProfileUpdate = {
        "id": dependentPatientID,
        "fullname": fullNameController.text,
        "birthday": dob,
        "image": uploadImage,
        "idCard": idCardController.text,
        "email": emailController.text,
        "gender": selectGender,
        "location": location,
        "relationship": relationship,
        "height": height,
        "weight": weight,
        "bloodType": bloodTypeController.text,
        "accountId": accountId,
      };

      print("jsonUpdate $jsonDependentProfileUpdate");

      check = await _profileRepo
          .updateDependentInfo(jsonEncode(jsonDependentProfileUpdate));

      // _profileModel = new ProfileModel(
      //     profileId: dependentPatientID,
      //     fullName: fullNameController.text,
      //     dob: dobController.text,
      //     gender: selectGender,
      //     image: uploadImage,
      //     email: emailController.text,
      //     idCard: idCardController.text,
      //     accountID: accountId);

      // String updateBasicInfoJson = jsonEncode(_profileModel.toJson());
      // print(updateBasicInfoJson + "\n");

      // check = await _profileRepo.updateBasicInfo(updateBasicInfoJson);

      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // print("height: " + height);
      // print("weight: " + weight);

      // _additionInfoModel = new AdditionInfoModel(
      //   patientId: patientID,
      //   bloodType: _bloodTypeController.text,
      //   height: (_heightController.text == "")
      //       ? 0
      //       : double.parse(_heightController.text),
      //   weight: (_weightController.text == "")
      //       ? 0
      //       : double.parse(_weightController.text),
      //   updBy: prefs.getString("usFullName"),
      //   updDatetime: DateTime.now().toString(),
      //   relationship: relationship,
      //   location: location,
      // );

      // String updateAdditionInfoJson = jsonEncode(_additionInfoModel.toJson());
      // print("updateAdditionInfoJson: " + updateAdditionInfoJson);

      // check = await _profileRepo.updateAdditionInfo(updateAdditionInfoJson);
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

        _locationController.text =
            value.toString().split(";")[1].trim().split(":")[1].trim();
        notifyListeners();
      }
    });
  }
}
