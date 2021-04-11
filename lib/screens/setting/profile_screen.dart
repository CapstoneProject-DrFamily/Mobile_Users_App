import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/setting_vm/profile_screen_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<ProfileScreenViewModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            child: model.isLoading
                ? Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildImageSelectField(model),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitleCard('Basic Infomation',
                                      Icons.info, Colors.greenAccent),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Full Name'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildFullNameField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Gender'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildFieldGender(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Date of Birth'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildDOBFIeld(context, model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Phone Number'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildPhoneNumberField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Email'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildEmailField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Social Security Number'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildIDCardField(model),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //additional
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitleCard('Additional Infomation',
                                      EvaIcons.fileTextOutline, Colors.blue),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Home Location'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _locationField(context, model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Blood Type'),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "(*)",
                                        style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildBloodTypeField(model, context),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  _buildTitle('Height'),
                                                  SizedBox(
                                                    width: 2.0,
                                                  ),
                                                  Text(
                                                    "(*)",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.red.shade300,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                    child: TextFormField(
                                                      controller: model
                                                          .heightController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      maxLength: 3,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: "",
                                                        contentPadding:
                                                            new EdgeInsets
                                                                .symmetric(
                                                          vertical: 14.2,
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                    child: TextFormField(
                                                      initialValue: 'cm',
                                                      enabled: false,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: false,
                                                        contentPadding:
                                                            new EdgeInsets
                                                                .symmetric(
                                                          vertical: 14.2,
                                                        ),
                                                        disabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  _buildTitle('Weight'),
                                                  SizedBox(
                                                    width: 2.0,
                                                  ),
                                                  Text(
                                                    "(*)",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.red.shade300,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                    child: TextFormField(
                                                      controller: model
                                                          .weightController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      maxLength: 3,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: "",
                                                        contentPadding:
                                                            new EdgeInsets
                                                                .symmetric(
                                                          vertical: 14.2,
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                    child: TextFormField(
                                                      initialValue: 'kg',
                                                      enabled: false,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: false,
                                                        contentPadding:
                                                            new EdgeInsets
                                                                .symmetric(
                                                          vertical: 14.2,
                                                        ),
                                                        disabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildSaveButton(context, model),
                          ],
                        ),
                      ),
                      _buildAppbar(context),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _locationField(BuildContext context, ProfileScreenViewModel model) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                color: Colors.blue,
              ),
            ),
            // errorText: model.errorLocation,
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

  GestureDetector _buildWeightField(
      ProfileScreenViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Picker(
            adapter: PickerDataAdapter<String>(
                pickerdata: new JsonDecoder().convert(model.listWeight),
                isArray: true),
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.getSelectedValues());
              model.changeWeight(picker.getSelectedValues());
            }).showModal(context);
      },
      child: TextFormField(
        controller: model.weightController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Weight",
          filled: true,
          enabled: false,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildHeightField(
      ProfileScreenViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Picker(
            adapter: PickerDataAdapter<String>(
                pickerdata: new JsonDecoder().convert(model.listheight),
                isArray: true),
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.getSelectedValues());
              model.changeHeight(picker.getSelectedValues());
            }).showModal(context);
      },
      child: TextFormField(
        controller: model.heightController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Height",
          filled: true,
          enabled: false,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Padding _buildBloodTypeField(
      ProfileScreenViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          Picker(
              adapter:
                  PickerDataAdapter<String>(pickerdata: model.listBloodType),
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
                model.changeBloodType(picker.getSelectedValues().first);
              }).showModal(context);
        },
        child: TextFormField(
          controller: model.bloodTpeController,
          // onChanged: (value) => model.changePhoneNum(value),
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: "Choose Your Blood group",
            filled: true,
            enabled: false,
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildIDCardField(ProfileScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 12,
        controller: model.idCardController,
        onChanged: (text) {
          model.checkIDCard(text);
        },
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your Social Security Number",
          errorText: model.idCard.error,
          counterText: "",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        ),
      ),
    );
  }

  Padding _buildEmailField(ProfileScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: model.emailController,
        onChanged: (text) {
          model.checkEmail(text);
        },
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your email address",
          errorText: model.email.error,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Padding _buildPhoneNumberField(ProfileScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: model.phoneNumController,
        readOnly: true,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your phone number",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Padding _buildDOBFIeld(BuildContext context, ProfileScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
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
            prefixIcon: Icon(
              EvaIcons.calendar,
              color: Colors.blue,
            ),
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            hintText: "Choose Your Birthday",
            filled: true,
            enabled: false,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          ),
        ),
      ),
    );
  }

  Padding _buildFullNameField(ProfileScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: model.fullNameController,
        onChanged: (text) {
          model.checkFullName(text);
        },
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "Enter your full name",
          errorText: model.fullName.error,
          filled: true,
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        ),
      ),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      ),
    );
  }

  Row _buildTitleCard(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 45,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildFieldGender(ProfileScreenViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            model.changeGender(0);
          },
          child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                model.gender == 0
                    ? Icon(
                        EvaIcons.radioButtonOn,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Icon(
                        EvaIcons.radioButtonOffOutline,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Male',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            model.changeGender(1);
          },
          child: Container(
            child: Row(
              children: [
                model.gender == 1
                    ? Icon(
                        EvaIcons.radioButtonOn,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Icon(
                        EvaIcons.radioButtonOffOutline,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Female',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Positioned _buildAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(
          'Your Profile',
          style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true, // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }

  ClipPath _buildImageSelectField(ProfileScreenViewModel model) {
    return ClipPath(
      clipper: MyClipper(),
      child: GestureDetector(
        onTap: () {
          model.getUserImage();
        },
        child: Container(
          padding: EdgeInsets.only(top: 70, bottom: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlue[200], Colors.blue[600]]),
            image: DecorationImage(
              image: AssetImage(PROFILE_BACKGROUD),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: (model.image != null
                    ? FileImage(model.image)
                    : NetworkImage(model.currentImage)),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade400,
                    radius: 16.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 14.0,
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
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSaveButton(
      BuildContext context, ProfileScreenViewModel model) {
    return GestureDetector(
      onTap: () async {
        bool isUpdate = await _confirmBookingDialog(context);
        if (isUpdate) {
          waitDialog(context, message: "Updating your infomation...");
          bool check = await model.updateInformation();
          print("Check: " + check.toString());

          if (check) {
            Navigator.pop(context);

            await CoolAlert.show(
                barrierDismissible: false,
                context: context,
                type: CoolAlertType.success,
                text: "Update info Success",
                backgroundColor: Colors.lightBlue[200],
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen()));
                });
          } else {
            Navigator.pop(context);

            await CoolAlert.show(
                barrierDismissible: false,
                context: context,
                type: CoolAlertType.error,
                text: "ERROR, please try again!",
                backgroundColor: Colors.lightBlue[200],
                onConfirmBtnTap: () {
                  Navigator.pop(context);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen()));
                });
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue[400],
          ),
          child: Center(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

Future _confirmBookingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (bookingContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          height: 345,
          width: MediaQuery.of(bookingContext).size.width * 0.8,
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
                "Confirmation?",
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
              Text(
                'Are you sure want to change?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'avenir',
                  color: Colors.black,
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
                      Navigator.of(bookingContext).pop(true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(bookingContext).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'avenir',
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onTap: () {
                      Navigator.of(bookingContext).pop(false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(bookingContext).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'avenir',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
