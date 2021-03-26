import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/schedule/appointment_screen.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/schedule_vm/doctor_detail_schedule_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DoctorDetailScheduleScreen extends StatelessWidget {
  final DoctorScheduleModel doctorScheduleModel;
  DoctorDetailScheduleScreen({@required this.doctorScheduleModel});

  @override
  Widget build(BuildContext context) {
    return BaseView<DoctorDetailScheduleViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          bottomNavigationBar: _buildConfirmButtom(context),
          backgroundColor: Colors.grey.shade300,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                _buildBody(context, doctorScheduleModel),
                _buildAppbar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _buildAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff4ee1c7),
              ),
              child: IconButton(
                icon: Icon(EvaIcons.home, color: Colors.white),
                onPressed: () {
                  _confirmDialog(context);
                },
              ),
            ),
          ],
        ), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }

  Container _buildBody(BuildContext context, DoctorScheduleModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              DR_DETAIL_BACKGROUND,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 95),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    //Get dr name
                                    model.doctorDetail.doctorName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    //Get dr name
                                    model.doctorDetail.doctorSpecialty,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(model.doctorDetail.doctorExperience +
                                        " Year"),
                                    Text("Experiences"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text("800"),
                                    Text("Reviews"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text("4.0"),
                                    Text("Rating"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            model.doctorDetail.doctorImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Doctor Information"),
                      ),
                      ListTile(
                        title: Text("Specialties"),
                        subtitle: Text(model.doctorDetail.doctorSpecialty),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            SPECIALTIES_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Schools"),
                        subtitle: Text(model.doctorDetail.doctorSchool),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            EDUCATION_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Degrees"),
                        subtitle: Text(model.doctorDetail.doctorDegree),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            DEGREE_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Description"),
                        subtitle: Text(model.doctorDetail.doctorDescription),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            DESCRIPTION_ICON,
                            fit: BoxFit.cover,
                          ),
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
    );
  }

  // Future _confirmBookingDialog(
  //     BuildContext context, DoctorDetailViewModel model) {
  //   return showDialog(
  //     context: context,
  //     builder: (bookingContext) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(12),
  //           ),
  //         ),
  //         child: Container(
  //           height: 345,
  //           width: MediaQuery.of(context).size.width * 0.8,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 25,
  //               ),
  //               Icon(
  //                 Icons.info,
  //                 color: Color(0xff4ee1c7),
  //                 size: 90,
  //               ),
  //               SizedBox(
  //                 height: 25,
  //               ),
  //               Text(
  //                 "Confirmation?",
  //                 style: TextStyle(
  //                   fontSize: 27,
  //                   fontWeight: FontWeight.w800,
  //                   fontFamily: 'avenir',
  //                   color: Color(0xff0d47a1),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 25,
  //               ),
  //               Text(
  //                 'Are you sure want to book this doctor?',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.normal,
  //                   fontFamily: 'avenir',
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 45,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   InkWell(
  //                     customBorder: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(30),
  //                     ),
  //                     onTap: () {
  //                       Navigator.pop(bookingContext);
  //                       model.confirmBooking(context);
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: 50,
  //                       width: MediaQuery.of(bookingContext).size.width * 0.3,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(30),
  //                         border: Border.all(color: Colors.blueAccent),
  //                       ),
  //                       child: Text(
  //                         "Yes",
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'avenir',
  //                           color: Colors.blueAccent,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   InkWell(
  //                     customBorder: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(30),
  //                     ),
  //                     onTap: () {
  //                       Navigator.pop(bookingContext);
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: 50,
  //                       width: MediaQuery.of(bookingContext).size.width * 0.3,
  //                       decoration: BoxDecoration(
  //                         color: Colors.blueAccent,
  //                         borderRadius: BorderRadius.circular(30),
  //                         border: Border.all(color: Colors.blueAccent),
  //                       ),
  //                       child: Text(
  //                         "No",
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'avenir',
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
            height: 380,
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
                        Navigator.pop(alertContext);
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

  GestureDetector _buildConfirmButtom(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AppointmentScreen(
                  doctorScheduleModel: doctorScheduleModel,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xff0d47a1),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book this doctor",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
