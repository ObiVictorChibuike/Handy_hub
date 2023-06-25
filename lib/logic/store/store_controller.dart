import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/stores_model/add_to_cart_response.dart';
import 'package:esolink/models/stores_model/cart_payment_checkout_response.dart';
import 'package:esolink/models/stores_model/increase_cart_item_response.dart';
import 'package:esolink/models/stores_model/product_details.dart';
import 'package:esolink/models/stores_model/store_response.dart';
import 'package:esolink/models/stores_model/total_cart_item.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class  StoreController extends GetxController{

  Future<void> addItemToCart({required int productId,required int vendorId,required int quantity,required int amount,required int customerId, required BuildContext context}) async {
    progressIndicator(context);
    log("chjcbbxchbcxbj");
    update();
    try{
      var body = {
        "productId": productId,
        "vendorId": vendorId,
        "quantity": quantity,
        "amount": amount,
        "customerId": customerId,
      };
      var response = await NetworkProvider().call(path: "/Stores/update/store/cart", method: RequestMethod.post, body: body,);
      final payLoad = AddItemToCartResponse.fromJson(response!.data);
      if(payLoad.status!.isSuccessful == true){
        await getTotalCartItemInit(context: context);
        update();
        Get.back();
      }else{
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request failed"
        );
      }
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      throw err.toString();
    }
  }

  List<StoreProduct>? storeProductList = <StoreProduct>[].obs;
  TotalCartItemResponse? totalCartItemResponse;

  // Future<TotalCartItemResponse> getTotalCartItem({required BuildContext context}) async {
  //   Get.put<LocalCachedData>(await LocalCachedData.create());
  //   final userDetails = await LocalCachedData.instance.fetchUserDetails();
  //   final customerId = userDetails.serviceProviders![0].serviceProviderId;
  //   // try{
  //     var response = await NetworkProvider().call(path: "/Stores/all/store/cart?id=$customerId", method: RequestMethod.get,);
  //     final payLoad = TotalCartItemResponse.fromJson(response!.data);
  //     return payLoad;
  //   // }on DioError catch (err) {
  //   //   final errorMessage = Future.error(ApiError.fromDio(err));
  //   //   Get.back();
  //   //   showErrorSnackBar(context,
  //   //       title: "Something Went Wrong",
  //   //       content: err.response?.data['title'] ?? errorMessage);
  //   //   update();
  //   //   throw errorMessage;
  //   // } catch (err) {
  //   //   Get.back();
  //   //   showErrorSnackBar(context,
  //   //       title: "Something Went Wrong",
  //   //       content: err.toString());
  //   //   update();
  //   //   throw err.toString();
  //   // }
  // }

  ProductDetails? productDetails;
  bool? isLoadingProductDetails;
  bool? isLoadingProductDetailsHasError;


  Future<void> getProductDetails({required int id, required BuildContext context}) async {
    isLoadingProductDetails = true;
    update();
    try{
      var response = await NetworkProvider().call(path: "/Stores/single/product/Id?Id=$id", method: RequestMethod.get,);
      final payLoad = ProductDetails.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        productDetails = payLoad;
        log("HaData");
        isLoadingProductDetails = false;
        update();
      }else{
        isLoadingProductDetails = false;
        update();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request denied");
      }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      isLoadingProductDetails = false;
      isLoadingProductDetailsHasError = true;
      update();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      isLoadingProductDetails = false;
      isLoadingProductDetailsHasError = true;
      update();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      throw err.toString();
    }
  }


  Future<void> directPaymentCheckOut({required int amount, required BuildContext context}) async {
    progressIndicator(context);
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      final body = {
        "amount": amount,
        "customerId": customerId
      };
      update();
      var response = await NetworkProvider().call(path: "/Stores/update/store/checkout/wallet", method: RequestMethod.post, body: body);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true ){
        await getTotalCartItemInit(context: context);
        Get.back();
        showMessageSnackBar(context,
            title: "Success",
            content: payLoad.status?.message?.friendlyMessage ?? "Transaction Complete"
        );
        update();
      }else{
        Get.back();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Transaction Incomplete"
        );
        update();
      }
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      Get.back();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
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


  Future<void> cardCheckOut({required String txRef, required BuildContext context}) async {
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      final body = {
        "customerId": customerId,
        "transactionRef": txRef,
      };
      update();
      var response = await NetworkProvider().call(path: "/Stores/update/store/checkout", method: RequestMethod.post, body: body);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true ){
        await getTotalCartItemInit(context: context);
        showErrorSnackBar(context,
            title: "Success",
            content: payLoad.status?.message?.friendlyMessage ?? "Transaction Complete"
        );
        update();
      }else{
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Transaction Incomplete"
        );
        update();
      }
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

  bool? isLoading;

  Future<void> getTotalCartItemInit({required BuildContext context}) async {
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      log(customerId.toString());
      log("lol");
      isLoading = true;
      update();
      var response = await NetworkProvider().call(path: "/Stores/all/store/cart?id=$customerId", method: RequestMethod.get,);
      final payLoad = TotalCartItemResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true ){
        totalCartItemResponse = payLoad;
        isLoading = false;
        log("begin");
        update();
      }else{
        isLoading = false;
        log("fale meage");
        update();
        showErrorSnackBar(context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request denied");
      }
    }on DioError catch (err) {
      isLoading = false;
      log("error1");
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      log("error2");
      isLoading = false;
      update();
      showErrorSnackBar(context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> increaseQuantity({required int cartId, required int productId, required int quantity, required BuildContext context}) async {
    progressIndicator(context);
    try{
      final body = {
        "cartId": cartId,
        "productId": productId,
        "quantity": quantity
      };
      var response = await NetworkProvider().call(path: "/Stores/add/cart/quantity", method: RequestMethod.post, body: body);
      final payLoad = IncreaseCartItemResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getTotalCartItemInit(context: context);
        update();
        Get.back();
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

  Future<void> decreaseQuantity({required int cartId, required int productId, required int quantity, required BuildContext context}) async {
    progressIndicator(context);
    try{
      final body = {
        "cartId": cartId,
        "productId": productId,
        "quantity": quantity
      };
      var response = await NetworkProvider().call(path: "/Stores/subtract/cart/quantity", method: RequestMethod.post, body: body);
      final payLoad = IncreaseCartItemResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getTotalCartItemInit(context: context);
        update();
        Get.back();
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

  Future<void> removeItemFromCart({required int cartId, required BuildContext context}) async {
    progressIndicator(context);
    try{
      var response = await NetworkProvider().call(path: "/Stores/delete/cart?cartId=$cartId", method: RequestMethod.get);
      /// get the sample response from postman
      final payLoad = IncreaseCartItemResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        await getTotalCartItemInit(context: context);
        update();
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