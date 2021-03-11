import 'dart:convert';
import 'dart:io';
import 'package:commons/commons.dart';
import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/model/sign_up/signup_model.dart';
import 'package:drFamily_app/repository/sign_up/sign_up_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends BaseModel {
  ISignUpRepo _signUpRepo = SignUpRepo();
  SignUpModel _signUpModel;
  String phone;

  //TextEditingController
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get dobController => _dobController;
  TextEditingController get genderController => _genderController;
  TextEditingController get emailController => _emailController;
  TextEditingController get idCardController => _idCardController;

  List<String> _genderList = [
    'Male',
    'Female',
    'Other',
  ];
  List<String> get genderList => _genderList;

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

  Validate _fullName = Validate(null, null);
  Validate _email = Validate(null, null);
  Validate _idCard = Validate(null, null);
  String _dob;
  String _gender;
  String _defaultImage = DEFAULT_IMG;

  Validate get fullName => _fullName;
  Validate get email => _email;
  Validate get idCard => _idCard;
  String get dob => _dob;
  String get gender => _gender;
  String get defaultImage => _defaultImage;

  File _image;
  File get image => _image;

  bool _check;
  bool get check => _check;

  SignUpViewModel() {
    //
    _dobController.addListener(() {
      _dob = _dobController.text;
      notifyListeners();
    });
    //
    _genderController.addListener(() {
      _gender = _genderController.text;
      notifyListeners();
    });
    getUserPhoneNum();
  }

  //function get user phone number in SharedPreferences
  void getUserPhoneNum() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    phone = sharedPreferences.getString('usPhone');
    notifyListeners();
  }

  //function choose DOB
  void changeDOB(DateTime datetime) {
    _dobController.text = datetime.year.toString() +
        '-' +
        _months[datetime.month - 1] +
        '-' +
        datetime.day.toString();
    notifyListeners();
  }

  //function choose gender
  void chooseGender(String newValue) {
    _genderController.text = newValue;
    notifyListeners();
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
    print(email);
    if (email == null || email.length == 0) {
      _email = Validate(null, "Email can't be blank");
    } else {
      _email = Validate(email, null);
    }
    notifyListeners();
  }

  void printCheck() {
    print(_image.toString());
    print(_fullName.value);
    print(_idCard.value);
    print(_gender);
    print(_dob);
    print(_email.value);
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

  Future<bool> createNewAccount(BuildContext context) async {
    _check = true;
    if (_fullName.value == null) {
      checkFullName(null);
      _check = false;
    }

    if (_check = true) {
      waitDialog(context, message: "Creating account! please wait...");
      String currentImage;

      if (_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      _signUpModel = new SignUpModel(
        fullName: _fullName.value,
        dob: _dob,
        gender: _gender,
        phone: phone,
        image: currentImage,
        email: _email.value,
        idCard: _idCard.value,
      );

      String addProfileJson = jsonEncode(_signUpModel.toJson());
      print(addProfileJson + "\n");

      bool check = await _signUpRepo.createProfile(addProfileJson);
      if (check == true) check = await _signUpRepo.updateUser();

      if (check == true) check = await _signUpRepo.createHealthRecord();

      if (check == true) check = await _signUpRepo.createPatient();

      Navigator.pop(context);
    }
    return check;
  }
}
