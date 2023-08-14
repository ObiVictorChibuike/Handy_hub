import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/models/account/add_reminder_response.dart';
import 'package:esolink/models/account/all_products_response.dart';
import 'package:esolink/models/account/all_reminder_response.dart';
import 'package:esolink/models/account/all_requested_services.dart';
import 'package:esolink/models/account/all_response_response.dart';
import 'package:esolink/models/account/change_password_response.dart';
import 'package:esolink/models/account/contact_us_response.dart';
import 'package:esolink/models/account/delete_product_response.dart';
import 'package:esolink/models/account/job_response_model.dart';
import 'package:esolink/models/account/payment_request_response.dart';
import 'package:esolink/models/account/postpone_reminder_response.dart';
import 'package:esolink/models/account/product_category_response.dart';
import 'package:esolink/models/account/profile_response.dart';
import 'package:esolink/models/account/rating_response.dart';
import 'package:esolink/models/account/update_job_status_response.dart';
import 'package:esolink/models/delivery_model/create_delivery_request_model.dart';
import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/models/stores_model/cart_payment_checkout_response.dart';
import 'package:esolink/models/stores_model/increase_cart_item_response.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AccountController extends GetxController{
  int page = 1;
  final int _limit = 20;
  List<RequestedServices>? requestedServices = <RequestedServices>[].obs;
  Future<void> _firstLoad()async{
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    try{
      var response = await NetworkProvider().call(path: "/Services/requested/services/by/customerId/pagination?PageNumber=$page&PageSize=$_limit&PageId=$customerId", method: RequestMethod.get,);
        requestedServices = AllRequestedServicesResponse.fromJson(response!.data).response?.data;
        update();
    }catch(err){
      update();
      throw err.toString();
    }
  }
  bool hasReminder = false;
  AllReminderResponse? allReminderResponse;

  Future<void> getAllReminder() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    hasReminder = false;
    update();
    try{
      var response = await NetworkProvider().call(path: "/Services/all/reminder/customerId?customerId=$customerId", method: RequestMethod.get,);
      allReminderResponse = AllReminderResponse.fromJson(response!.data);
      hasReminder = true;
      update();
    }on dio.DioError catch (err) {
      hasReminder = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      hasReminder = false;
      update();
      throw err.toString();
    }
  }

  final _ctrl = Get.put(DashboardController());

  switchTab(){
    Get.offAll(()=> const Dashboard());
    _ctrl.index = 2;
    update();
  }


  ProfileResponse? profileResponse;
  bool hasProfile = false;

  Future<void> getProfile() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    hasProfile = false;
    update();
    try{
      var response = await NetworkProvider().call(path: "/services/all/service/providers/Id?Id=$customerId", method: RequestMethod.get,);
      profileResponse = ProfileResponse.fromJson(response!.data);
      hasProfile = true;
      update();
    }on dio.DioError catch (err) {
      hasProfile = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      hasProfile = false;
      update();
      throw err.toString();
    }
  }


  bool hasJobs = false;
  JobResponseModel? jobResponseModel;

  Future<void> getAllJobs() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    hasJobs = false;
    update();
    try{
      var response = await NetworkProvider().call(path: "/services/requested/services/provider?Id=$customerId", method: RequestMethod.get,);
      jobResponseModel = JobResponseModel.fromJson(response!.data);
      hasJobs = true;
      update();
    }on dio.DioError catch (err) {
      hasJobs = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      hasJobs = false;
      update();
      throw err.toString();
    }
  }

  List<VendorProduct>? vendorProduct = <VendorProduct>[].obs;
  bool? hasProduct;
  AllRequestedServicesResponse? allRequestedServicesResponse;
  bool hasRequestedServices = false;

  Future<void> getAllVendorProducts() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
        final userDetails = await LocalCachedData.instance.fetchUserDetails();
        final customerId = userDetails.serviceProviders![0].serviceProviderId;
        hasProduct = false;
        update();
        try{
          log("1");
          var response = await NetworkProvider().call(path: "/Stores/all/products/by/vendor/setup?Id=$customerId", method: RequestMethod.get,);
          vendorProduct = AllVendorProductResponse.fromJson(response!.data).product;
          hasProduct = true;
          log("2");
          update();
        }on dio.DioError catch (err) {
          hasProduct = false;
          log("3");
          final errorMessage = Future.error(ApiError.fromDio(err));
          update();
          throw errorMessage;
        } catch (err) {
          log(err.toString());
          hasProduct = false;
          update();
          throw err.toString();
        }
  }

  // Future<void> getAllRequestedServices() async {
  //   Get.put<LocalCachedData>(await LocalCachedData.create());
  //   final userDetails = await LocalCachedData.instance.fetchUserDetails();
  //   final customerId = userDetails.serviceProviders![0].serviceProviderId;
  //   hasRequestedServices = false;
  //   update();
  //   try{
  //     var response = await NetworkProvider().call(path: "/Services/requested/services/by/customerId?customerId=$customerId", method: RequestMethod.get,);
  //     allRequestedServicesResponse = AllRequestedServicesResponse.fromJson(response!.data);
  //     hasRequestedServices = true;
  //     update();
  //   }on dio.DioError catch (err) {
  //     hasRequestedServices = false;
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     update();
  //     throw errorMessage;
  //   } catch (err) {
  //     hasRequestedServices = false;
  //     update();
  //     throw err.toString();
  //   }
  // }

  @override
  void onInit() {
    getAllProductCategory();
    getAllCategory();
    super.onInit();
  }

  bool? onHasCategory;
  ProductCategoryResponse? productCategoryResponse;

  Future<void> getAllProductCategory() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getLoginStatus().then((value) async {
      if(value ==true){
        onHasCategory = true;
        update();
        try{
          var response = await NetworkProvider().call(path: "/Stores/all/store/category", method: RequestMethod.get,);
          productCategoryResponse = ProductCategoryResponse.fromJson(response!.data);
          onHasCategory = false;
          update();
          return productCategoryResponse!;
        }on dio.DioError catch (err) {
          onHasCategory = false;
          final errorMessage = Future.error(ApiError.fromDio(err));
          update();
          throw errorMessage;
        } catch (err) {
          onHasCategory = false;
          update();
          throw err.toString();
        }
      }else{
        productCategoryResponse = null;
        onHasCategory = false;
        update();
      }
    });
  }

  void onUploadImage(ImageSource source, int index) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if(index == 0 && pickedFile != null){
        photo1 = pickedFile;
        final imageBytes = File(photo1!.path).readAsBytesSync();
        convertProduct1 = base64Encode(imageBytes);
        update();
      }else if(index == 1 && pickedFile != null){
        photo2 = pickedFile;
        final imageBytes = File(photo2!.path).readAsBytesSync();
        convertProduct2 = base64Encode(imageBytes);
        update();
      }else if(index == 2 && pickedFile != null){
        photo3 = pickedFile;
        final imageBytes = File(photo3!.path).readAsBytesSync();
        convertProduct3 = base64Encode(imageBytes);
        update();
      }else if(index == 3 && pickedFile != null){
        photo4 = pickedFile;
        final imageBytes = File(photo4!.path).readAsBytesSync();
        convertProduct4 = base64Encode(imageBytes);
        update();
      }
      log(images.length.toString());
      convertProduct1 != null ? images.add("data:image/jpeg;base64,${convertProduct1!}") :
      convertProduct2 != null ? images.add("data:image/jpeg;base64,${convertProduct2!}") :
      convertProduct3 != null ? images.add("data:image/jpeg;base64,${convertProduct3!}") :
      convertProduct4 != null ? images.add("data:image/jpeg;base64,${convertProduct4!}") :
      null;
      update();
    } catch (e) {
      final pickImageError = e;
      update();
    }
  }

  final picker = ImagePicker();
 List<String> images = <String>[];
  XFile? photo1;
  XFile? photo2;
  XFile? photo3;
  XFile? photo4;

  String? convertProduct1;
  String? convertProduct2;
  String? convertProduct3;
  String? convertProduct4;

  List<XFile> productImages = <XFile>[].obs;

  void onAddProductImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      productImages.add(pickedFile!);
      update();
    } catch (e) {
      final pickImageError = e;
      update();
    }
  }

  Future<void> deletePhoto({required String id}) async {
    progressIndicator(Get.context!);
    try{
      var response = await NetworkProvider().call(path: "/Stores/delete/product/photo?productPhotoId=$id", method: RequestMethod.get);
      /// get the sample response from postman
      final payLoad = IncreaseCartItemResponse.fromJson(response!.data);
      update();
      if(payLoad.status?.isSuccessful == true){
        await getAllVendorProducts().then((value){
          Get.back();
          Get.back();
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          update();
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
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> addProduct({required int productId, required String name,
    required int amount, required int categoryId, required String description,
    required bool status, required BuildContext context}) async {
    progressIndicator(context);
    try{
      log(images.length.toString());
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = jsonEncode({
        "productId": productId,
        "name": name,
        "amount": amount,
        "categoryId": categoryId,
        "vendorId": customerId,
        "images": images,
        "description": description,
        "active": status
      });
      var response = await NetworkProvider().call(path: "/Stores/update/product", method: RequestMethod.post, body: body,);
      final payLoad = CreateDeliveryResponseModel.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        await getAllVendorProducts();
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
    }on dio.DioError catch (err) {
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

  Future<void> editProduct({required int productId, required String name, required List<String?> images,
    required num amount, required int categoryId, required String description,
    required bool status, required BuildContext context}) async {
    progressIndicator(context);
    try{
      log(images.length.toString());
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      var body = jsonEncode({
        "productId": productId,
        "name": name,
        "amount": amount,
        "categoryId": categoryId,
        "vendorId": customerId,
        "images": images,
        "description": description,
        "active": status
      });
      var response = await NetworkProvider().call(path: "/Stores/update/product", method: RequestMethod.post, body: body,);
      final payLoad = CreateDeliveryResponseModel.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true && context.mounted){
        await getAllVendorProducts();
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
    }on dio.DioError catch (err) {
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

  Future<void> payFromWallet({required int amount, required int requestId,
    required BuildContext context}) async {
    progressIndicator(context);
    try{
      var body = {"amount":amount,"requestId":requestId};
      var response = await NetworkProvider().call(path: "/Services/update/service/checkout/wallet", method: RequestMethod.post, body: body,);
      final payLoad = PaymentRequestResponse.fromJson(response!.data);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showMessageSnackBar(context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        log(payLoad.status!.isSuccessful.toString());
        if(payLoad.status?.isSuccessful == true && context.mounted){
          await _firstLoad().then((value){
            update();
            Get.back();
          });
        }else{
          Get.back();
          showErrorSnackBar(context, title: "Oops!", content: payLoad.status?.message?.friendlyMessage ?? "Request Failed");
        }
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      showErrorSnackBar(context, title: "Something Went Wrong", content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      Get.back();
      showErrorSnackBar(context, title: "Something Went Wrong", content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> payFromCash({required int amount, required int requestId}) async {
    progressIndicator(Get.context);
    try{
      log("1");
      var body = {
        "amount": amount,
        "requestId": requestId
      };
      var response = await NetworkProvider().call(path: "/Services/update/service/checkout/cash", method: RequestMethod.post, body: body,);
      final payLoad = PaymentRequestResponse.fromJson(response!.data);
        if(payLoad.status?.isSuccessful == true){
          await _firstLoad().then((value){
            log("Done");
            showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
            Get.back();
          });
        }else{
          log("3");
          Get.back();
          showErrorSnackBar(Get.context,
              title: "Oops!",
              content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
          );
        }
    }on DioError catch (err) {
      log("4");
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


  Future<void> cardCheckOut({required String txRef, required int amount, required BuildContext context, required int requestId}) async {
    try{
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = await LocalCachedData.instance.fetchUserDetails();
      final customerId = userDetails.serviceProviders![0].serviceProviderId;
      final body = {
        "customerId": customerId,
        "amount": amount,
        "transactionRef": txRef,
        "paymentStatus":true,
        "requestId":requestId
      };
      update();
      var response = await NetworkProvider().call(path: "/Services/update/service/checkout", method: RequestMethod.post, body: body);
      final payLoad = CardPaymentCheckoutResponse.fromJson(response!.data);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showMessageSnackBar(context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        if(payLoad.status?.isSuccessful == true && context.mounted){
          await _firstLoad().then((value){
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

  List<Order>? order = <Order>[].obs;
  bool? isLoadingAllOrderResponse;


  Future<void> fetchAllOrder() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getLoginStatus().then((value) async {
      if(value == true){
        final userDetails = await LocalCachedData.instance.fetchUserDetails();
        final customerId = userDetails.serviceProviders![0].serviceProviderId;
        isLoadingAllOrderResponse = true;
        update();
        try{
          log("loading");
          var response = await NetworkProvider().call(path: "/Stores/all/store/order?customerId=$customerId", method: RequestMethod.get,);
          order = AllOrderResponse.fromJson(response!.data).order?.map<Order>((e) {
            return e;
          }).toList();
          isLoadingAllOrderResponse = false;
          log("success");
          update();
          return order!;
        }on DioError catch (err) {
          isLoadingAllOrderResponse = false;
          final errorMessage = Future.error(ApiError.fromDio(err));
          log("dio error");
          update();
          throw errorMessage;
        } catch (err) {
          isLoadingAllOrderResponse = false;
          log("catch error");
          log(err.toString());
          update();
          throw err.toString();
        }
      }else{
        order = <Order>[].obs;
        isLoadingAllOrderResponse = false;
        update();
      }
    });
  }


  Future<void> rateUs({required int requestId, required int ratingNumber}) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    progressIndicator(Get.context);
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final email = userDetails.serviceProviders![0].email;
    try{
      log("1");
      var body = {
        "requestId": requestId,
        "customerEmail": email,
        "numberRating": ratingNumber
      };
      var response = await NetworkProvider().call(path: "/Services/update/job/rating", method: RequestMethod.post, body: body,);
      final payLoad = RatingResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await _firstLoad().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          Get.back();
        });
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
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

  Future<void> deleteRequest({required int requestId}) async {
    progressIndicator(Get.context);
    try{
      var response = await NetworkProvider().call(path: "/Services/delete/requested/service?Id=$requestId", method: RequestMethod.get,);
      final payLoad = RatingResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await _firstLoad().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          Get.back();
        });
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
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


  Future<void> deleteProduct({required String productId}) async {
    progressIndicator(Get.context);
    try{
      var response = await NetworkProvider().call(path: "/Stores/delete/product?Id=$productId", method: RequestMethod.get,);
      final payLoad = DeleteProductResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getAllVendorProducts().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          Get.back();
        });
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
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

  Future<void> changePassword({required String oldPassword, required String newPassword, required String confirmPassword}) async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final email = userDetails.serviceProviders![0].email;
    try{
      var body = {"email": email,"oldPassword": oldPassword,"newPassword": newPassword,"confirmPassword": confirmPassword};
      var response = await NetworkProvider().call(path: "/Services/change/password", method: RequestMethod.post, body: body,);
      final payLoad = ChangePasswordResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        Get.back();
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
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> contactUs({required String subject, required String message}) async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final email = userDetails.serviceProviders![0].email;
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    try{
      var body = {"email": email,"message": message,"subject": subject,"customerId": customerId};
      var response = await NetworkProvider().call(path: "/Services/update/contact/us", method: RequestMethod.post, body: body,);
      final payLoad = ContactUsResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
        Get.back();
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
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }


  Future<void> updateStatus({required int requestId, required String name, required int status}) async {
    progressIndicator(Get.context);
    try{
      log("1");
      var body = {"fullName": name,"requestId": requestId,"jobStatusId": status};
      var response = await NetworkProvider().call(path: "/services/update/job/status", method: RequestMethod.post, body: body,);
      final payLoad = UpdateStatusResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await _firstLoad().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          Get.back();
        });
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
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


  Future<void> postpone({required int reminderId, required int days}) async {
    progressIndicator(Get.context);
    try{
      var body = {"days":days,"reminderId":reminderId};
      var response = await NetworkProvider().call(path: "/Services/postpone/reminder", method: RequestMethod.post, body: body,);
      final payLoad = PostponeReminderResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getAllReminder().then((value){
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

  Future<void> delete({required int reminderId, required int days}) async {
    progressIndicator(Get.context);
    try{
      var response = await NetworkProvider().call(path: "/Services/delete/reminder?reminderId=$reminderId", method: RequestMethod.get,);
      final payLoad = PostponeReminderResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getAllReminder().then((value){
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

  Future<void> dismiss({required int reminderId}) async {
    progressIndicator(Get.context);
    try{
      var response = await NetworkProvider().call(path: "/Services/delete/reminder?reminderId=$reminderId", method: RequestMethod.get,);
      final payLoad = PostponeReminderResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getAllReminder().then((value){
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

  ApiServices apiServices = ApiServices();


  final List<AllCategory> categories = <AllCategory>[];

  Future <void> getAllCategory() async {
    await apiServices.getAllCategories().then((value){
      categories.addAll(value);
    });
  }

  Future<void> addReminder({required int reminderId, required int serviceProviderId,
    required int categoryId, required String datetime, required int reminderStatus}) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    progressIndicator(Get.context);
    try{
      var body = {
        "reminderId": reminderId,
        "serviceProviderId": serviceProviderId,
        "customerId": customerId,
        "categoryId": categoryId,
        "reminderDate": DateFormat("MM/dd/yyyy").parse(datetime.toString()).toIso8601String(),
        "reminderStatus":reminderStatus
      };
      var response = await NetworkProvider().call(path: "/Services/update/reminder", method: RequestMethod.post, body: body,);
      final payLoad = AddReminderResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getAllReminder().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          Get.back();
          Get.back();
        });
      }else{
        log("3");
        Get.back();
        showErrorSnackBar(Get.context,
            title: "Oops!",
            content: payLoad.status?.message?.friendlyMessage ?? "Request Failed"
        );
      }
    }on DioError catch (err) {
      log("4");
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
  XFile? imageFile;
  String? imageUrl;
  void onUploadProfileImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      imageFile = pickedFile;
      if(imageFile != null){
        imageFile = pickedFile;
        final imageBytes = File(imageFile!.path).readAsBytesSync();
        imageUrl = base64Encode(imageBytes);
        updatePicture(imageUrl: "data:image/jpeg;base64,${imageUrl!}");
      }
      update();
    } catch (e) {
      final pickImageError = e;
      imageFile = null;
      update();
    }
  }


  Future<void> updateProfile({required String description}) async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    try{
      var body = {
        "serviceProviderId": customerId,
        "description": description
      };
      var response = await NetworkProvider().call(path: "/Services/update/service/provider/description", method: RequestMethod.post, body: body,);
      final payLoad = ProfileResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getProfile().then((value){
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
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      log(err.toString());
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }

  Future<void> updatePicture({required String imageUrl}) async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    try{
      var body = {
        "serviceProviderId": customerId,
        "photoString": imageUrl
      };
      var response = await NetworkProvider().call(path: "/Services/update/service/provider/profile/pix",
        method: RequestMethod.post, body: body,);
      final payLoad = ProfileResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getProfile().then((value){
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
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.response?.data['title'] ?? errorMessage);
      imageFile = null;
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      log(err.toString());
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      imageFile = null;
      update();
      throw err.toString();
    }
  }

  List<XFile> serviceImages = <XFile>[].obs;

  void onAddServiceImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      serviceImages.add(pickedFile!);
      update();
    } catch (e) {
      final pickImageError = e;
      update();
    }
  }

  Future<void> updateServiceImages({required List<String?> imageUrl}) async {
    progressIndicator(Get.context);
    List<String> images = <String>[].obs;
    images = serviceImages.map((e) => "data:image/jpeg;base64,${base64Encode(File(e.path).readAsBytesSync())}").toList();
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    try{
      var body = {
        "serviceProviderId": customerId,
        "images": [
          ...imageUrl,
          ...images,
        ]
      };
      var response = await NetworkProvider().call(path: "/Services/update/service/provider/business/photo",
        method: RequestMethod.post, body: body,);
      final payLoad = ProfileResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getProfile().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          serviceImages.clear();
          update();
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
      imageFile = null;
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      log(err.toString());
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      imageFile = null;
      update();
      throw err.toString();
    }
  }

  Future<void> deleteServicePhoto({required String productId}) async {
    progressIndicator(Get.context!);
    try{
      var response = await NetworkProvider().call(path: "/Services/delete/business/photo?businessPhotoId=$productId", method: RequestMethod.get);
      /// get the sample response from postman
      final payLoad = IncreaseCartItemResponse.fromJson(response!.data);
      if(payLoad.status?.isSuccessful == true){
        await getProfile().then((value){
          showMessageSnackBar(Get.context, title: "Success", content: payLoad.status?.message?.friendlyMessage ?? "Request Successful");
          update();
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
      Get.back();
      showErrorSnackBar(Get.context,
          title: "Something Went Wrong",
          content: err.toString());
      update();
      throw err.toString();
    }
  }
}