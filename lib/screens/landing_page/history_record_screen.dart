import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/landing_page_vm/history_record_screen_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryRecordScreenViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initHistory(),
          builder: (context, snapshot) {
            if (!model.isFirst) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      model.fullUserName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(EvaIcons.flip2Outline,
                              color: Colors.black87),
                          onPressed: () {
                            print("change Patient");
                          }),
                    ],
                  ),
                  body: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 35,
                        color: Colors.transparent,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.historyTime.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                model.changeStatus(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: (model.status == index)
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xff0d47a1),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                child: Text(
                                  model.historyTime[index],
                                  style: (model.status == index)
                                      ? TextStyle(color: Colors.white)
                                      : TextStyle(color: Color(0xff0d47a1)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          child: (model.loadingList)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (model.isNotHave)
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            NOT_FOUND_RECORDS,
                                            width: 80,
                                            height: 80,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Not Found Any Records",
                                            style: GoogleFonts.varelaRound(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                color: Color(0xff0d47a1),
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: model.listTransaction.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          color: (index % 2 == 0)
                                              ? Colors.white
                                              : Colors.grey[100],
                                          child: CustomListItemTwo(
                                            serviceType: model
                                                .listTransaction[index]
                                                .serviceName,
                                            dateTimeBook:
                                                DateFormat("yyyy-MM-dd - hh:mm")
                                                    .format(DateTime.parse(model
                                                        .listTransaction[index]
                                                        .dateTimeStart))
                                                    .toString(),
                                            location: model
                                                .listTransaction[index].location
                                                .split(';')[1]
                                                .split(':')[1],
                                            price: NumberFormat.simpleCurrency(
                                                    locale: 'vi')
                                                .format(model
                                                    .listTransaction[index]
                                                    .servicePrice),
                                            doctorName: model
                                                .listTransaction[index]
                                                .doctorName,
                                            status: model
                                                .listTransaction[index].status,
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      )
                    ],
                  ),
                );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
    );
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
            (status == 1)
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.yellow[900]),
                    ),
                    child: Text(
                      "On Going",
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.yellow[900],
                      ),
                    ),
                  )
                : (status == 2)
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.yellow[800]),
                        ),
                        child: Text(
                          "Checking",
                          style: GoogleFonts.varelaRound(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.yellow[800],
                          ),
                        ),
                      )
                    : (status == 3)
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Text(
                              "Done",
                              style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.green,
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.red,
                              ),
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
        Text(
          '$price',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 18.0,
              color: Color(0xff0d47a1),
              fontWeight: FontWeight.bold),
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
