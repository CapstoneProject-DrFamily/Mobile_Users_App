import 'dart:ui';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HealthRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            TabView1(),
            Icon(Icons.movie),
          ],
        ),
      ),
    );
  }
}

//TabBarView for Tiền sử & Dị ứng
class TabView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue.shade400,
            ),
            tabs: [
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
            TabView3(),
            TabView4(),
            TabView5(),
            TabView6(),
            TabView7(),
            TabView8(),
          ],
        ),
      ),
    );
  }
}

//TabBarView for Yếu tố tiếp xúc
class TabView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//TabBarView for Tình trạng lúc sinh
class TabView3 extends StatelessWidget {
  List<String> buttonOriginalList = [
    "Đẻ thường",
    "Đẻ mổ",
    "Đẻ thiếu tháng",
    "Bị ngạt lúc đẻ"
  ];

  List<String> buttonList(List<String> originalList) {
    List<String> list;
    for (var i = 0; i < originalList.length / 2; i++) {
      String value = originalList.elementAt(i);
      list.add(value);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                  // SizedBox(
                  //   height: 10,
                  // ),
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
                              // contentPadding:
                              //     const EdgeInsets.symmetric(vertical: 1.0),
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
                              // contentPadding:
                              //     const EdgeInsets.symmetric(vertical: 1.0),
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
                      margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height / 14,
                      // color: Colors.black,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(color: Colors.grey),
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
          ],
        ),
      ),
    );
  }
}

//TabBarView for Tiền sử bệnh tật, dị ứng
class TabView4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//TabBarView for khuyết tật
class TabView5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//TabBarView for Tiền sử phẫu thuật
class TabView6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//TabBarView for Tiền sử gia đình
class TabView7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//TabBarView for Vấn đề khác
class TabView8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
