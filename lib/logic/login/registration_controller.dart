import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/logic/home/controller.dart';
import 'package:esolink/logic/location/get_location.dart';
import 'package:esolink/models/account/all_state_response.dart';
import 'package:esolink/models/account/update_location_response.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/auth_model/login_response.dart';
import 'package:esolink/models/auth_model/registration_model.dart';
import 'package:esolink/models/dashboard/dashboard_photo_response.dart';
import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/screens/sign_up/otp_screen.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  RegistrationController extends GetxController{
  AllStateResponse? allStateResponse;
  Future<void> getAllStates() async {
    try{
      var response = await NetworkProvider().call(path: "/Category/all/states", method: RequestMethod.get,);
      allStateResponse = AllStateResponse.fromJson(response!.data);
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      throw err.toString();
    }
  }

  List<DashboardPhoto>? dashboardPhotoResponse = <DashboardPhoto>[].obs;


  Future<void> getDashBoardPhoto() async {
    try{
      var response = await NetworkProvider().call(path: "/Category/get/dashboard/photo", method: RequestMethod.get,);
      dashboardPhotoResponse = DashboardPhotoResponse.fromJson(response!.data).dashboardPhoto;
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      throw err.toString();
    }
  }

  Future<void> sendOtp({required String code, required String userEmail, required String password}) async {
    progressIndicator(Get.context);
    final dbc = Get.put(DashboardController());
    try{
      await NetworkProvider().call(path: "/Services/verify/email?code=$code&userId=$userEmail", method: RequestMethod.get,).then((value) async {
        if (value!.data == true) {
          Get.back();
          await login(username: userEmail, password: password).then((value){
            Get.offAll(()=> const Dashboard());
            dbc.index = 0;
            update();
            showMessageSnackBar(Get.context, title: "Success",
                content: value.status?.message?.friendlyMessage ?? "Login Successful");
          });
        } else {
          Get.back();
          showErrorSnackBar(Get.context,
              title: "Something Went Wrong",
              content: "OTP Verification failed");
        }
        update();
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      throw err.toString();
    }
  }

  AllCategoryResponse? allCategoryResponse;
  Future<void> getAllCategory() async {
    try{
      var response = await NetworkProvider().call(path: "/Category/all/category", method: RequestMethod.get,);
      allCategoryResponse = AllCategoryResponse.fromJson(response!.data);
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      throw err.toString();
    }
  }

  RegistrationResponse? registrationResponse;

  Future <void>registerUser({required int customerTypeId, String? firstName, String? lastName,
    required String phoneNumber, required String email,
    String? businessName,
    required String address, int? categoryId,
    required int stateId, required String password,
    String? referralCode, bool? termsAndCondition}) async {
    final value = await GetLocation.instance!.checkLocation;
    progressIndicator(Get.context);
    var body = {
      "serviceProviderId": 0,
      "customerTypeId": customerTypeId,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "businessName": businessName,
      "address": address,
      "categoryId": categoryId,
      "stateId": stateId,
      "password": password,
      "referralCode": referralCode,
      "termsAndCondition": termsAndCondition,
      "latitude": value.latitude,
      "longitude": value.longitude,
    };
    try{
      var response = await NetworkProvider().call(path: "/Services/register/service/provider/website", method: RequestMethod.post, body: body);
      registrationResponse = RegistrationResponse.fromJson(response!.data);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      // await LocalCachedData.instance.cacheAuthToken(token: registrationResponse.);
      if(registrationResponse?.status?.isSuccessful == true){
        // await updateLocation();
        Get.back();
        Get.offAll(()=>OtpVerification(userEmail: email,password: password,));
        showMessageSnackBar(Get.context, title: "Success",
            content: registrationResponse?.status?.message?.friendlyMessage ?? "Request Successful"
        );
      }else{
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: registrationResponse?.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      throw err.toString();
    }
  }

  final List<AllCategory> allCategory = <AllCategory>[];

  @override
  void onInit() {
    getDashBoardPhoto();
    ApiServices().getAllCategories().then((data){
      allCategory.addAll(data);
      update();
    });
    getAllStates();
    getAllCategory();
    super.onInit();
  }


  LoginResponse? loginResponse;
  Future<LoginResponse> login({required String username, required String password}) async {
    try{
      var body = {
        "username": username,
        "password": password,
      };
      var response = await NetworkProvider().call(path: "/Services/identity/login", method: RequestMethod.post, body: body,);
      final payLoad = LoginResponse.fromJson(response!.data);
      loginResponse = payLoad;
      if(payLoad.status?.isSuccessful == true){
        final controller = Get.put(HomeController());
        final ctrl = Get.put(DeliveryController());
        Get.put(DashboardController());
        Get.put<LocalCachedData>(await LocalCachedData.create());
        await LocalCachedData.instance.cacheAuthToken(token: payLoad.token);
        await LocalCachedData.instance.cacheCustomerEmail(email: username);
        await controller.getCategories();
        await ctrl.getAllRiders();
        await getAuthUser(email: username, context: Get.context!).then((value) async {
          await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
          // await updateLocation();
        });
        return payLoad;
      }else{
        Get.back();
        showErrorSnackBar(Get.context, title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Login denied, Please check your credentials");
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
    return loginResponse!;
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