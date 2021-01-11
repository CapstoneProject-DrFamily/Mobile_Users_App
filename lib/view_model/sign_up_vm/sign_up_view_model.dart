import 'package:drFamily_app/Helper/user_fire_base_helper.dart';
import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/model/firebase_auth_user_model.dart';
import 'package:drFamily_app/screens/landing_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninititalized, Authenticated, Authenticating, Unauthenticated }

class SignUpViewModel extends BaseModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Status _status = Status.Uninititalized;
  UserService _userService = UserService();
  FireBaseAuthUserModel _userModel;
  TextEditingController phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool loggedIn = false;
  bool loading = false;

  Validate _phoneNum = Validate(null, null);

  //getters
  FireBaseAuthUserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => user;
  Validate get phoneNum => _phoneNum;

  void changePhoneNum(String value) {
    if (value.length <= 3 || value.length > 10) {
      _phoneNum = Validate(null, "Input Must Be > 3 number and < 10 number");
    } else {
      _phoneNum = Validate(value, null);
    }
    notifyListeners();
  }

  Future<void> readPrefs() async {
    await Future.delayed(Duration(seconds: 3)).then(
      (value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        loggedIn = prefs.getBool('loggedIn') ?? false;

        if (loggedIn) {
          _user = await _auth.currentUser();
          _userModel = await _userService.getUserById(_user.uid);
          _status = Status.Authenticated;
          notifyListeners();
          return;
        }

        _status = Status.Unauthenticated;
        notifyListeners();
      },
    );
  }

  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneCodeSent smsOTPSent = (String verID, [int fourceCodeResend]) {
      this.verificationId = verID;
      Fluttertoast.showToast(
        msg: "OTP Have Sent",
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    };
    try {
      if (number[0].endsWith('0')) number = number.substring(1, number.length);
      print(number.trim());
      await _auth.verifyPhoneNumber(
          phoneNumber: '+84' + number.trim(),
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException ex) {
            print('${ex.message} + something is wrong');
          },
          codeSent: smsOTPSent,
          codeAutoRetrievalTimeout: (String verID) {
            this.verificationId = verID;
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _createUser({String id, String number}) {
    _userService.createUser({
      "id": id,
      "number": number,
    });
  }

  void checkOTP(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsOTP);
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("loggedIn", true);
      loggedIn = true;
      if (user != null) {
        _userModel = await _userService.getUserById(user.user.uid);
        if (userModel == null) {
          _createUser(id: user.user.uid, number: user.user.phoneNumber);
        }

        loading = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      }

      loading = false;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    } catch (e) {
      print("${e.toString()}");
    }
  }
}
