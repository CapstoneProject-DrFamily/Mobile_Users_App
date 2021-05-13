import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/signup_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blue.shade400,
            title: const Text(
              "Create new account",
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  _imageField(context, model),
                  Row(
                    children: [
                      _buildTitle('Full name'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _nameField(context, model),
                  Row(
                    children: [
                      _buildTitle('ID Card'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _idCardField(context, model),
                  Row(
                    children: [
                      _buildTitle('Gender'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _buildListGender(context, model),
                  Row(
                    children: [
                      _buildTitle('DOB'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _dobField(context, model),
                  Row(
                    children: [
                      _buildTitle('Email'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _emailField(context, model),
                  Row(
                    children: [
                      _buildTitle('Height (cm)'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _heightField(context, model),
                  Row(
                    children: [
                      _buildTitle('Weight (kg)'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _weightField(context, model),
                  Row(
                    children: [
                      _buildTitle('Blood Type'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _buildListBooldType(context, model),
                  Row(
                    children: [
                      _buildTitle('Home address'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _locationField(context, model),
                  GestureDetector(
                    onTap: () async {
                      bool isConfirm = await _confirmDialog(context);
                      if (isConfirm) {
                        waitDialog(context,
                            message: "Creating your account...");

                        bool check = await model.createNewAccount(context);
                        print("Check: " + check.toString());
                        if (check) {
                          Navigator.of(context).pop();

                          await CoolAlert.show(
                            barrierDismissible: false,
                            context: context,
                            type: CoolAlertType.success,
                            text: "Sign Up success",
                            backgroundColor: Colors.lightBlue[200],
                            onConfirmBtnTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LandingScreen()),
                                  (Route<dynamic> route) => false);
                            },
                          );
                        } else {
                          Navigator.of(context).pop();

                          await CoolAlert.show(
                              barrierDismissible: false,
                              context: context,
                              type: CoolAlertType.error,
                              text: "Sign Up Fail!",
                              backgroundColor: Colors.lightBlue[200],
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                              });
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 20.0,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _locationField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: GestureDetector(
        onTap: () {
          //open map
          model.chooseMapLocation(context);
        },
        child: TextFormField(
          enabled: false,
          controller: model.locationController,
          keyboardType: TextInputType.phone,
          maxLines: null,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorText: model.errorLocation,
            errorStyle: TextStyle(
              color: Colors.red, // or any other color
            ),
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            hintText: 'Choose location',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageField(BuildContext context, SignUpViewModel model) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 80.0,
          backgroundImage: (model.image != null
              ? FileImage(model.image)
              : NetworkImage(model.defaultImage)),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade400,
              radius: 20.0,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  size: 18.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  model.getUserImage();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        controller: model.fullNameController,
        onChanged: (text) {
          model.checkFullName(text);
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          errorText: model.fullName.error,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input your full name',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _idCardField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        controller: model.idCardController,
        onChanged: (text) {
          model.checkIDCard(text);
        },
        keyboardType: TextInputType.number,
        maxLength: 12,
        decoration: InputDecoration(
          errorText: model.idCard.error,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter Social Security Number',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildListGender(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter: PickerDataAdapter<String>(pickerdata: model.genderList),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseGender(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.genderController,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            hintText: 'Choose Gender',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dobField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1900, 1, 1),
              maxTime: DateTime(2009, 12, 31),
              theme: DatePickerTheme(
                  cancelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  itemStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
              onChanged: (date) {
            model.changeDOB(date);
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            model.changeDOB(date);
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: TextFormField(
          controller: model.dobController,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'Choose Your Birthday',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            filled: true,
            enabled: false,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            suffixIcon: Icon(
              EvaIcons.calendar,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        controller: model.emailController,
        onChanged: (text) {
          model.checkEmail(text);
        },
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          errorText: model.email.error,
          filled: true,
          fillColor: Colors.white,
          hintText: 'abc@gmail.com',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _heightField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        controller: model.heightController,
        onChanged: (text) {
          model.checkHeight(text);
        },
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.none,
        maxLength: 3,
        decoration: InputDecoration(
          errorText: model.height.error,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input your height (cm)',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _weightField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        controller: model.weightController,
        onChanged: (text) {
          model.checkWeight(text);
        },
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.none,
        maxLength: 3,
        decoration: InputDecoration(
          errorText: model.height.error,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input your weight (kg)',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildListBooldType(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2.0,
        left: 30.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter: PickerDataAdapter<String>(pickerdata: model.listBloodType),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseBloodType(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.bloodTypeController,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            hintText: 'Choose Blood type',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future _confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (alertContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            height: 380,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.info,
                  color: Color(0xff4ee1c7),
                  size: 90,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Confirm action",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                    color: Color(0xff0d47a1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Text(
                    'Are you sure all your information are correct?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'avenir',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.of(alertContext).pop(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.of(alertContext).pop(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
