import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/history_checking_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
                            var item = model.listSpecialty.indexWhere(
                                (element) =>
                                    element.listService.indexWhere((element1) =>
                                        element1.serviceId ==
                                        model.listTransaction[index]
                                            .serviceId) !=
                                    -1);
                            if (item == -1) {
                              CoolAlert.show(
                                barrierDismissible: false,
                                context: context,
                                type: CoolAlertType.error,
                                text: "This service is no longer available.",
                                backgroundColor: Colors.lightBlue[200],
                                onConfirmBtnTap: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              _confirmDialog(
                                  context,
                                  model,
                                  model.listTransaction[index].location,
                                  model.listTransaction[index]);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.grey[100],
                            child: CustomListItemTwo(
                              serviceType:
                                  model.listTransaction[index].serviceName,
                              dateTimeBook: DateFormat("dd-MM-yyyy - HH:mm")
                                  .format(DateTime.parse(model
                                      .listTransaction[index].dateTimeStart))
                                  .toString(),
                              location: model.listTransaction[index].location
                                  .split(';')[1]
                                  .split(':')[1]
                                  .trim(),
                              price: NumberFormat.simpleCurrency(locale: 'vi')
                                  .format(model
                                      .listTransaction[index].servicePrice),
                              doctorName:
                                  model.listTransaction[index].doctorName,
                              status: model.listTransaction[index].status,
                              note: model.listTransaction[index].note,
                              diagnoseList:
                                  model.listTransaction[index].diagnose,
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

  Future _confirmDialog(
      BuildContext context,
      HistoryCheckingScreenViewModel model,
      String location,
      TransactionHistoryModel transaction) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            width: MediaQuery.of(bookingContext).size.width * 0.8,
            child: StatefulBuilder(
              builder: (contextDialog, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
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
                      "Confirmation?",
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        'Do you want to reuse this information?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'avenir',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: model.option,
                          onChanged: (value) {
                            setState(() => model.option = value);
                          },
                        ),
                        Text('Default location'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: model.option,
                          onChanged: (value) {
                            setState(() => model.option = value);
                          },
                        ),
                        Text('Choose another location'),
                      ],
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
                          onTap: () async {
                            Navigator.pop(bookingContext);
                            // Navigator.pop(context);
                            await model.confirmChoose(
                                this.baseTimeLineViewModel,
                                this.baseTimeLineAppoinmentViewModel,
                                location,
                                transaction,
                                model);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width:
                                MediaQuery.of(bookingContext).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'avenir',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onTap: () {
                            Navigator.pop(bookingContext);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width:
                                MediaQuery.of(bookingContext).size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'avenir',
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                );
              },
            ),
          ),
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
    this.conclusion,
    this.note,
    this.diagnoseList,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String doctorName;
  final String price;
  final int status;
  final String note;
  final String conclusion;
  final List<String> diagnoseList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Service : $serviceType',
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
        SizedBox(
          height: 20,
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
                child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Location',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    Common.getLocationShort('$location', 50),
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8.0)),
        Row(
          children: <Widget>[
            Icon(
              Icons.sticky_note_2_outlined,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Note',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '$note',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            Icon(
              EvaIcons.activity,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Conclusion',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (var item in diagnoseList)
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          // constraints: BoxConstraints(
                          //   maxWidth:
                          //       MediaQuery.of(context).size.width * 0.7,
                          // ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff0d47a1),
                          ),
                          child: Text(
                            item.trim(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Doctor : $doctorName',
          textAlign: TextAlign.left,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
    this.note,
    this.conclusion,
    this.diagnoseList,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String doctorName;
  final String price;
  final int status;
  final String note;
  final String conclusion;
  final List<String> diagnoseList;

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
                  note: note,
                  conclusion: conclusion,
                  diagnoseList: diagnoseList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
