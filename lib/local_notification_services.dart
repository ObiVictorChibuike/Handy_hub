import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        debugPrint('notification payload: $payload');
      }
      await Get.to(()=> const Dashboard());
    });
  }

  static void displayNotification(RemoteMessage message)async {
    try{
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

       NotificationDetails notificationDetails = const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            "HandyHub",
            "HandyHub channel",
            channelDescription: "This is HandyHub channel for notification",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: "@mipmap/ic_launcher",
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher")
          )
      );
      await _notificationsPlugin.show(
          id,
          message.notification!.title!,
          message.notification!.title!,
          notificationDetails,
          payload: message.data['id'],
      );
    }on Exception catch (e){
      print(e);
    }

  }
}