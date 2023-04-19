import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/delivery_model/all_delivery_model_response.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController{
  double? lat;
  double? long;
  List<Delivery>? delivery = <Delivery>[].obs;
  bool? isLoadingAllDeliveryResponse;

  Future<List<Delivery>> fetchAllDelivery() async {
    isLoadingAllDeliveryResponse = true;
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    update();
    try{
      var response = await NetworkProvider().call(path: "/Stores/all/delivery/by/customer?customerId=$customerId", method: RequestMethod.get,);
      delivery = AllDeliveryResponseModel.fromJson(response!.data).delivery?.map<Delivery>((e) {
        return e;
      }).toList();
      isLoadingAllDeliveryResponse = false;
      update();
      return delivery!;
    }on DioError catch (err) {
      isLoadingAllDeliveryResponse = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      isLoadingAllDeliveryResponse = false;
      update();
      throw err.toString();
    }
  }
}