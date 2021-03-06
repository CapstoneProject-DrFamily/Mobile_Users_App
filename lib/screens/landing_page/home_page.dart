import 'package:commons/commons.dart';
import 'package:drFamily_app/screens/home/old_doctor/old_doctor_screen.dart';
import 'package:drFamily_app/screens/home/time_line_book_appoinment/base_time_line_appoinemnt.dart';
import 'package:drFamily_app/screens/home/time_line_find_doctor/base_time_line.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/home_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/pop_up_choose_patient_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffF9F9F9),
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: PathPainterBottom(),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.92,
                    child: SingleChildScrollView(
                      child: _buildBody(context, model),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildBody(BuildContext context, HomeViewModel model) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Welcome ${model.name} \nYour Health Is Our Mission',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              fontFamily: 'avenir',
              color: Color(0xff0d47a1),
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1EFF1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      child: _buildDoctorFunction(
                          context, 'Find Doctor', FIND_DOCTOR, 150, 190),
                      onTap: () async {
                        model.bookingFunction = false;
                        _buildDialogListDependent(context, model);
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await model.bookingTransaction();
                        _buildDialogListDependentBooking(context, model);
                      },
                      child: _buildDoctorFunction(context, 'Book Appointment',
                          BOOK_APPOINTMENT, 130, 170),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => OldDoctorScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: _buildDoctorFunction(
                    //       context, 'Old Doctor', YOUR_DOCTOR, 140, 180),
                    // ),
                    // _buildDoctorFunction(context, 'Medicine Schedule',
                    //     MEDICINE_SCHEDULE, 140, 180),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDialogListDependent(BuildContext context, HomeViewModel homeViewModel) {
    showDialog(
      context: context,
      builder: (dialogContex) => BaseView<PopUpChoosePatientViewModel>(
        builder: (dialogContex, child, model) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Center(child: new Text("Choose person")),
            content: new Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: model.listDependent.length,
                            itemBuilder: (dialogContex, index) => Row(
                              children: [
                                Expanded(
                                  child: model.listDependent[index]
                                              .dependentRelationShip ==
                                          "Owner"
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              model.choosePatient(index,
                                                  model.listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: model
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(model
                                                                .listDependent[
                                                                    index]
                                                                .dependentImage),
                                                      ),
                                                      title: Text(model
                                                          .listDependent[index]
                                                          .dependentName),
                                                      subtitle: Row(
                                                        children: [
                                                          Text(
                                                            model
                                                                .listDependent[
                                                                    index]
                                                                .dependentRelationShip,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff0d47a1),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 7.0,
                                                          ),
                                                          Icon(
                                                            EvaIcons
                                                                .awardOutline,
                                                            color: Color(
                                                                0xff0d47a1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  index == model.patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              model.choosePatient(index,
                                                  model.listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: model
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(model
                                                                .listDependent[
                                                                    index]
                                                                .dependentImage),
                                                      ),
                                                      title: Text(model
                                                          .listDependent[index]
                                                          .dependentName),
                                                      subtitle: Text(
                                                        model
                                                            .listDependent[
                                                                index]
                                                            .dependentRelationShip,
                                                      ),
                                                    ),
                                                  ),
                                                  index == model.patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.grey[350], // button color
                              child: InkWell(
                                splashColor: Colors.cyan, // inkwell color
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.add)),
                                onTap: () {
                                  model.addPatient(dialogContex);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
            ),
            actions: model.isLoading
                ? <Widget>[
                    Container(),
                  ]
                : <Widget>[
                    TextButton(
                      child: Text('Next'),
                      onPressed: () async {
                        // pop out current popup
                        Navigator.of(dialogContex).pop();
                        // wait 0.5s to change popup
                        waitDialog(context,
                            duration: Duration(milliseconds: 500));
                        await Future.delayed(Duration(milliseconds: 500));
                        //new popup
                        await homeViewModel.choosePatient(
                            model.listDependent[model.patientChoose].patientID,
                            model.listDependent[model.patientChoose]
                                .dependentName);
                        await homeViewModel.initTransaction(2);

                        if (homeViewModel.isHasCheck) {
                          _buildDialogChooseType(context, homeViewModel);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BaseTimeLineScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
          );
        },
      ),
    );
  }

  _buildDialogListDependentBooking(
      BuildContext context, HomeViewModel homeViewModel) {
    showDialog(
      context: context,
      builder: (dialogContex) => BaseView<PopUpChoosePatientViewModel>(
        builder: (dialogContex, child, model) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Center(child: new Text("Choose person")),
            content: new Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: model.listDependent.length,
                            itemBuilder: (dialogContex, index) => Row(
                              children: [
                                Expanded(
                                  child: model.listDependent[index]
                                              .dependentRelationShip ==
                                          "Owner"
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              model.choosePatient(index,
                                                  model.listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: model
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(model
                                                                .listDependent[
                                                                    index]
                                                                .dependentImage),
                                                      ),
                                                      title: Text(model
                                                          .listDependent[index]
                                                          .dependentName),
                                                      subtitle: Row(
                                                        children: [
                                                          Text(
                                                            model
                                                                .listDependent[
                                                                    index]
                                                                .dependentRelationShip,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff0d47a1),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 7.0,
                                                          ),
                                                          Icon(
                                                            EvaIcons
                                                                .awardOutline,
                                                            color: Color(
                                                                0xff0d47a1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  index == model.patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              model.choosePatient(index,
                                                  model.listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: model
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(model
                                                                .listDependent[
                                                                    index]
                                                                .dependentImage),
                                                      ),
                                                      title: Text(model
                                                          .listDependent[index]
                                                          .dependentName),
                                                      subtitle: Text(
                                                        model
                                                            .listDependent[
                                                                index]
                                                            .dependentRelationShip,
                                                      ),
                                                    ),
                                                  ),
                                                  index == model.patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.grey[350], // button color
                              child: InkWell(
                                splashColor: Colors.cyan, // inkwell color
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.add)),
                                onTap: () {
                                  model.addPatient(dialogContex);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
            ),
            actions: model.isLoading
                ? <Widget>[
                    Container(),
                  ]
                : <Widget>[
                    TextButton(
                      child: Text('Next'),
                      onPressed: () async {
                        Navigator.of(dialogContex).pop();

                        await homeViewModel.choosePatient(
                            model.listDependent[model.patientChoose].patientID,
                            model.listDependent[model.patientChoose]
                                .dependentName);
                        //booking screen specialty

                        // cần thêm
                        if (homeViewModel.isHasCheck) {
                          _buildDialogChooseType(context, homeViewModel);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BaseTimeLineAppoinmentScreen()),
                          );
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
          );
        },
      ),
    );
  }

  Future _buildDialogChooseType(
      BuildContext context, HomeViewModel homeViewModel) {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        title: Center(
          child: new Text(
            "Find By",
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xff0d47a1),
            ),
          ),
        ),
        content: new Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await homeViewModel.initTransaction(1);
                    Navigator.of(context).pop();
                    if (!homeViewModel.bookingFunction) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BaseTimeLineScreen()),
                      );
                    } else {
                      await homeViewModel.bookingTransaction();
                      homeViewModel.bookingFunction = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BaseTimeLineAppoinmentScreen()),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue[100],
                              Colors.blue[400],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.lightBlue[100],
                              blurRadius: 2,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: CustomPaint(
                          size: Size(100, 150),
                          painter: CustomCardShapePainter(
                              24, Colors.lightBlue[100], Colors.blue[400]),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'History Treatment',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SvgPicture.asset(
                                SYMPTOMS,
                                width: 80,
                                height: 80,
                              ),
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
                InkWell(
                  onTap: () async {
                    await homeViewModel.initTransaction(2);
                    Navigator.of(context).pop();
                    if (!homeViewModel.bookingFunction) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BaseTimeLineScreen()),
                      );
                    } else {
                      await homeViewModel.bookingTransaction();
                      homeViewModel.bookingFunction = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BaseTimeLineAppoinmentScreen()),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange[100],
                              Colors.deepOrange[300],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange[100],
                              blurRadius: 2,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: CustomPaint(
                          size: Size(100, 150),
                          painter: CustomCardShapePainter(
                            24,
                            Colors.orange[100],
                            Colors.deepOrange[300],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Specialty',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SvgPicture.asset(
                                SPECIALTY,
                                width: 80,
                                height: 80,
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
        ),
      ),
    );
  }

  Container _buildDoctorFunction(BuildContext context, String title,
      String icon, double height, double width) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      // color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xFF40BAD5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 15),
                  blurRadius: 27,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          // our function image
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height,
              width: width,
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              width: MediaQuery.of(context).size.width - 220,
              child: Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 22.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0d47a1)),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
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

class PathPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFBBDEFB);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
