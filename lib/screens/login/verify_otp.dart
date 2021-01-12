import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/sign_in_vm/verify_otp_view_model.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyOTPViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1.0, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [MainColors.blueBegin, MainColors.blueEnd]),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1.0, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [MainColors.blueBegin, MainColors.blueEnd])),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        (20 / 375.0) * MediaQuery.of(context).size.width),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        "OTP Verification",
                        style: TextStyle(
                            fontSize: (28 / 375.0) *
                                MediaQuery.of(context).size.width,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5),
                      ),
                      Text(
                        'We sent your code to +84${model.phoneNum}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.009),
                      _buildTimer(model),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      _buildOtpFrom(context, model),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      _buildButtom(context, model),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      (model.hideResend)
                          ? Text('')
                          : GestureDetector(
                              onTap: () {
                                model.startTimer();
                              },
                              child: Text(
                                'Resend OTP Code',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildButtom(BuildContext context, VerifyOTPViewModel model) {
    return SizedBox(
      width: double.infinity,
      height: (56 / 812.0) * MediaQuery.of(context).size.height,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xFFFF7643),
        onPressed: () {
          model.submitOTP(context);
        },
        child: Text(
          'Continue',
          style: TextStyle(
              color: Colors.white,
              fontSize: (18 / 375.0) * MediaQuery.of(context).size.width),
        ),
      ),
    );
  }

  Form _buildOtpFrom(BuildContext context, VerifyOTPViewModel model) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOtpField(context, 1, model),
          _buildOtpField(context, 2, model),
          _buildOtpField(context, 3, model),
          _buildOtpField(context, 4, model),
          _buildOtpField(context, 5, model),
          _buildOtpField(context, 6, model),
        ],
      ),
    );
  }

  SizedBox _buildOtpField(
      BuildContext context, int field, VerifyOTPViewModel model) {
    return SizedBox(
      width: (45 / 375) * MediaQuery.of(context).size.width,
      child: TextFormField(
        autofocus: (field == 1) ? true : false,
        onChanged: (value) {
          model.changeFocusNode(field, value);
        },
        focusNode: model.nextFocusNode(field),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: (10 / 375) * MediaQuery.of(context).size.width),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Row _buildTimer(VerifyOTPViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "00:${model.start}",
          style: TextStyle(color: Color(0xFFFF7643)),
        ),
      ],
    );
  }
}
