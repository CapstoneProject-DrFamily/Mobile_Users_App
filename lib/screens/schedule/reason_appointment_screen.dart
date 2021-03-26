import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/schedule_vm/appointment_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/reason_appointment_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ReasonAppointmentScreen extends StatelessWidget {
  final AppointmentViewModel appointmentViewModel;

  ReasonAppointmentScreen({@required this.appointmentViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<ReasonAppointmentViewModel>(
        builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: MainColors.blueBegin),
          backgroundColor: Colors.blue.withOpacity(0),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 0,
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff567feb),
                ),
                child: IconButton(
                  icon: Icon(EvaIcons.home, color: Colors.white),
                  onPressed: () {
                    _confirmDialog(context);
                  },
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        'Reason for Appointment',
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
                        'Please describe your symptoms, questions, or condition so our care providers may provide you with the appropriate care.',
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
                        child: TextFormField(
                          maxLines: 5,
                          onChanged: (value) {
                            model.note = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter your reason here',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildContinueButtom(model, context),
      );
    });
  }

  GestureDetector _buildContinueButtom(
      ReasonAppointmentViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        model.bookingDoctor(this.appointmentViewModel);
      },
      child:
          // model.loadingProfile
          //     ? Text('')
          //     :
          Padding(
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: model.isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Container(
                            child: Text(
                              "Booking",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                  ),
                )
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
