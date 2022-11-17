import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/dashboard/store/store.dart';
import 'package:esolink/views/screens/onboarding_screens/new_onboarding.dart';
import 'package:esolink/views/screens/onboarding_screens/onboarding_screen.dart';
import 'package:esolink/views/screens/splash_screens/splash_screens.dart';
import 'package:esolink/views/themes/light_theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  serviceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Esolink',
        theme: lightTheme,
        home:   StoreScreen());
  }
}
