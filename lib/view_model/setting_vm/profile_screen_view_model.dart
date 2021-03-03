import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:drFamily_app/model/setting/addition_info_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenViewModel extends BaseModel {
  final IProfileRepo _profileRepo = ProfileRepo();
  ProfileModel _profileModel;
  AdditionInfoModel _additionInfoModel;

  int profileID, patientID, recordId, accountId;
  String relationship;

  File _image;
  File get image => _image;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _bloodTpeController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  String _dob = "";
  String _fullName = "";
  String _phoneNum = "";
  String _currentImage = "";
  String _email = "";
  String _idCard = "";
  String _bloodType = "";
  String _height = "";
  String _weight = "";
  String _selectGender;

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
  TextEditingController get idCardController => _idCardController;
  TextEditingController get bloodTpeController => _bloodTpeController;
  TextEditingController get heightController => _heightController;
  TextEditingController get weightController => _weightController;

  String get fullName => _fullName;
  String get dob => _dob;
  String get phoneNum => _phoneNum;
  String get currentImage => _currentImage;
  String get email => _email;
  String get idCard => _idCard;
  String get bloodType => _bloodType;
  String get height => _height;
  String get weight => _weight;
  String get selectGender => _selectGender;

  int get gender => _gender;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _check;
  bool get check => _check;

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
    _idCardController.addListener(() {
      _idCard = _idCardController.text;
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
    getProfile();
  }

  void getProfile() async {
    this._isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    profileID = prefs.getInt("usProfileID");
    patientID = prefs.getInt("usPatientID");

    //Get user profile
    _profileModel = await _profileRepo.getBasicInfo(profileID.toString());
    fullNameController.text = _profileModel.fullName;

    DateTime date = DateTime.parse(_profileModel.dob);
    changeDOB(date);

    if (_profileModel.gender.trim() == "Male") {
      changeGender(0);
    } else if (_profileModel.gender.trim() == "Female") {
      changeGender(1);
    } else {
      changeGender(2);
    }

    phoneNumController.text = _profileModel.phone;
    _currentImage = _profileModel.image;
    emailController.text = _profileModel.email;
    idCardController.text = _profileModel.idCard;

    //Get user additional infomation
    _additionInfoModel =
        await _profileRepo.getAdditionInfo(patientID.toString());

    recordId = _additionInfoModel.recordId;
    relationship = _additionInfoModel.relationship;
    accountId = _additionInfoModel.accountId;

    _bloodTpeController.text = _additionInfoModel.bloodType;

    int convertHeight = _additionInfoModel.height.toInt();
    _heightController.text = convertHeight.toString() + "cm";

    _weightController.text = _additionInfoModel.weight.toString() + "kg";

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

  Future<bool> updateInformation() async {
    _check = true;
    if (_check = true) {
      String uploadImage;

      if (_image != null) {
        var url = await upLoadImage();
        uploadImage = url.toString();
      } else {
        uploadImage = currentImage;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("usFullName", fullNameController.text);
      prefs.setString("usImg", uploadImage);

      _profileModel = new ProfileModel(
          profileId: profileID,
          fullName: fullNameController.text,
          dob: dobController.text,
          gender: selectGender,
          phone: phoneNumController.text,
          image: uploadImage,
          email: emailController.text,
          idCard: idCardController.text);

      String updateBasicInfoJson = jsonEncode(_profileModel.toJson());
      print(updateBasicInfoJson + "\n");

      _check = await _profileRepo.updateBasicInfo(updateBasicInfoJson);

      if (_check == true) {
        print("height: " + height);
        print("weight: " + weight);

        _additionInfoModel = new AdditionInfoModel(
            patientId: patientID,
            height: double.parse(height.substring(0, 3)),
            weight: double.parse(weight.substring(0, 4)),
            bloodType: bloodTpeController.text,
            profileId: profileID,
            recordId: recordId,
            relationship: relationship,
            accountId: accountId);

        String updateAdditionInfoJson = jsonEncode(_additionInfoModel.toJson());
        print("updateAdditionInfoJson: " + "\n");

        _check = await _profileRepo.updateAdditionInfo(updateAdditionInfoJson);
      }
    }
    return check;
  }
}
