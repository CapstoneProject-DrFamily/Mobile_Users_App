import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/search_page_viewmodel.dart';
import 'package:drFamily_app/widgets/common/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../share/base_view.dart';

class ListDoctorPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseView<SearchPageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: MainColors.kMainBody,
          appBar: AppBar(
            iconTheme: IconThemeData(color: MainColors.blueBegin),
            backgroundColor: Colors.blue.withOpacity(0), //
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
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/f3/6a/f2/f36af2cd47e98121d5c1318a41a58004.jpg'),
                  fit: BoxFit.fill),
            ),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment(-1.0, 0.0),
            //     end: Alignment(5, 0.0),
            //     colors: [MainColors.blueBegin, MainColors.blueEnd],
            //   ),
            // ),
            child: FutureBuilder(
                future: model.loadDoctor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("Don't have any doctor"),
                      );
                    } else
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: model.listDoctor.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
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
                                                      MainColors.blueBegin,
                                                      MainColors.blueEnd
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
                                                    MainColors.blueBegin,
                                                    MainColors.blueEnd),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        'https://www.doctor-4-u.co.uk/wp/wp-content/uploads/2020/02/485165_PR_130_SI_24_06_14_255-m-1.png',
                                                      ),
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
                                                        Text('Dr Anh Khoa',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('Khoa nội',
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
                                                          child: Text('4.8',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Center(
                                                            child: RatingBar(
                                                                rating: 4))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
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
                      );
                  } else
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ));
                }),
          ),
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