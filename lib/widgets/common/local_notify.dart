import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'app_image.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('ic_launcher');
    var initSettingIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceiveNotification notification = ReceiveNotification(
            id: id, body: body, payload: payload, title: title);
        didReceiveLocalNotificationSubject.add(notification);
      },
    );
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
        "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
        importance: Importance.max, priority: Priority.high, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0, "TestNoti", "TestBody", platformChannel,
        payload: 'New PayLoad');
  }

  Future<void> scheduleNotification(DateTime datetimeSchedule, String title,
      String body, int minuteToNoti) async {
    var scheduleNotificationDateTime =
        datetimeSchedule.subtract(Duration(minutes: minuteToNoti));

    var androidChannel = AndroidNotificationDetails(
        "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableLights: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.schedule(0, "Schedule Title",
        "Schedule Body", scheduleNotificationDateTime, platformChannel,
        payload: 'New PayLoad');
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceiveNotification(
      {@required this.id,
      @required this.body,
      @required this.payload,
      @required this.title});
}
