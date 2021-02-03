import 'package:drFamily_app/Helper/validate.dart';
import 'package:drFamily_app/screens/login/verify_otp.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends BaseModel {
  TextEditingController phoneNo = TextEditingController();
  String phoneNoString;

  Validate _phoneNum = Validate(null, null);
  Validate get phoneNum => _phoneNum;

  SignInViewModel() {
    phoneNo.addListener(() {
      phoneNoString = phoneNo.text;
      notifyListeners();
    });
    // initApp();
  }

  Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNo.text = prefs.getString('usPhone');
    print('phone: ' + phoneNo.text);
  }

  Future storePhone(BuildContext context) async {
    if (_phoneNum.value != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("usPhone", phoneNum.value);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(),
        ),
      );
    } else {
      return;
    }
  }

  void changePhoneNum(String value) {
    if (value.length < 9) {
      _phoneNum = Validate(null, "Require at least 9 number");
    } else {
      _phoneNum = Validate(value, null);
    }
    notifyListeners();
  }
}
