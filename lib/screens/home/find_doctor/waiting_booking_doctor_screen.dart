import 'package:commons/commons.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/waiting_booking_doctor_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class WaitingBookingDoctorScreen extends StatelessWidget {
  final String token;

  WaitingBookingDoctorScreen({Key key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<WaitingBookingDoctorViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.getDoctorToken(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 350.0,
                                    width: double.infinity,
                                    child: Image.asset(
                                      LOGIN_WAVE,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // Expanded(child: Container()),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Waiting Doctor",
                                          style: TextStyle(
                                              fontSize: (28 / 375.0) *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue[700],
                                              height: 1.5),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06),
                                        _buildProcessField(model),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1),
                                        _buildCancelButton(context, model),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              _buildLogo(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }

  Padding _buildProcessField(WaitingBookingDoctorViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: JumpingText(
        '...',
        style: TextStyle(fontSize: 50),
      ),
    );
  }

  Container _buildCancelButton(
      BuildContext context, WaitingBookingDoctorViewModel model) {
    return Container(
      height: (56 / 812.0) * MediaQuery.of(context).size.height,
      child: RaisedButton(
        onPressed: () {
          model.cancelBooking(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: (300 / 375.0) * MediaQuery.of(context).size.width,
                minHeight: (50 / 812.0) * MediaQuery.of(context).size.height),
            alignment: Alignment.center,
            child: Text(
              "Cancel Booking",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: (18 / 375.0) * MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildLogo() {
    return Positioned(
      left: 0,
      top: 72,
      right: 0,
      child: Container(
        width: 150,
        height: 150,
        child: Image.asset(
          LOGIN_LOGO,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
