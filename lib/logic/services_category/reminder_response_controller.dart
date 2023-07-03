
import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/service_provider_response_model.dart';
import 'package:get/get.dart';

class ReminderResponseController extends GetxController{
  List<ServiceProvider>? requestModelList = <ServiceProvider>[].obs;
  bool? isLoadingAllServices;

  Future<List<ServiceProvider>?> getAllReminderServices({required String categoryId}) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final serviceProviderId = userDetails.serviceProviders![0].serviceProviderId;
    isLoadingAllServices = true;
    update();
    try{
      var response = await NetworkProvider().call(path: "/Services/all/providers/by/category/and/location/Id?categoryId=$categoryId&customerId=$serviceProviderId", method: RequestMethod.get);
      await LocalCachedData.instance.saveServiceProvidersList(serviceProviderResponseModel:  ServiceProviderResponseModel.fromJson(response!.data));
      requestModelList = ServiceProviderResponseModel.fromJson(response.data).serviceProviders?.map((e) {
        return e;
      }).toList();
      isLoadingAllServices = false;
      update();
      return requestModelList;
    }on DioError catch (err) {
      final value = await LocalCachedData.instance.fetchServiceProvidersList();
      if(value.serviceProviders!.isNotEmpty){
        requestModelList = value.serviceProviders?.map((e) {
          return e;
        }).toList();
      }
      isLoadingAllServices = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      final value = await LocalCachedData.instance.fetchServiceProvidersList();
      if(value.serviceProviders!.isNotEmpty){
        requestModelList = value.serviceProviders?.map((e) {
          return e;
        }).toList();
      }
      isLoadingAllServices = false;
      update();
      throw err.toString();
    }
  }
}