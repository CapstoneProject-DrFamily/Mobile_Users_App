import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/sign_up_vm/sign_up_view_model.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: MainColors.kMainBody,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _topField(context, model),
                Container(
                  margin: const EdgeInsets.only(
                    top: 90,
                    left: 20,
                    right: 20,
                  ),
                  child: RaisedButton(
                    color: MainColors.riseButtonBlue,
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      model.verifyPhone(context, model.phoneNum.value);
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _topField(BuildContext context, SignUpViewModel model) {
  return Container(
    height: MediaQuery.of(context).size.height / 1.75,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [MainColors.blueBegin, MainColors.blueEnd]),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _logoField(),
        _textRegistField(),
        _inputPhoneField(model),
      ],
    ),
  );
}

Widget _logoField() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 20, right: 30),
      child: Image.network(
        ImagesLinks.wordLogoLink,
        width: 250,
        height: 150,
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget _textRegistField() {
  return Container(
    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 0, right: 100),
      child: Text('Register',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}

Widget _inputPhoneField(SignUpViewModel model) {
  return Container(
    transform: Matrix4.translationValues(0, 50, 0),
    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
    width: double.infinity,
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      color: MainColors.white,
      boxShadow: [
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 50,
          offset: Offset(0, 0),
        )
      ],
    ),
    child: Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: TextFormField(
        controller: model.phoneNo,
        onChanged: (text) {
          model.changePhoneNum(text);
        },
        keyboardType: TextInputType.phone,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          errorText: model.phoneNum.error,
          prefix: Padding(
            padding: EdgeInsets.all(4),
            child: Text('(+84)'),
          ),
          hintText: '0123456789',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                const BorderSide(color: MainColors.iconLoginColor, width: 0.0),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 5.0,
              left: 10.0,
              bottom: 1.0,
            ),
            child: Icon(
              Icons.phone,
              color: MainColors.iconLoginColor,
            ),
          ),
        ),
      ),
    ),
  );
}
