// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../widgets/auth_header.dart';

// class OTPVerification extends StatelessWidget {
//   OTPVerification({Key? key, this.mail}) : super(key: key);
//   final countdown = ValueNotifier<int>(60); //this 1

//   final String? mail;

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _pinPutController = TextEditingController();
//     Timer.periodic(const Duration(milliseconds: 1000), (timer) {
//       if (countdown.value > 0) {
//         countdown.value -= 1;
//       } else {
//         timer.cancel();
//       }
//     }); //this 2
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const AuthHeader(
//                   title: "Email Verification",
//                   subtitle: "Provide your email to reset your password",
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: PinCodeTextField(
//                     keyboardType: TextInputType.visiblePassword,
//                     appContext: context,
//                     length: 6,
//                     animationType: AnimationType.fade,
//                     onChanged: (e) {},
//                     onCompleted: (e) async {
//                       await verifyToken(context, mail, e);
//                     },
//                     pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         // borderRadius: const BorderRadius.all(Radius.circular(0)),
//                         fieldHeight: 55,
//                         fieldWidth: 45,
//                         borderWidth: 1,
//                         activeFillColor: const Color(0xffFCFCFC),
//                         errorBorderColor: Colors.transparent,
//                         disabledColor: Colors.amber,
//                         inactiveColor: appBlack.withOpacity(.3),
//                         selectedColor: appBlack.withOpacity(.3),
//                         inactiveFillColor: Colors.transparent,
//                         selectedFillColor: Colors.grey[100],
//                         activeColor: appGreen),
//                     textStyle: appTextStyle.copyWith(color: appGreen),
//                     animationDuration: const Duration(milliseconds: 300),
//                     backgroundColor: Colors.transparent,
//                     cursorColor: appGreen,
//                     enableActiveFill: true,
//                     controller: _pinPutController,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 44,
//                 ),
//                 ValueListenableBuilder(
//                     valueListenable: countdown,
//                     builder: (_, value, context) {
//                       return Visibility(
//                         visible: value != 0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Text(
//                                 "Didn’t recieve verification code?",
//                                 textAlign: TextAlign.center,
//                                 style: appTextStyle.copyWith(fontSize: 14),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 16,
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Resend Code:\t",
//                                   textAlign: TextAlign.center,
//                                   style: appTextStyle.copyWith(
//                                       color: appGreen, fontSize: 13),
//                                 ),
//                                 Text(
//                                   value.toString(),
//                                   style: appTextStyle.copyWith(
//                                       color: appBlack, fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                 ValueListenableBuilder(
//                     valueListenable: countdown,
//                     builder: (_, value, context) {
//                       return Visibility(
//                         visible: value == 0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Text(
//                                 "Didn’t recieve verification code?",
//                                 textAlign: TextAlign.center,
//                                 style: appTextStyle.copyWith(fontSize: 14),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 16,
//                             ),
//                             Text(
//                               "Resend Code",
//                               textAlign: TextAlign.center,
//                               style: appTextStyle.copyWith(
//                                   color: appGreen, fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 CustomButton(
//                   text: "Continue",
//                   enabled: true,
//                   onTap: () async {
//                     await verifyToken(
//                         context, mail, _pinPutController.text.toString());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/login/registration_controller.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/custom_snack.dart';

class OtpVerification extends StatefulWidget {
  final String userEmail;
  final String password;
  const OtpVerification({Key? key, required this.userEmail, required this.password}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();

  @override
  Widget build(BuildContext context) {
    TextEditingController pinPutController = TextEditingController();
    var pin = "";
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const AuthHeader(
                title: "Verification",
                subTitle: "",
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: EsolinkIcons(
                  icons: "verification",
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 44, maxWidth: 332),
                child: Text("Enter the verification code sent to ${widget.userEmail}",
                  textAlign: TextAlign.center,
                  style: subHeaderText,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 4,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  onChanged: (e) {},
                  onCompleted: (e) async {
                    pinPutController.text = e;
                    log(pinPutController.text);
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      borderWidth: 1,
                      activeFillColor: const Color(0xffFCFCFC),
                      errorBorderColor: Colors.transparent,
                      disabledColor: Colors.amber,
                      inactiveColor: const Color(0xffF2F2F2),
                      selectedColor: primaryColor,
                      inactiveFillColor: const Color(0xffF2F2F2),
                      selectedFillColor: Colors.grey[100],
                      activeColor: primaryColor),
                  textStyle: subHeaderText.copyWith(color: primaryColor),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  cursorColor: primaryColor,
                  enableActiveFill: true,
                  controller: pinPutController,
                ),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Align(
              //     alignment: AlignmentDirectional.centerEnd,
              //     child: Text(
              //       "Resend Code",
              //       style:
              //       subHeaderText.copyWith(fontSize: 12, color: primaryColor),
              //     )),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  if(widget.userEmail == "" && pinPutController.text.isEmpty){
                    null;
                  }else{
                    controller.sendOtp(code: pinPutController.text, userEmail: widget.userEmail, password: widget.password);
                  }
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("Verify", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, ),),),
                ),
              ),
              // CustomButton(
              //   onTap: () {
              //     log(widget.userEmail);
              //     log(pinPutController.text);
              //   },
              //   text: "Verify",
              //   enabled: true
              // ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Would you like to change the email address?",
                        style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: const Color(0xff4F4F4F),
                        )),
                    TextSpan(
                        text: "Click here",
                        style: subHeaderText.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.pop(context);
                          }),
                  ]),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      );
    });
  }
}
