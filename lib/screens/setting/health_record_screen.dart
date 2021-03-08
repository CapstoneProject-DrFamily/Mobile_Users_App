import 'dart:ui';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/health_record_view_model.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HealthRecordViewModel>(builder: (context, child, model) {
      return DefaultTabController(
        length: 2,
        child: model.isLoading
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : Scaffold(
                appBar: new AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "Personal Health Record",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AVENIR,
                    ),
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue[400],
                    tabs: [
                      Tab(
                        child: Text(
                          "History & Allergy",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AVENIR,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Exposure",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AVENIR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _tabView1(context, model),
                    _tabView2(context, model),
                  ],
                ),
                bottomNavigationBar: GestureDetector(
                  onTap: () async {
                    // model.printCheck();
                    bool check = await model.updateHealthRecord();
                    print("Check: " + check.toString());

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HealthRecordScreen()));

                    Fluttertoast.showToast(
                      msg: "Update success",
                      textColor: Colors.red,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.white,
                      gravity: ToastGravity.CENTER,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      30.0,
                      15.0,
                      30.0,
                      15.0,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  //TabBarView for Tiền sử & Dị ứng
  DefaultTabController _tabView1(
      BuildContext context, HealthRecordViewModel model) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0.0,
          title: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue.shade400,
            ),
            tabs: [
              //Tab Tình trạng lúc sinh
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Condition at birth",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sự bệnh tật, dị ứng
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 180,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "History, Allergy",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab khuyết tật
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Disabilities",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sử phẩu thuật
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Surgical biography",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sử gia đình
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 140,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Family history",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab vấn đề khác
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 120,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontFamily: AVENIR,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _tabView3(context, model),
            _tabView4(context, model),
            _tabView5(context, model),
            _tabView6(context, model),
            _tabView7(context, model),
            _tabView8(context, model),
          ],
        ),
      ),
    );
  }

  //TabBarView for Yếu tố tiếp xúc
  Widget _tabView2(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Smoking cigarettes, waterpipe",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceCigarette(0);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width / 2,
                    margin: EdgeInsets.only(
                      right: 40.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceCigarette == 0
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
                          'No',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceCigarette(1);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        model.choiceCigarette == 1
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
                          'Yes',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceCigarette(2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      right: 40.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceCigarette == 2
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
                          'Smoke often',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceCigarette(3);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        model.choiceCigarette == 3
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
                          'Quit',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Drink alcohol regularly",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      model.changeChoiceWine(0);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(
                        left: 14.0,
                        bottom: 15.0,
                      ),
                      child: Row(
                        children: [
                          model.choiceWine == 0
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
                            'Yes',
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      model.changeChoiceWine(1);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(
                        left: 14.0,
                        bottom: 15.0,
                      ),
                      child: Row(
                        children: [
                          model.choiceWine == 1
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
                            'No',
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      model.changeChoiceWine(2);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(
                        left: 14.0,
                        bottom: 15.0,
                      ),
                      child: Row(
                        children: [
                          model.choiceWine == 2
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
                            'Quit',
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Drug use",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceDrug(0);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width / 2,
                    margin: EdgeInsets.only(
                      right: 40.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceDrug == 0
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
                          'No',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceDrug(1);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        model.choiceDrug == 1
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
                          'Yes',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceDrug(2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.75,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceDrug == 2
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
                          'Usually use',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceDrug(3);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        model.choiceDrug == 3
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
                          'Quit',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Physical activity",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceActivity(0);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width / 2,
                    margin: EdgeInsets.only(
                      right: 40.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceActivity == 0
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
                          'No',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceActivity(1);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        model.choiceActivity == 1
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
                          'Yes',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    model.changeChoiceActivity(2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceActivity == 2
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
                          'Regularly',
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Occupational exposure factors / Habitat (chemiscals, dust, noise, viruses,..)",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Indicatie the exposure element",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.exposureElementController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Contact time",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.contactTimeController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Type of household toilet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.toiletTypeController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Other risk",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other risk",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherRisksController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tình trạng lúc sinh
  Widget _tabView3(BuildContext context, HealthRecordViewModel model) {
    List<String> buttonOriginalList = [
      "Spontaneous delivery",
      "Abdominal delivery",
      "Premature labour",
      "Suffocation"
    ];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Condition at birth",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomRadioButton(
              defaultSelected: model.conditionAtBirth,
              horizontal: true,
              enableShape: true,
              unSelectedColor: Theme.of(context).canvasColor,
              buttonLables: buttonOriginalList,
              buttonValues: buttonOriginalList,
              buttonTextStyle: ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: TextStyle(fontSize: 16),
              ),
              radioButtonValue: (value) {
                model.changeConditionAtBirth(value);
              },
              selectedColor: Theme.of(context).accentColor,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 60),
                          child: Column(
                            children: [
                              Text(
                                "Birth weight",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            "Baby length",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 80.0,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: model.birthWeightController,
                          keyboardType: TextInputType.text,
                          maxLength: 3,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          initialValue: 'kg',
                          enabled: false,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100.0,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: model.birthHeightController,
                          keyboardType: TextInputType.text,
                          maxLength: 3,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: TextFormField(
                          initialValue: 'cm',
                          enabled: false,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Congenital Disorder (describe if any)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.825,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: TextField(
                            controller: model.birthDefectsController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Describe if any',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Other",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.825,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: TextField(
                            controller: model.otherDefectsController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Describe if any',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử bệnh tật, dị ứng
  Widget _tabView4(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "History, Allergy",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Allergy",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Medicines allergy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.medicineAllergyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Comestic Allergy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.chemicalAllergyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Food Allergies",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.foodAllergyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other Allergies",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherAllergyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pathology",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pathology",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.diseaseController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe type of Pathology',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.cancerController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe type of Cancer',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tuberculosis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.tuberculosisController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe type of Tuberculosis',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherDiseasesController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for khuyết tật
  Widget _tabView5(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Disabilities",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hearing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.hearingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Eyesight",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.eyesightController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hand",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.handController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Leg",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.legController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Scoliosis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.scoliosisController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cleft palate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.cleftLipController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherDisabilitiesController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử phẫu thuật
  Widget _tabView6(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Surgical biography",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 6,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Describe the anatomical part of the body and the year of surgery",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.surgeryHistoryController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử gia đình
  Widget _tabView7(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Family history",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Allergy",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Drug allergy - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.medicineAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe allergy and relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Comestic allergy - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.chemicalAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe allergy and relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Food allergies - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.foodAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe allergy and relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other allergy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe allergy and relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pathology",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pathology",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.diseaseFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe pathology, patient, relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.cancerFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe cancer, patient, relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tuberculosis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.tuberculosisFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText:
                            'Describe tuberculosis, patient, relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherDiseasesFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe, patient, relationship',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Vấn đề khác
  Widget _tabView8(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Other",
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 6,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Describe (if any)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Describe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
