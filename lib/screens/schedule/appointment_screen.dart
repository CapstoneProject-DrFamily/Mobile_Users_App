import 'package:drFamily_app/Helper/StatefulWrapper.dart';
import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/schedule/reason_appointment_screen.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/appointment_view_model.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  final DoctorScheduleModel doctorScheduleModel;
  final BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel;

  AppointmentScreen(
      {@required this.doctorScheduleModel,
      this.baseTimeLineAppoinmentViewModel});

  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentViewModel>(
      builder: (context, child, model) {
        return StatefulWrapper(
          onInit: () {
            model.fetchData(doctorScheduleModel);
          },
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'Choose Date & Time',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff0d47a1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Text(
                          'Please select a date & time for your appointment.',
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 5),
                        child: Text(
                          'These time slots are in Vietnam timezone (GMT+7:00).',
                          style: TextStyle(
                            color: Color(0xff0d47a1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: model.schedules.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = model.schedules.keys.elementAt(index);
                        return Container(
                          padding: EdgeInsets.only(
                              top: 5, left: 20, right: 20, bottom: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffe6eafb).withOpacity(0.8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Common.convertSchedule(key),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff0d47a1),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: model.schedules[key].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 30),
                                              Expanded(
                                                  child: Text(
                                                Common.convertTime(model
                                                    .schedules[key][index]
                                                    .appointmentTime),
                                                style: TextStyle(
                                                  color: Color(0xff0d47a1),
                                                ),
                                              )),
                                              Radio(
                                                value: model
                                                    .schedules[key][index]
                                                    .scheduleId,
                                                groupValue: model.selectedValue,
                                                onChanged: (value) {
                                                  model
                                                      .changeSelectedDay(value);
                                                  print(value);
                                                },
                                              )
                                            ],
                                          ),
                                          index !=
                                                  (model.schedules[key].length -
                                                      1)
                                              ? Divider(
                                                  thickness: 2,
                                                  endIndent: 50,
                                                  indent: 50,
                                                )
                                              : Container(),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            bottomNavigationBar: _buildContinueButtom(
              model,
              context,
            ),
          ),
        );
      },
    );
  }

  GestureDetector _buildContinueButtom(
      AppointmentViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (model.selectedValue != null) {
          model.nextStep(baseTimeLineAppoinmentViewModel);
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ReasonAppointmentScreen(
          //           appointmentViewModel: model,
          //         )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                model.selectedValue == null
                    ? Color(0xff374ABE).withOpacity(0.4)
                    : Color(0xff374ABE),
                model.selectedValue == null
                    ? Color(0xff64B6FF).withOpacity(0.4)
                    : Color(0xff64B6FF)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                        Navigator.pop(context);
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
}
