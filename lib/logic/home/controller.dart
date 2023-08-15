import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/location/get_location.dart';
import 'package:esolink/models/account/update_location_response.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/models/stores_model/cart_payment_checkout_response.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  bool? onCategoryHasData;
  List<Category> categories = <Category>[].obs;

  Future<List<Category>> getCategories() async {
    onCategoryHasData = false;
    update();
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final token = await LocalCachedData.instance.getAuthToken();
    var url = "$BASE_URL/Category/all/category/dashboard";
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse(url),headers: headers,);

    if (response.statusCode == 200){
      var categoriesJson = json.decode(response.body);
        categories = CategoriesModel.fromJson(categoriesJson).category!;
      onCategoryHasData = true;
      update();
    }
    return categories;

    // final List responseData = json.decode(response.body)['data']['category'];
    // categoriesModel.add(json.decode(response.body)['data']['category']);
    // print(categoriesModel);
    // return categoriesModel = json.decode(response.body)['data']['category'].map<CategoriesModel>((e) {
    //   return CategoriesModel.fromJson(e);
    // }).toList();
  }


  Future<void> fundWallet({required int amount, required String transactionRef, required BuildContext context}) async {
    progressIndicator(context);
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = jsonEncode({
        "customerId": customerId,
        "amount": amount,
        "transactionRef": transactionRef,
        "paymentStatus": true,
      });
      var response = await NetworkProvider().call(path: "/Stores/update/wallet/fund", method: RequestMethod.post, body: body,);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
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

  Future<void> updateLocation() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final serviceProviderId = userDetails.serviceProviders![0].serviceProviderId;
    final value = await GetLocation.instance!.checkLocation;
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
      throw errorMessage;
    } catch (err) {
      throw err.toString();
    }
  }
  Future<void> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    if(isLoggedIn == true){
      await updateLocation();
    }else{
      null;
    }
  }


  @override
  void onInit() {
    getCategories();
    checkLoginStatus();
    super.onInit();
  }
}