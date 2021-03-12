import 'package:drFamily_app/Helper/StatefulWrapper.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/list_doctor_screen_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../../share/base_view.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';

class ListDoctorPage extends StatelessWidget {
  final UserCurrentAddress pickUpInfo;
  ListDoctorPage({Key key, @required this.pickUpInfo}) : super(key: key);
  Widget build(BuildContext context) {
    return BaseView<ListDoctorScreenViewModel>(
      builder: (context, child, model) {
        return StatefulWrapper(
          onInit: () {
            model.init(pickUpInfo);
          },
          child: Scaffold(
              backgroundColor: MainColors.white,
              appBar: AppBar(
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                iconTheme: IconThemeData(color: MainColors.blueBegin),
                backgroundColor: Colors.blue.withOpacity(0),
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    Text(
                      'Meet Our Doctor',
                      style: TextStyle(
                        color: Color(0xff0d47a1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff567feb),
                      ),
                      child: IconButton(
                        icon: Icon(EvaIcons.home, color: Colors.white),
                        onPressed: () {
                          _confirmDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
                elevation: 0,
              ),
              body: (() {
                if (model.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (model.isNotHave) {
                  return _buildNotHaveScreen(context);
                } else
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/backgroundhome.jpg'),
                          fit: BoxFit.fill),
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                itemCount: model.nearByDoctorList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      model.getDetailDoctor(
                                        model.nearByDoctorList[index].id,
                                        model.nearByDoctorList[index].notitoken,
                                        model.nearByDoctorList[index].fbId,
                                        context,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.lightBlue
                                                        .withOpacity(0.2),
                                                    Colors.lightBlue[100]
                                                        .withOpacity(0.2)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: MainColors.blueBegin,
                                                    blurRadius: 12,
                                                    offset: Offset(0, 6))
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            top: 0,
                                            child: CustomPaint(
                                              size: Size(70, 100),
                                              painter: CustomCardShapePainter(
                                                  24,
                                                  Colors.lightBlue
                                                      .withOpacity(0.2),
                                                  Colors.lightBlue[100]
                                                      .withOpacity(0.2)),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(model
                                                            .nearByDoctorList[
                                                                index]
                                                            .image),
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          model
                                                              .nearByDoctorList[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          model
                                                              .nearByDoctorList[
                                                                  index]
                                                              .speciality,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic)),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                            model
                                                                .nearByDoctorList[
                                                                    index]
                                                                .distance
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14)),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Center(
                                                        child: Text(
                                                          "km",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14),
                                                        ),
                                                        // RatingBar(
                                                        //     rating: 4),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }())),
        );
      },
    );
  }

  Container _buildNotHaveScreen(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
      child: Column(
        children: [
          SvgPicture.asset(
            // "",
            NOT_FOUND_DOCTOR,
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "There don't seem to be any care providers for",
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "the service you selected in your area.",
            style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff4ee1c7),
              ),
              child: Center(
                child: Text(
                  'Choose another location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LandingScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff567feb),
              ),
              child: Center(
                child: Text(
                  'Choose another service',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
          height: MediaQuery.of(context).size.height * 0.45,
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
                "Please Note",
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
                'You have not finished booking your',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'avenir',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'appointment. Are you sure that you would',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'avenir',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'like to go back to the home page?',
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()),
                          (Route<dynamic> route) => false);
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
                      Navigator.pop(context);
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

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;
    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);
    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
