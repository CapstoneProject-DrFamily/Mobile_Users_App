import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      textColor: Colors.red,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
    // Get.back();
  }

  Future<void> acceptBooking() async {
    Fluttertoast.showToast(
      msg: "Doctor have Accept your request",
      textColor: Colors.green,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }

  Future<void> arrivedBooking() async {
    Fluttertoast.showToast(
      msg: "Doctor have Arrived",
      textColor: Colors.green,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }
}
