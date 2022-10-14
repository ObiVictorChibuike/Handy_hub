import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class ServiceProviderRegistration extends StatelessWidget {
  const ServiceProviderRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(children: [
          const AuthHeader(
            title: "Service Provider",
            subTitle: "You are registering as a service provider",
          ),
          const SizedBox(
            height: 39,
          ),
          PlainTextField(
            label: "Business Name",
            hint: "Matthew Adetoyese",
          ),
          SelectField(
            onchanged: (e) {
              print(e);
            },
            items: "Capentry,Shoemaker,Tailor".split(","),
            hint: "Select Service Category",
            label: "Type of Service",
          ),
          PlainTextField(
            label: "Physical Address",
            hint: "23 Adegbite street, Sawmil, Ifako Ijaye",
          ),
          PlainTextField(
            label: "Phone Number",
            hint: "0909939939",
          ),
          PlainTextField(
            label: "Email Address",
            hint: "business@gmail.com",
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
