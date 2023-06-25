import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/request_model/make_request_response_model.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:get/get.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

import '../../views/widgets/custom_snack.dart';
import 'package:esolink/logic/login/login_controller.dart';


Future<List<RequestsModel>> fetchAllRequest(
    BuildContext? context, String? catID,) async {
  // RequestBLoc requestBLoc = locator.get<RequestBLoc>();
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var url =
      "http://handyhub.goserp.co.uk/Services/all/providers/by/category/and/location/Id?categoryId=$catID&customerId=1";
  var response = await get(url: url, context: context, token: token);
  List<RequestsModel> requestModel;
  requestModel = response['data']['serviceProviders'].map<RequestsModel>((e) {
    return RequestsModel.fromJson(e);
  }).toList();
  print(requestModel);
  return requestModel;
  // requestBLoc.addAllRequest(requestModel);
  // fetchBusinessPhotos(context!, catID);
}

Future<void> makeRequest({required int categoryId, required int serviceProviderId}) async {
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final userDetails = await LocalCachedData.instance.fetchUserDetails();
  final address = userDetails.serviceProviders![0].address;
  final phoneNumber = userDetails.serviceProviders![0].phoneNumber;
  final email = userDetails.serviceProviders![0].email;
  final fullName = userDetails.serviceProviders![0].firstName;
  progressIndicator(Get.context);
  try{
    final body = {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "categoryId": categoryId,
      "location": address,
      "serviceProviderId": serviceProviderId
    };
    var response = await NetworkProvider().call(path: "/Services/update/requested/service", method: RequestMethod.post, body: body,);
    final payLoad = MakeRequestResponse.fromJson(response!.data);
    if(payLoad.status!.isSuccessful == true){
      Get.back();
      showMessageSnackBar(Get.context,
          title: "Successful",
          content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
      Get.offAll(()=> const Dashboard());
    }else{
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Oops!",
          content: payLoad.status?.message?.friendlyMessage ?? "Request failed");
    }
    log(payLoad.status!.message!.friendlyMessage.toString());
  }on DioError catch (err) {
    final errorMessage = Future.error(ApiError.fromDio(err));
    Get.back();
    showErrorSnackBar(Get.context,
        title: "Something Went Wrong",
        content: err.response?.data['title'] ?? errorMessage);
    throw errorMessage;
  } catch (err) {
    Get.back();
    showErrorSnackBar(Get.context,
        title: "Something Went Wrong",
        content: err.toString());
    log(err.toString());
    throw err.toString();
  }
}
