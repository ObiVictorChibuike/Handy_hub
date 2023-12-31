import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/logic/login/login_controller.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/sign_in/forgot_password/forgot_password.dart';
import 'package:esolink/views/screens/sign_up/sign_up_selections.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/text_decoration.dart';

class InitialSignIn extends StatefulWidget {
  final String? route;
  const InitialSignIn({Key? key, this.route}) : super(key: key);

  @override
  State<InitialSignIn> createState() => _InitialSignInState();
}

class _InitialSignInState extends State<InitialSignIn>  with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    TextEditingController mail = TextEditingController();
    TextEditingController password = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
    LoginBloc loginBloc = locator.get<LoginBloc>();
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
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
              controller: mail,
              stream: loginBloc.email,
              onChanged: loginBloc.addEmail,
              label: "Email Address",
              hint: "email address",
            ),
            PasswordField(
              controller: password,
              stream: loginBloc.password,
              onchanged: loginBloc.addPassword,
              label: "Password",
              hint: "password",
            ),
            Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassord()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style:
                    subHeaderText.copyWith(fontSize: 14, color: primaryColor),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<bool>(
                stream: loginBloc.isSet,
                builder: (context, snapshot) {
                  return CustomButton(
                    onTap: () {
                      controller.login(username: mail.text, password: password.text, context: context);
                    },
                    enabled: snapshot.data,
                    text: "Login",
                  );
                }),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Not having an account?",
                      style: subHeaderText.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xff4F4F4F),
                      )),
                  TextSpan(
                      text: "Register",
                      style: subHeaderText.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return const SignUpSelection();
                              }));
                        }),
                ]),
              ),
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
