import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

abstract class INotifyRepo {
  Future<void> bookDoctor(String tokenID);
  Future<void> cancelBooking(String tokenID);
  Future<void> cancelTransaction(String transactionID, String usToken);
}

class NotifyRepo extends INotifyRepo {
  final String serverToken =
      'AAAAERBD7G8:APA91bExZZNT0340wBRqrEcuhJrLCNvl7P9HCNDOTWIkB9hCqiJVMBrNdU44RRsM9c1alGKxmr_9ZPkEqOo8UooN-MktViUJXZzbNKCdfzlFX0QZghx0kCQ_48zqZoGA0faVePes29Ti';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  Future<void> bookDoctor(String tokenID) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Patient is waiting for your response',
            'title': 'YOU HAVE A NEW PATIENT'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'waiting',
            'type': 'booking',
          },
          'to': tokenID,
        },
      ),
    );
  }

  @override
  Future<void> cancelBooking(String tokenID) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Patient have cancel booking',
            'title': 'YOUr PATIENT HAVE CANCEL BOOKING'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'cancel',
            'type': 'booking',
          },
          'to': tokenID,
        },
      ),
    );
  }

  @override
  Future<void> cancelTransaction(String transactionID, String tokenID) async {
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
            'body': 'Medical care have been cancel',
            'title': 'Patient have cancel medical care'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionID,
            'status': 'end',
            'type': 'booking',
          },
          'to': tokenID,
        },
      ),
    );
  }
}
