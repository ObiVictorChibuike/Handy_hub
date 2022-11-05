import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/sign_up/otp_screen.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:flutter/material.dart';

registerUser(BuildContext? context) async {
  RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();
  Map<String, dynamic>? result;
  result = registrationBloc.body;
  var url = "${BASE_URL}Services/register/service/provider/website";
  var response = await post(url: url, context: context, body: result); 
  if (response['data']['isSuccessful'] == true) {
    showMessageSnackBar(context!,
        title: "Success",
        content: response['data']['message']['friendlyMessage']);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OtpVerification()));
  } else {
    showErrorSnackBar(context!,
        title: "Something Went Wrong",
        content: response['data']['message']['friendlyMessage']);
  }
}
