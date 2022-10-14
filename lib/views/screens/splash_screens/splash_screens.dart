import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/sign_up/sign_up_selections.dart';
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
                      builder: (context) => const SignUpSelection()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: const [
        Positioned(
          right: 0,
          top: 0,
          child: EsolinkIcons(
            image: "splash",
          ),
        ),
        Center(
            child: EsolinkIcons(
          image: "logo",
          size: 200,
        )),
      ]),
    );
  }
}
