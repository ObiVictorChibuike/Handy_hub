import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class CustomerRegistration extends StatelessWidget {
  const CustomerRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(children: [
          const AuthHeader(
            title: "Customer",
            subTitle: "You are registering as a customer",
          ),
          const SizedBox(
            height: 39,
          ),
          PlainTextField(
            label: "Full Name",
            hint: "Matthew Adetoyese",
          ),
          PlainTextField(
            label: "Email Address",
            hint: "matthew.a@gmail.com",
          ),
          PlainTextField(
            label: "Phone Number",
            hint: "0909939939",
          ),
          const PasswordField(
            label: "Password",
            hint: "password",
          ),
          const SizedBox(
            height: 40,
          ),
          const CustomButton(
            text: "Register",
          )
        ]),
      ),
    );
  }
}
