import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/auth_model/login_response.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController{
  Future<void> login({required String username, required String password, required BuildContext context}) async {
    progressIndicator(context);
    try{
      var body = {
        "username": username,
        "password": password,
      };
      var response = await NetworkProvider().call(path: "/Services/identity/login", method: RequestMethod.post, body: body,);
      final payLoad = LoginResponse.fromJson(response!.data);

      if(payLoad.status?.isSuccessful == true && context.mounted){
        Get.put<LocalCachedData>(await LocalCachedData.create());
        await LocalCachedData.instance.cacheAuthToken(token: payLoad.token);
        await LocalCachedData.instance.cacheCustomerEmail(email: username);
        await getAuthUser(email: username, context: context).then((value) async {
          Get.back();
          await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
          showMessageSnackBar(context, title: "Success",
          content: payLoad.status?.message?.friendlyMessage ?? "Login Successful");
          Get.offAll(()=> const Dashboard());
        });
      }else{
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Login denied, Please check your credentials");
      }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> getAuthUser({required email, required BuildContext context}) async {
    try{
      var response = await NetworkProvider().call(path: "/Services/identity/profile?email=$email", method: RequestMethod.get,);
      final payLoad = AuthUserResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await LocalCachedData.instance.saveUserDetails(authUserResponse: payLoad);
      }else{
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request denied");
      }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }
}
