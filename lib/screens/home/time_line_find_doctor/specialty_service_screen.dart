import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/specialty_service_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SpecialtyServiceScreen extends StatelessWidget {
  final BaseTimeLineViewModel baseTimeLineViewModel;
  final BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel;
  SpecialtyServiceScreen(
      {this.baseTimeLineViewModel, this.baseTimeLineAppoinmentViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<SpecialtyServiceViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initData(),
          builder: (context, snapshot) {
            if (model.initSpecialty) {
              return Center(child: CircularProgressIndicator());
            } else
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: PathPainterBottom(),
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 7),
                          height: 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.listDislay.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  model.changeSpecialty(index);
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(right: 7),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: (model.chooseIndex == index)
                                        ? Color(0xff0d47a1)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: SvgPicture.network(
                                          model.listDislay[index].image,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      Text(
                                        model.listDislay[index].name,
                                        style: TextStyle(
                                            color: (model.chooseIndex == index)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
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
                              itemCount: model.listDislay[model.chooseIndex]
                                  .listService.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: InkWell(
                                    onTap: () {
                                      model.chooseSpecialty(
                                          baseTimeLineViewModel,
                                          model.listDislay[model.chooseIndex]
                                              .specialtyId,
                                          model.listDislay[model.chooseIndex]
                                              .name,
                                          model.listDislay[model.chooseIndex]
                                              .listService[index].serviceId,
                                          baseTimeLineAppoinmentViewModel);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 2)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10),
                                        leading: Container(
                                          padding: EdgeInsets.only(right: 16),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(width: 1),
                                            ),
                                          ),
                                          child: SvgPicture.network(
                                            model.listDislay[model.chooseIndex]
                                                .image,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        title: Text(
                                          model.listDislay[model.chooseIndex]
                                              .listService[index].serviceName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Original Price",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'avenir',
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format(model
                                                      .listDislay[
                                                          model.chooseIndex]
                                                      .listService[index]
                                                      .servicePrice),
                                              style: TextStyle(
                                                  color: Color(0xff0d47a1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.black,
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
              );
          },
        );
      },
    );
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
