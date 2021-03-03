import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

abstract class INotifyRepo {
  Future<void> bookDoctor(String tokenID, String transactionID, String usToken);
  Future<void> cancelBooking(
      String tokenID, String transactionID, String usToken);
}

class NotifyRepo extends INotifyRepo {
  final String serverToken =
      'AAAAERBD7G8:APA91bExZZNT0340wBRqrEcuhJrLCNvl7P9HCNDOTWIkB9hCqiJVMBrNdU44RRsM9c1alGKxmr_9ZPkEqOo8UooN-MktViUJXZzbNKCdfzlFX0QZghx0kCQ_48zqZoGA0faVePes29Ti';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  Future<void> bookDoctor(
      String tokenID, String transactionID, String usToken) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print(transactionID);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Patient Hoang Duc is waiting for your response',
            'title': 'YOU HAVE A NEW PATIENT'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionID,
            'notiToken': usToken,
            'status': 'waiting',
            'type': 'booking',
          },
          'to': tokenID,
        },
      ),
    );
  }

  @override
  Future<void> cancelBooking(
      String tokenID, String transactionID, String usToken) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print(transactionID);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Patient Hoang Duc is waiting for your response',
            'title': 'YOU HAVE A NEW PATIENT'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionID,
            'notiToken': usToken,
            'status': 'cancel',
            'type': 'booking',
          },
          'to': tokenID,
        },
      ),
    );
  }
}