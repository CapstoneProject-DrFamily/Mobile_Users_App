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
                  _nameField(context, model),
                  _idCardField(context, model),
                  _buildListGender(context, model),
                  _dobField(context, model),
                  _emailField(context, model),
                  GestureDetector(
                    onTap: () async {
                      bool check = await model.createNewAccount(context);
                      print("Check: " + check.toString());
                      if (check) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LandingScreen()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
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
        top: 30.0,
        left: 30.0,
        right: 20.0,
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
          hintText: 'Enter name..',
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
        top: 15.0,
        left: 30.0,
        right: 20.0,
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
          hintText: 'Enter ID Card..',
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
        top: 15.0,
        left: 30.0,
        right: 20.0,
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

  Widget _dobField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1900, 1, 1),
              maxTime: DateTime(2099, 12, 31),
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
            hintText: "Choose Your Birthday",
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
        top: 15.0,
        left: 30.0,
        right: 20.0,
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
}
