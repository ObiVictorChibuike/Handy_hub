import 'package:esolink/logic/login/login_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassord extends StatefulWidget {
  const ForgotPassord({Key? key}) : super(key: key);

  @override
  State<ForgotPassord> createState() => _ForgotPassordState();
}

class _ForgotPassordState extends State<ForgotPassord> {
  final emailController = TextEditingController();
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: ListView(children: [
            const AuthHeader(
              title: "Forgot Password",
              subTitle: "",
            ),
            const SizedBox(
              height: 39,
            ),
            PlainTextField(
              controller: emailController,
              label: "Email Address",
              hint: "email address",
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                emailController.text.isNotEmpty ?  _controller.forgotPassword(email: emailController.text, context: context) : null;
              },
              child: Container(
                height: 47, width: double.maxFinite, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(11)),
                child: Center(child: Text("Reset", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 12,
            ),
          ]),
        ),
      );
    });
  }
}
