import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/material.dart';

import '../../views/widgets/custom_snack.dart';

login(BuildContext? context) async {
  LoginBloc loginBloc = locator.get<LoginBloc>();
  var url = "${BASE_URL}Services/identity/login";
  var response =
      await post(url: url, context: context, body: loginBloc.loginBody);

  if (response['data']['isSuccessful'] == true) {
    print(response);
    showMessageSnackBar(context!,
        title: "Success",
        content: response['data']['message']['friendlyMessage'] ??
            "Login Successful");
  } else {
    showErrorSnackBar(context!,
        title: "Something Went Wrong",
        content: response['data']['message']['friendlyMessage'] ?? "Error");
  }
}
