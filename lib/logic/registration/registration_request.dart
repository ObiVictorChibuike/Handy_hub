import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:flutter/cupertino.dart';

registerUser(BuildContext? context) async {
  RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();
  Map<String, dynamic>? result;
  result = registrationBloc.body;
  var url = "${BASE_URL}Services/register/service/provider/website";
  var response = await post(url: url, context: context, body: result);
  if (response['data']['status']['isSuccessful'] == true) {
    print(response);
    showSnackBar(ContentType.success,
        title: "Success",
        content: response['data']['status']['message']['friendlyMessage']);
  } else {
    print(response);
    showSnackBar(ContentType.failure,
        title: "Error",
        content: response['data']['status']['message']['friendlyMessage']);
  }
}
