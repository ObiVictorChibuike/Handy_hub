import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/logic/home/controller.dart';
import 'package:esolink/logic/location/get_location.dart';
import 'package:esolink/models/account/update_location_response.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/auth_model/login_response.dart';
import 'package:esolink/models/stores_model/cart_payment_checkout_response.dart';
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
        final controller = Get.put(HomeController());
        final ctrl = Get.put(DeliveryController());
        Get.put(DashboardController());
        final dbc = Get.put(DashboardController());
        Get.put<LocalCachedData>(await LocalCachedData.create());
        await LocalCachedData.instance.cacheAuthToken(token: payLoad.token);
        await LocalCachedData.instance.cacheCustomerEmail(email: username);
        await controller.getCategories();
        await ctrl.getAllRiders();
        await getAuthUser(email: username).then((value) async {
          await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
          // await updateLocation();
          Get.back();
          Get.offAll(()=> const Dashboard());
          dbc.index = 0;
          update();
          showMessageSnackBar(Get.context, title: "Success",
              content: payLoad.status?.message?.friendlyMessage ?? "Login Successful");
        });
      }else{
        Get.back();
        showErrorSnackBar(context, title: "Oops!",
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


  Future<void> updateLocation() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final serviceProviderId = userDetails.serviceProviders![0].serviceProviderId;
    final value = await GetLocation.instance!.checkLocation;
    log(value.longitude.toString());
    try{
      var body = {
        "serviceProviderId": serviceProviderId,
        "latitude": value.latitude.toString(),
        "longitude": value.longitude.toString(),
      };
      var response = await NetworkProvider().call(path: "/Services/update/location", method: RequestMethod.post, body: body,);
      UpdateLocationResponse.fromJson(response!.data);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> updateLocationInit() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final serviceProviderId = userDetails.serviceProviders![0].serviceProviderId;
    final value = await GetLocation.instance!.checkLocation;
    log("This it the longitude ${value.longitude.toString()}");
    try{
      var body = {
        "serviceProviderId": serviceProviderId,
        "latitude": value.latitude.toString(),
        "longitude": value.longitude.toString(),
      };
      var response = await NetworkProvider().call(path: "/Services/update/location", method: RequestMethod.post, body: body,);
      UpdateLocationResponse.fromJson(response!.data);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> getAuthUser({required email}) async {
    try{
      var response = await NetworkProvider().call(path: "/Services/identity/profile?email=$email", method: RequestMethod.get,);
      final payLoad = AuthUserResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await LocalCachedData.instance.saveUserDetails(authUserResponse: payLoad);
        await LocalCachedData.instance.cacheCustomerEmail(email: email);
      }else{
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request denied");
      }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> forgotPassword({required String email, required BuildContext context}) async {
    progressIndicator(context);
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      var body = jsonEncode({"email": email});
      var response = await NetworkProvider().call(path: "/services/forgot/password", method: RequestMethod.post, body: body,);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        Get.back();
        Get.back();
        showMessageSnackBar(context, title: "Success",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Successful"
        );
      }else{
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
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
