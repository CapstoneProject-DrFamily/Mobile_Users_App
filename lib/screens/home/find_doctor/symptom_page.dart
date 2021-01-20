import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/symptom_page_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SymptomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SymptomePageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  _buildBackgroudColor(context),
                  _buildText(),
                  _buildBackgroudImage(context),
                  _buildListSymptom(context, model),
                  _buildAppBar(context, model),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Container _buildListSymptom(
      BuildContext context, SymptomePageViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      child: ListView.builder(
        itemCount: model.symtoms.length,
        itemBuilder: (context, indexFather) {
          return Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1EFF1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    margin: EdgeInsets.only(top: 33),
                    child: Text(
                      model.symtoms[indexFather].headerValue,
                      style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontFamily: 'avenir',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    margin: EdgeInsets.only(top: 30),
                    child: Icon(
                      EvaIcons.activityOutline,
                      color: Color(0xff0d47a1),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: model.symtoms[indexFather].expandedValue.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          model.changeChecked(
                              model.symtoms[indexFather].expandedValue[index]);
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(top: 20),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1EFF1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 40),
                                  margin: EdgeInsets.only(top: 33),
                                  child: Text(
                                    model.symtoms[indexFather]
                                        .expandedValue[index],
                                    style: TextStyle(
                                      color: Color(0xff0d47a1),
                                      fontFamily: 'avenir',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  margin: EdgeInsets.only(top: 30),
                                  child: Icon(
                                      model.savedValue.contains(model
                                              .symtoms[indexFather]
                                              .expandedValue[index])
                                          ? EvaIcons.checkmarkCircle2
                                          : EvaIcons.checkmarkCircle2Outline,
                                      color: Color(0xff0d47a1)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Positioned _buildAppBar(BuildContext context, SymptomePageViewModel model) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(''), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () {
                model.continuePage(context);
              }),
        ],
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }

  Positioned _buildBackgroudImage(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.3,
      child: Opacity(
        opacity: 0.3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset(ON_BOARD),
          ),
        ),
      ),
    );
  }

  Container _buildText() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextSymptoms(),
        ],
      ),
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

  Text _buildTextSymptoms() {
    return Text(
      'Do you have any of these symptoms?',
      style: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w800,
        fontFamily: 'avenir',
        color: Color(0xff0d47a1),
      ),
      textAlign: TextAlign.center,
    );
  }
}

class PathPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xffE4E2FF);
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
