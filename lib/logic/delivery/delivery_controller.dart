import 'dart:developer';
import 'package:esolink/models/delivery_model/cash_payment_response.dart';
import 'package:esolink/models/delivery_model/create_delivery_request_model.dart';
import 'package:esolink/models/delivery_model/wallet_payment_response.dart';
import 'package:esolink/models/stores_model/cart_payment_checkout_response.dart';
import 'package:esolink/models/stores_model/increase_cart_item_response.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/models/delivery_model/all_delivery_model_response.dart';
import 'package:esolink/models/delivery_model/all_riders_model_response.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController{
  double? lat;
  double? long;
  List<Delivery>? delivery = <Delivery>[].obs;
  bool? isLoadingAllDeliveryResponse;
  int? customerId;
  final _ctrl = Get.put(DashboardController());

  switchTab(){
    Get.offAll(()=>const Dashboard());
    _ctrl.index = 2;
    update();
  }

  Future<void> fetchAllDelivery() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getLoginStatus().then((value) async {
      if(value == true){
        final userDetails = await LocalCachedData.instance.fetchUserDetails();
        customerId = userDetails.serviceProviders![0].serviceProviderId;
        isLoadingAllDeliveryResponse = true;
        update();
        try{
          log("loading");
          var response = await NetworkProvider().call(path: "/Stores/all/delivery/by/customer?customerId=$customerId", method: RequestMethod.get,);
          delivery = AllDeliveryResponseModel.fromJson(response!.data).delivery?.map<Delivery>((e) {
            return e;
          }).toList();
          isLoadingAllDeliveryResponse = false;
          log("success");
          update();
          return delivery!;
        }on DioError catch (err) {
          isLoadingAllDeliveryResponse = false;
          final errorMessage = Future.error(ApiError.fromDio(err));
          log("dio error");
          update();
          throw errorMessage;
        } catch (err) {
          isLoadingAllDeliveryResponse = false;
          log("catch error");
          update();
          throw err.toString();
        }
      }else{
        delivery = <Delivery>[].obs;
        isLoadingAllDeliveryResponse = false;
        update();
      }
    });
  }

  bool? onRiderHasData;
  AllRiderResponseModel? allRiderResponseModel;

  Future<void> getAllRiders() async {
    log("viole");
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getLoginStatus().then((value) async {
      if(value ==true){
        final userDetails = await LocalCachedData.instance.fetchUserDetails();
        final customerId = userDetails.serviceProviders![0].serviceProviderId;
        onRiderHasData = true;
        update();
        try{
          var response = await NetworkProvider().call(path: "/Services/all/riders/by/location?customerId=$customerId", method: RequestMethod.get,);
          allRiderResponseModel = AllRiderResponseModel.fromJson(response!.data);
          log(allRiderResponseModel!.serviceProviders.toString());
          onRiderHasData = false;
          update();
          return allRiderResponseModel!;
        }on DioError catch (err) {
          onRiderHasData = false;
          final errorMessage = Future.error(ApiError.fromDio(err));
          update();
          throw errorMessage;
        } catch (err) {
          onRiderHasData = false;
          update();
          throw err.toString();
        }
      }else{
        allRiderResponseModel = null;
        onRiderHasData = false;
        update();
      }
    });
  }

  Future<void> editDeliveryRequest({required int deliveryId, required String senderName, required String senderPhoneNumber,
    required String pickupLocation, required String receiverName, required String phoneNumber, required String deliveryLocation,
    required String packageDetails, required int? riderId,
    required BuildContext context}) async {
    progressIndicator(context);
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = {
        "deliveryId": deliveryId,
        "senderName": senderName,
        "senderPhoneNumber": senderPhoneNumber,
        "pickupLocation": pickupLocation,
        "receiverName": receiverName,
        "phoneNumber": phoneNumber,
        "deliveryLocation": deliveryLocation,
        "packageDetails": packageDetails,
        "riderId": riderId,
        "customerId": customerId
      };
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/service", method: RequestMethod.post, body: body,);
      final payLoad = CreateDeliveryResponseModel.fromJson(response!.data);

      if(payLoad.status?.isSuccessful == true && context.mounted){
        await fetchAllDelivery();
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

  Future<void> updateDeliveryStatus({required int deliveryStatus, required int deliveryId,
    required BuildContext context}) async {
    progressIndicator(context);
    log("1");
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = {
        "deliveryStatus":4,
        "customerId": customerId,
        "deliveryId":deliveryId
      };
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/service/status", method: RequestMethod.post, body: body,);
      final payLoad = CreateDeliveryResponseModel.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted == true){
        log("2");
        await fetchAllDelivery();
        Get.back();
        showMessageSnackBar(context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      log("5");
      Get.back();
      log(err.toString());
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> payFromWallet({required int amount, required int deliveryId}) async {
    progressIndicator(Get.context);
    try{
      var body = {
        "amount": amount,
        "deliveryId":deliveryId
      };
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/checkout/wallet", method: RequestMethod.post, body: body,);
      final payLoad = WalletPaymentResponse.fromJson(response!.data);
        log(payLoad.status!.isSuccessful.toString());
        if(payLoad.status?.isSuccessful == true){
          await fetchAllDelivery().then((value){
            showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
            Get.back();
          });
        }else{
          Get.back();
          showErrorSnackBar(Get.context,
              title: "Oops!",
              content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
          );
        }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(Get.context, title: "Something Went Wrong", content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      Get.back();
      showErrorSnackBar(Get.context, title: "Something Went Wrong", content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> payFromCash({required int amount, required int deliveryId}) async {
    progressIndicator(Get.context);
    try{
      var body = {
        "amount": amount,
        "deliveryId":deliveryId
      };
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/checkout/cash", method: RequestMethod.post, body: body,);
      final payLoad = CashPaymentResponse.fromJson(response!.data);
        showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        if(payLoad.status?.isSuccessful == true){
          await fetchAllDelivery().then((value){
            Get.back();
          });
        }else{
          Get.back();
          showErrorSnackBar(Get.context,
              title: "Oops!",
              content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
          );
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
      log("5");
      Get.back();
      log(err.toString());
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> cardCheckOut({required String txRef, required int amount, required BuildContext context}) async {
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      final body = {
        "customerId": customerId,
        "transactionRef": txRef,
        "amount": amount,
        "paymentStatus": true,
      };
      update();
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/checkout", method: RequestMethod.post, body: body);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showMessageSnackBar(context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        if(payLoad.status?.isSuccessful == true && context.mounted){
          await fetchAllDelivery().then((value){
            Get.back();
          });
        }else{
          Get.back();
          showErrorSnackBar(context,
              title: "Oops!",
              content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
          );
        }
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> removeDeliveryRecord({required int deliveryId, required BuildContext context}) async {
    progressIndicator(context);
    try{
      var response = await NetworkProvider().call(path: "/Stores/delete/delivery?deliveryId=$deliveryId", method: RequestMethod.get);
      final payLoad = CashPaymentResponse.fromJson(response!.data);
      /// get the sample response from postman
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showMessageSnackBar(context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        if(payLoad.status?.isSuccessful == true && context.mounted){
          await fetchAllDelivery().then((value){
            Get.back();
          });
        }else{
          Get.back();
          showErrorSnackBar(context,
              title: "Oops!",
              content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
          );
        }
      });
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

  Future<void> addDeliveryRequest({required String senderName, required String senderPhoneNumber,
    required String pickupLocation, required String receiverName, required String phoneNumber, required String deliveryLocation,
    required String packageDetails, required int? riderId,
    required BuildContext context}) async {
    progressIndicator(context);
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = {
        "deliveryId": 0,
        "senderName": senderName,
        "senderPhoneNumber": senderPhoneNumber,
        "pickupLocation": pickupLocation,
        "receiverName": receiverName,
        "phoneNumber": phoneNumber,
        "deliveryLocation": deliveryLocation,
        "packageDetails": packageDetails,
        "riderId": riderId,
        "customerId": customerId
      };
      var response = await NetworkProvider().call(path: "/Stores/update/delivery/service", method: RequestMethod.post, body: body,);
      final payLoad = CreateDeliveryResponseModel.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        await fetchAllDelivery();
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

  @override
  void onInit() {
    getAllRiders();
    super.onInit();
  }
}