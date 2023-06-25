import 'package:esolink/logic/services_category/services_request.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/onboarding_screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () async => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen()))
            });
  }

  @override
  Widget build(BuildContext context) {
    getAllCategories(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: EsolinkIcons(
            image: "logo",
            size: 200,
          )
      ),
    );
  }
}
