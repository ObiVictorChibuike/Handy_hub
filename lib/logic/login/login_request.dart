 import 'dart:convert';

import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import '../../views/widgets/custom_snack.dart';

String? customerId;
String? token;

login(BuildContext? context) async {
  LoginBloc loginBloc = locator.get<LoginBloc>();
  var url = "${BASE_URL}Services/identity/login";
  final response = await post(url: url, context: context, body: loginBloc.loginBody);

  print(json.encode(response['token']));

  if (response['data']['isSuccessful'] == true) {
    token = response['data']['token'];
    // print(customToken);
    // print(response);
    showMessageSnackBar(context!,
        title: "Success",
        content: response['data']['message']['friendlyMessage'] ??
            "Login Successful");
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Dashboard();
    }));
  } else if (response['status_code'] == 504) {
    showErrorSnackBar(context!,
        title: "Something Went Wrong",
        content: "Check your Internet connections");
  } else {
    showErrorSnackBar(context!,
        title: "Something Went Wrong",
        content: response['data']['message']['friendlyMessage'] ?? "Error");
  }
}

class ApiServices {
 Future login2(String userName, String password) async {
   try{
     var endpoint = '${BASE_URL}Services/identity/login';
     final headers = {
       'Content-Type': 'application/json; charset=UTF-8',
     };
     final response = await http.post(Uri.parse(endpoint),headers: headers, body: json.encode({
       "userName" : userName,
       "password" : password,
     }));
     print(response.body);
     final responseData = json.decode(response.body);
     // Code = json.decode(response.body)["token"];
     token = json.decode(response.body)["token"];

     print(responseData);
     return responseData;
   } catch(e){
     print(e);
     throw(e);
   }
 }
 String? getToken(){
   print(token);
   return token;
 }
}
