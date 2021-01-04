import 'package:drFamily_app/links/links.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/widgets/fancy_bottom_navigation.dart';
import 'package:drFamily_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  int currentPage = 0;
  BestTutorSite _site = BestTutorSite.javatpoint;
  List<String> ringTone = [
    'Luna',
    'Oberon',
    'Phobos',
    'Rose',
    'Sunset',
    'Wood'
  ];

  Widget loadUserInfo() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            const Color(0xFF6aa6f8),
            const Color(0xFF1a60be),
          ], // whitish to gray
        ),
      ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget userHeader() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 25.0,
            ),
            width: 70.0,
            height: 70.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                  ImagesLinks.logoLink,
                ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Welcome back, User',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.25,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Text(
                      'How can we help you today?',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                MainColors.blueBegin,
                MainColors.blueEnd,
              ], // whitish to gray
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              userHeader(),
              // loadUserInfo(),
              Container(
                margin: const EdgeInsets.only(
                  top: 40.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: MainColors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return AlertDialog(
                                        title: Text(
                                          "Choose patient?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        content: Container(
                                          width: 250,
                                          height: 200,
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: const Text(
                                                    'www.javatpoint.com'),
                                                leading: Radio(
                                                  value:
                                                      BestTutorSite.javatpoint,
                                                  groupValue: _site,
                                                  onChanged:
                                                      (BestTutorSite value) {
                                                    setState(() {
                                                      _site = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    'www.w3school.com'),
                                                leading: Radio(
                                                  value:
                                                      BestTutorSite.w3schools,
                                                  groupValue: _site,
                                                  onChanged:
                                                      (BestTutorSite value) {
                                                    setState(() {
                                                      _site = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    'www.tutorialandexample.com'),
                                                leading: Radio(
                                                  value: BestTutorSite
                                                      .tutorialandexample,
                                                  groupValue: _site,
                                                  onChanged:
                                                      (BestTutorSite value) {
                                                    setState(() {
                                                      _site = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Container(
                                            child: Row(
                                              children: [
                                                FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'OK',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'CANCEL',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                color: MainColors.riseButtonBlue,
                                highlightColor: MainColors.highlightColorBule,
                                textColor: Colors.white,
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                        ImagesLinks.findDrLogo,
                                      ),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Doctor Lookup',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: MainColors.riseButtonBlue,
                                highlightColor: MainColors.highlightColorBule,
                                textColor: Colors.white,
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                        ImagesLinks.medicalReportLogo,
                                      ),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Medical Report',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: MainColors.riseButtonBlue,
                                highlightColor: MainColors.highlightColorBule,
                                textColor: Colors.white,
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                        ImagesLinks.medicationScheduleLogo,
                                      ),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Schedule',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.settings, title: "Search")
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          }),
    );
  }
}
