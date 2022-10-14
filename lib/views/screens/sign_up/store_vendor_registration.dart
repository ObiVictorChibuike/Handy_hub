import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class StoreVendorRegistration extends StatelessWidget {
  const StoreVendorRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(children: [
          const AuthHeader(
            title: "Store Vendor",
            subTitle: "You are registering as a Store Vendor",
          ),
          const SizedBox(
            height: 39,
          ),
          PlainTextField(
            label: "Business Name",
            hint: "Matthew Adetoyese",
          ),
          PlainTextField(
            label: "Email Address",
            hint: "matthew.a@gmail.com",
          ),
          PlainTextField(
            label: "Physical Address",
            hint: "23 Adegbite street, Sawmil, Ifako Ijaye",
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
