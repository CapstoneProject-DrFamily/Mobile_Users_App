import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                _userHeader(),
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
                            _listIcon('Doctor Lookup', ImagesLinks.findDrLogo,
                                1, context),
                            _listIcon('Medical Report',
                                ImagesLinks.medicalReportLogo, 2, context),
                            _listIcon('Schedule',
                                ImagesLinks.medicationScheduleLogo, 3, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _doctorLookup(BuildContext context) {
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
            borderRadius: BorderRadius.circular(25),
          ),
          content: Container(
            width: 250,
            height: 200,
            child: Column(
              children: <Widget>[],
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'CANCEL',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _listIcon(
      String nameIcon, String imageLink, int position, BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            switch (position) {
              case 1:
                _doctorLookup(context);
                break;
              case 2:
                break;
              case 3:
                break;
            }
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
                  imageLink,
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
            nameIcon,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF6f6f6f),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadUserInfo(BuildContext context) {
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

  Widget _userHeader() {
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
}
