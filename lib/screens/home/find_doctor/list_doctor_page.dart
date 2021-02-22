import 'package:drFamily_app/Helper/StatefulWrapper.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/doctor_detail_screen.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/list_doctor_screen_view_model.dart';
import 'package:drFamily_app/widgets/common/not_found_screen.dart';
import 'package:drFamily_app/widgets/common/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../share/base_view.dart';

class ListDoctorPage extends StatelessWidget {
  final UserCurrentAddress pickUpInfo;
  ListDoctorPage({Key key, @required this.pickUpInfo}) : super(key: key);
  Widget build(BuildContext context) {
    return BaseView<ListDoctorScreenViewModel>(
      builder: (context, child, model) {
        return StatefulWrapper(
          onInit: () {
            print("create List");
            model.init(pickUpInfo);
          },
          child: Scaffold(
              backgroundColor: MainColors.kMainBody,
              appBar: AppBar(
                iconTheme: IconThemeData(color: MainColors.blueBegin),
                backgroundColor: Colors.blue.withOpacity(0),
                // flexibleSpace: Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         colors: [MainColors.blueBegin, MainColors.blueEnd],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight),
                //   ),
                // ),
                // backgroundColor: MainColors.blueBegin,

                centerTitle: true,
                title: Text('List of Doctor',
                    style: TextStyle(color: MainColors.blueBegin)),
                elevation: 0,
              ),
              body: (() {
                if (model.nearByDoctorList.length <= 0) {
                  print("oke");
                  return NotFoundScreen();
                } else
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/backgroundhome.jpg'),
                          fit: BoxFit.fill),
                    ),
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     begin: Alignment(-1.0, 0.0),
                    //     end: Alignment(5, 0.0),
                    //     colors: [MainColors.blueBegin, MainColors.blueEnd],
                    //   ),
                    // ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: model.nearByDoctorList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorDetailScreen(
                                                    id: model
                                                        .nearByDoctorList[index]
                                                        .id),
                                          ),
                                        );
                                        print(model.nearByDoctorList[index].id);
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
                                                      color:
                                                          MainColors.blueBegin,
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
                                                                color: Colors
                                                                    .white,
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
                                                                color: Colors
                                                                    .white,
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
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Center(
                                                          child: Text(
                                                            "km",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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

                                    // return new GestureDetector(
                                    //   child: new ListTile(
                                    //       title: new Card(
                                    //           child: Column(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: <Widget>[
                                    //       new ListTile(
                                    //         leading: CircleAvatar(
                                    //           // backgroundColor:
                                    //           //     MainColors.blueBegin,
                                    //           radius: 45,
                                    //           // child: ClipOval(
                                    //           //   child: Image.network(
                                    //           //     model.listDoctor[index].url,
                                    //           //     width: 60,
                                    //           //     height: 60,
                                    //           //   ),
                                    //           // ),
                                    //         ),
                                    //         title: Text(
                                    //           model.listDoctor[index].name,
                                    //           style: TextStyle(
                                    //               fontSize: 20,
                                    //               fontWeight:
                                    //                   FontWeight.bold),
                                    //         ),
                                    //         subtitle: Text("Speciality : " +
                                    //             model.listDoctor[index]
                                    //                 .speciality),
                                    //       ),
                                    //     ],
                                    //   ))),
                                    //   onTap: () async {
                                    //     final created = await Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               DoctorDetailPage(
                                    //                   id: model
                                    //                       .listDoctor[index]
                                    //                       .id)),
                                    //     );
                                    //   },
                                    // );
                                  }),
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
