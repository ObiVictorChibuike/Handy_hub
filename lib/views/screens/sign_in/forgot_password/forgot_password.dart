import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class ForgotPassord extends StatelessWidget {
  const ForgotPassord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = locator.get<LoginBloc>();
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
            stream: loginBloc.email,
            onChanged: loginBloc.addEmail,
            label: "Email Address",
            hint: "email address",
          ),
          const SizedBox(
            height: 40,
          ),
          StreamBuilder<bool>(
              stream: loginBloc.isSet,
              builder: (context, snapshot) {
                return CustomButton(
                  onTap: () async {},
                  enabled: snapshot.data,
                  text: "Reset",
                );
              }),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 12,
          ),
        ]),
      ),
    );
  }
}
