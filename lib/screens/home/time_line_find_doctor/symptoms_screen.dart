import 'dart:ui' as ui;
import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/symptom_screen_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SymptomsScreen extends StatelessWidget {
  final BaseTimeLineViewModel baseTimeLineViewModel;
  SymptomsScreen({@required this.baseTimeLineViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<SymptomScreenViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initData(baseTimeLineViewModel),
          builder: (context, snapshot) {
            if (model.initSymptom) {
              return Center(child: CircularProgressIndicator());
            } else
              return Scaffold(
                bottomNavigationBar: _buildSaveButtom(model, context),
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    _buildBackgroudColor(context),
                    Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.lightBlue[200],
                                        Colors.blue[400],
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue[200],
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
                                        Colors.lightBlue[200],
                                        Colors.blue[400]),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 5, left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          model.serviceModel.serviceName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 15),
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          Common.convertPrice(
                                              model.serviceModel.servicePrice),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 15),
                            height: 30,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: model.symptomsDisplay.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    model.changeFatherSymptom(index);
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(right: 7),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: (index == model.indexFather)
                                          ? Color(0xff0d47a1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      model.symptomsDisplay[index].headerValue,
                                      style: TextStyle(
                                          color: (index == model.indexFather)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: model
                                    .symptomsDisplay[model.indexFather]
                                    .expandedValue
                                    .length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        model.changeChecked(model
                                            .symptomsDisplay[model.indexFather]
                                            .expandedValue
                                            .keys
                                            .toList()[index]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 5),
                                          title: Text(
                                            model
                                                .symptomsDisplay[
                                                    model.indexFather]
                                                .expandedValue
                                                .values
                                                .toList()[index],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Icon(
                                            model.savedValue.contains(model
                                                    .symptomsDisplay[
                                                        model.indexFather]
                                                    .expandedValue
                                                    .keys
                                                    .toList()[index]
                                                    .toString())
                                                ? EvaIcons
                                                    .checkmarkSquareOutline
                                                : EvaIcons.square,
                                            color: model.savedValue.contains(
                                                    model
                                                        .symptomsDisplay[
                                                            model.indexFather]
                                                        .expandedValue
                                                        .keys
                                                        .toList()[index]
                                                        .toString())
                                                ? Colors.green
                                                : Colors.black,
                                            size: 30,
                                          ),
                                        ),
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
                  ],
                ),
              );
          },
        );
      },
    );
  }

  Container _buildBackgroudColor(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: PathPainterBottom(),
      ),
    );
  }

  GestureDetector _buildSaveButtom(
      SymptomScreenViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        model.continuePage(context, baseTimeLineViewModel);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(80)),
            gradient: LinearGradient(
              colors: [Color(0xff374ABE), Color(0xff64B6FF).withOpacity(0.4)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
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

class PathPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFBBDEFB).withOpacity(0.3);
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
