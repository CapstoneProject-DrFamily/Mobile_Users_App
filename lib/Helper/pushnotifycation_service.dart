import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PushNotifycationService {
  static String usStatus;

  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize() async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('in mess');
        String typeNoti = message['data']['type'];
        if (typeNoti.endsWith("booking")) {
          var transactionId = message['data']['transactionId'];
          String status = message['data']['status'];
          if (status.endsWith('cancel')) {
            await cancelBooking();
          } else if (status.endsWith("accept")) {
            usStatus = "Analysis Symptom Changing";
            await acceptBooking();
            //accept
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
    Get.back();
  }

  Future<void> acceptBooking() async {
    Fluttertoast.showToast(
      msg: "Doctor have Accept your request",
      textColor: Colors.green,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
    Get.offAll(LandingScreen());
  }
}