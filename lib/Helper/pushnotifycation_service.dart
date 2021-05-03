import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PushNotifycationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize() async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('in mess');
        String typeNoti = message['data']['type'];
        if (typeNoti.endsWith("booking")) {
          String status = message['data']['status'];
          if (status.endsWith('cancel')) {
            await cancelBooking();
          } else if (status.endsWith("accept")) {
            await acceptBooking();
            //accept
          } else if (status.endsWith("arrived")) {
            await arrivedBooking();
          }
          print('booking');
        } else if (typeNoti.endsWith("schedule")) {
          String status = message['data']['status'];
          String info = message['notification']['body'];
          if (status == "cancel") {
            Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  child: Column(
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
                        "Appointment Cancel!",
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
                        '$info!',
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
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "Ok",
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
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  Future<String> getToken() async {
    String token = await fcm.getToken();
    print('Token: $token');

    fcm.subscribeToTopic('allDoctors');
    fcm.subscribeToTopic('allUsers');

    return token;
  }

  Future<void> cancelBooking() async {
    Fluttertoast.showToast(
      msg: "Doctor have Cancel your request",
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      gravity: ToastGravity.CENTER,
    );
    // Get.back();
  }

  Future<void> acceptBooking() async {
    Fluttertoast.showToast(
      msg: "Doctor have Accept your request",
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      gravity: ToastGravity.CENTER,
    );
  }

  Future<void> arrivedBooking() async {
    // Fluttertoast.showToast(
    //   msg: "Doctor have Arrived",
    //   textColor: Colors.white,
    //   toastLength: Toast.LENGTH_LONG,
    //   backgroundColor: Colors.green,
    //   gravity: ToastGravity.CENTER,
    // );
  }
}
