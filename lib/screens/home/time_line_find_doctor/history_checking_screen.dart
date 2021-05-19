import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/history_checking_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryCheckingScreen extends StatelessWidget {
  final BaseTimeLineViewModel baseTimeLineViewModel;
  final BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel;
  HistoryCheckingScreen(
      {this.baseTimeLineViewModel, this.baseTimeLineAppoinmentViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryCheckingScreenViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initData(),
          builder: (context, snapshot) {
            if (model.initHistoryChecking) {
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
                    child: ListView.builder(
                      itemCount: model.listTransaction.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("${model.listTransaction[index].status}");
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            color: Colors.grey[100],
                            child: CustomListItemTwo(
                              serviceType:
                                  model.listTransaction[index].serviceName,
                              dateTimeBook: DateFormat("dd-MM-yyyy - HH:mm")
                                  .format(DateTime.parse(model
                                      .listTransaction[index].dateTimeStart))
                                  .toString(),
                              location: model.listTransaction[index].location
                                  .split(';')[1]
                                  .split(':')[1],
                              price: NumberFormat.simpleCurrency(locale: 'vi')
                                  .format(model
                                      .listTransaction[index].servicePrice),
                              doctorName:
                                  model.listTransaction[index].doctorName,
                              status: model.listTransaction[index].status,
                            ),
                          ),
                        );
                      },
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
    paint.color = Color(0xFFBBDEFB).withOpacity(0.5);
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

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.serviceType,
    this.dateTimeBook,
    this.location,
    this.doctorName,
    this.price,
    this.status,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String doctorName;
  final String price;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$serviceType',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff0d47a1),
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Text(
              '$dateTimeBook',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Expanded(
              child: Text(
                '$location',
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Doctor: $doctorName',
          textAlign: TextAlign.left,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            '$price',
            style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xff0d47a1),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.serviceType,
    this.dateTimeBook,
    this.location,
    this.doctorName,
    this.price,
    this.status,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String doctorName;
  final String price;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        // height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  serviceType: serviceType,
                  dateTimeBook: dateTimeBook,
                  location: location,
                  price: price,
                  doctorName: doctorName,
                  status: status,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
