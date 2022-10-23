import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/logic/login/login_request.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class InitialSignIn extends StatelessWidget {
  const InitialSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc registrationBloc = locator.get<LoginBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(children: [
          const AuthHeader(
            title: "Sign In",
            subTitle: "Welcome back",
          ),
          const SizedBox(
            height: 39,
          ),
          PlainTextField(
            stream: registrationBloc.email,
            onChanged: registrationBloc.addEmail,
            label: "Email Address",
            hint: "",
          ),
          PasswordField(
            stream: registrationBloc.password,
            onchanged: registrationBloc.addPassword,
            label: "Password",
            hint: "password",
          ),
          const SizedBox(
            height: 40,
          ),
          StreamBuilder<bool>(
              stream: registrationBloc.isSet,
              builder: (context, snapshot) {
                return CustomButton(
                  onTap: () async{
                   await login(context);
                  },
                  enabled: snapshot.data,
                  text: "Login",
                );
              })
        ]),
      ),
    );
  }
}
