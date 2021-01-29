import 'dart:ui';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/health_record_view_model.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HealthRecordViewModel>(builder: (context, child, model) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                    "Tiền sử & Dị ứng",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AVENIR,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Yếu tố tiếp xúc",
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
                        "Tình trạng lúc sinh",
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
                        "Tiền sử bệnh tật, dị ứng",
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
                        "Khuyết tật",
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
                        "Tiền sử phẫu thuật",
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
                        "Tiền sử gia đình",
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
                        "Vấn đề khác",
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
                  "Hút thuốc lá, lào",
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
                          'Không',
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
                          'Có',
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
                          'Hút thường xuyên',
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
                          'Đã bỏ',
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
                  "Uống rượu bia thường xuyên",
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
                            'Có',
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
                            'Không',
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
                            'Đã bỏ',
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
                  "Sử dụng ma túy",
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
                          'Không',
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
                          'Có',
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
                          'Sử dụng thường xuyên',
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
                          'Đã bỏ',
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
                  "Hoạt động thể lực",
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
                          'Không',
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
                          'Có',
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
                          'Thường xuyên',
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
                  "Yếu tố tiếp xúc nghề nghiệp/ Môi trường sống (Hóa chất, bụi, ồn, virus,...)",
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
                        "Ghi rõ yếu tố tiếp xúc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ',
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
                        "Thời gian tiếp xúc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ',
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
                        "Loại hố xí của gia đình",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ',
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
                  "Nguy cơ khác",
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
                        "Nguy cơ khác",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Button save
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 15,
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
          ],
        ),
      ),
    );
  }

//TabBarView for Tình trạng lúc sinh
  Widget _tabView3(BuildContext context, HealthRecordViewModel model) {
    List<String> buttonOriginalList = [
      "Đẻ thường",
      "Đẻ mổ",
      "Đẻ thiếu tháng",
      "Bị ngạt lúc đẻ"
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
                  "Tình trạng lúc sinh",
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
            Container(
              child: Column(
                children: <Widget>[
                  CustomRadioButton(
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
                      print(value);
                    },
                    selectedColor: Theme.of(context).accentColor,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            "Cân nặng lúc đẻ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            "Chiều dài lúc đẻ",
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
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
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
                        width: 80.0,
                      ),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
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
                    // color: Colors.black,
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
                              "Dị tật bẩm sinh (ghi rõ nếu có)",
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
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Ghi rõ nếu có',
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
                    // color: Colors.black,
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
                              "Vấn đề khác",
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
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Ghi rõ nếu có',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
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
                  "Tiền sử bệnh tật, dị ứng",
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
                  "Dị ứng",
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
              // color: Colors.black,
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
                        "Dị ứng thuốc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
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
              // color: Colors.black,
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
                        "Dị ứng hóa chất/mỹ phẩm",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
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
                        "Dị ứng thực phẩm",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
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
                        "Dị ứng khác",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
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
                  "Bệnh tật",
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
              // color: Colors.black,
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
                        "Bệnh",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại bệnh',
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
              // color: Colors.black,
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
                        "Ung thư",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại ung thư',
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
              // color: Colors.black,
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
                        "Lao",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại lao',
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
              // color: Colors.black,
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
                        "Khác",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nêu rõ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                  "Khuyết tật",
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
              // color: Colors.black,
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
                        "Thính lực",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
              // color: Colors.black,
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
                        "Thị lực",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
                        "Tay",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
                        "Chân",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
                        "Cong vẹo cột sống",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
                        "Khe hở môi, vòm miệng",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
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
                        "Khác",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tả',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                  "Tiền sử phẩu thuật",
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
              // color: Colors.black,
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
                        "Ghi rõ bộ phận cơ thể đã giải phẫu và năm phẫu thuật",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                  "Tiền sử gia đình",
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
                  "Dị ứng",
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
                        "Dị ứng thuốc - người mắc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tẻ rõ - ghi rõ mối quan hệ huyết thống',
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
              // color: Colors.black,
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
                        "Dị ứng hóa chất/mỹ phẩm - người mắc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tẻ rõ - ghi rõ mối quan hệ huyết thống',
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
              // color: Colors.black,
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
                        "Dị ứng thực phẩm - người mắc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tẻ rõ - ghi rõ mối quan hệ huyết thống',
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
              // color: Colors.black,
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
                        "Dị ứng khác - người mắc",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Mô tẻ rõ - ghi rõ mối quan hệ huyết thống',
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
                  "Bệnh tật",
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
              // color: Colors.black,
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
                        "Bệnh",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại bệnh, người mắc, quan hệ',
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
              // color: Colors.black,
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
                        "Ung thư",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại ung thư, người mắc, quan hệ',
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
              // color: Colors.black,
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
                        "Lao",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ loại lao, người mắc, quan hệ',
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
              // color: Colors.black,
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
                        "Khác",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Ghi rõ, người mắc, quan hệ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                  "Vấn đề khác",
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
              // color: Colors.black,
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
                        "Ghi rõ vấn đề khác (nếu có)",
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Miêu tả rõ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
