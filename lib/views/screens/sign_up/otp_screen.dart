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
