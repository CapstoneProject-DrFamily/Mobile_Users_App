import 'package:commons/commons.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/add_dependent_profile_screen_view_model.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDependentProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AddDependentProfileScreenViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.1,
                      padding: EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue[400],
                              Colors.lightBlue[700]
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildTopText(),
                                  _buildDivider(),
                                  _buildAskText(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 30.0,
                                      right: 255.0,
                                    ),
                                    child: Text(
                                      "Full name",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  _fullNameField(context, model),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 20.0,
                                      right: 300.0,
                                    ),
                                    child: Text(
                                      "DOB",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  _dobField(context, model),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 20.0,
                                      right: 170.0,
                                    ),
                                    child: Text(
                                      "Relationship with you",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  _buildListRelationship(context, model),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 20.0,
                                      right: 210.0,
                                    ),
                                    child: Text(
                                      "Home Location",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  _locationField(model, context),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            alignment: Alignment.center,
            height: 50.0,
            width: 300.0,
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            child: RaisedButton(
              color: Colors.lightBlue,
              onPressed: () async {
                waitDialog(context);

                bool isCreated = await model.createDependent();

                print("create $isCreated");
                if (isCreated) {
                  Navigator.of(context).pop();
                  await CoolAlert.show(
                    barrierDismissible: false,
                    context: context,
                    type: CoolAlertType.success,
                    text: "Add Dependent success",
                    backgroundColor: Colors.lightBlue[200],
                    onConfirmBtnTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );

                  print("out context");
                } else {
                  Navigator.of(context).pop();

                  await CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      type: CoolAlertType.error,
                      text: "Add Dependent Fail!",
                      backgroundColor: Colors.lightBlue[200],
                      onConfirmBtnTap: () {
                        Navigator.of(context).pop();
                      });
                }
              },
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'ADD',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildAskText() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40.0,
      ),
      child: Text(
        "WHO DO YOU WANT TO ADD?",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'avenir',
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40.0,
      ),
      child: Container(
        height: 1.0,
        width: 70.0,
        color: Colors.white,
      ),
    );
  }

  Container _buildTopText() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 40.0,
        right: 40.0,
      ),
      child: Text(
        "Adding a profile for a family member will help us serve you better",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: new Text(
        "ADD DEPENDENT",
      ),
    );
  }

  Widget _fullNameField(
      BuildContext context, AddDependentProfileScreenViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.fullNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) {
          model.validateFullname(value);
        },
        decoration: InputDecoration(
          errorText: model.fullName.error,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter full name...',
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

  Widget _dobField(
      BuildContext context, AddDependentProfileScreenViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1900, 1, 1),
              maxTime: DateTime.now(),
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

  Widget _buildListRelationship(
      BuildContext context, AddDependentProfileScreenViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();

          Picker(
            adapter:
                PickerDataAdapter<String>(pickerdata: model.relationshipList),
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
              model.chooseRelationship(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.relationshipController,
          keyboardType: TextInputType.phone,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            hintText: 'Choose relationship',
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
          ),
        ),
      ),
    );
  }

  Widget _locationField(
      AddDependentProfileScreenViewModel model, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          //open map
          model.chooseMapLocation(context);
        },
        child: TextFormField(
          enabled: false,
          controller: model.locationChooseController,
          keyboardType: TextInputType.phone,
          maxLines: null,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            errorText: model.errorLocation,
            errorStyle: TextStyle(
              color: Colors.red, // or any other color
            ),
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            hintText: 'Choose location...',
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
}
