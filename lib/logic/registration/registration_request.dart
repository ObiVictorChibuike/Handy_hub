import 'dart:convert';

import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/models/auth_model/registration_model.dart';
import 'package:http/http.dart' as http;
import 'package:esolink/views/screens/sign_up/otp_screen.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Future <void>registerUser(BuildContext? context, {required int customerTypeId,
//   required String firstName, String? lastName,
//   required String phoneNumber, required String email,
//   String? businessName,
//   required String address, int? categoryId,
//   required int stateId, required String password,
//   String? referralCode, bool? termsAndCondition}) async {
//   Map<String, dynamic>? result;
//   result = {
//     "serviceProviderId": 0,
//     "customerTypeId": customerTypeId,
//     "firstName": firstName,
//     "lastName": lastName,
//     "phoneNumber": phoneNumber,
//     "email": email,
//     "businessName": businessName,
//     "address": address,
//     "categoryId": categoryId,
//     "stateId": stateId,
//     "password": password,
//     "referralCode": referralCode,
//     "termsAndCondition": termsAndCondition
//   };
//   Get.put<LocalCachedData>(await LocalCachedData.create());
//   final token = await LocalCachedData.instance.getAuthToken();
//   var url = "${BASE_URL}Services/register/service/provider/website";
//   var response = await post(url: url, context: context, body: result, token: token);
//   if (response['status']['isSuccessful'] == true) {
//     showMessageSnackBar(context!,
//         title: "Success",
//         content: response['status']['message']['friendlyMessage']);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => OtpVerification(userEmail: email,)));
//   } else {
//     showErrorSnackBar(context!,
//         title: "Something Went Wrong",
//         content: response['status']['message']['friendlyMessage']);
//   }
// }
