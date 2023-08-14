import 'dart:io';
import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/logic/login/login_controller.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/splash_screens/splash_screens.dart';
import 'package:esolink/views/themes/light_theme/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'local_notification_services.dart';
import 'logic/api_services/local/local_storage.dart';
import 'logic/login/registration_controller.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  if (message.notification != null && Platform.isIOS) {
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final hasOnBoarded = await LocalCachedData.instance.getHasOnBoardedStatus();
  if(hasOnBoarded == true){
    final controller = Get.put(LoginController());
    controller.updateLocationInit();
  }
  await Get.put(RegistrationController()).getDashBoardPhoto();
  Get.put(DeliveryController());
  runApp(MyApp(hasOnBoarded: hasOnBoarded,));
  serviceLocator();
}

class MyApp extends StatelessWidget {
  final bool? hasOnBoarded;
  const MyApp({Key? key, this.hasOnBoarded}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
       upgrader: Upgrader(shouldPopScope: () => true),
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'HandyHub',
            theme: lightTheme,
            home: hasOnBoarded == true ? const Dashboard() : const SplashScreen()),
      ),
    );
  }
}
