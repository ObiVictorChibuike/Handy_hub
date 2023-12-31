import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../models/request_model/sevices_provider_response.dart';
import '../api_services/remote/network_servcises/dio_service_config/dio_client.dart';

class CategoryController extends GetxController{
  List<ServiceProvider>? requestModelList = <ServiceProvider>[].obs;
  bool? isLoadingAllRequest;

  // Future<List<ServiceProvider>> getAllServiceProvider(String? catID) async {
  //   isLoadingAllRequest = true;
  //   update();
  //  try{
  //    var queryParams = {
  //      "categoryId": catID,
  //      "latitude": lat,
  //      "longitude": long,
  //    };
  //    var response = await NetworkProvider().call(path: "/Services/all/providers/by/category/Id", method: RequestMethod.get, queryParams: queryParams,);
  //    requestModelList = ServiceProviderResponse.fromJson(response!.data).serviceProviders?.map((e) {
  //      return e;
  //    }).toList();
  //    isLoadingAllRequest = false;
  //    update();
  //    return requestModelList ?? [];
  //  }on DioError catch (err) {
  //    isLoadingAllRequest = false;
  //    final errorMessage = Future.error(ApiError.fromDio(err));
  //    update();
  //    throw errorMessage;
  //  } catch (err) {
  //    isLoadingAllRequest = false;
  //    update();
  //    throw err.toString();
  //  }
  // }


  int? selectedIndex;

  navigateToNextPage({required int index}) {
    selectedIndex = index;
  }

  getSelectedItem() {
    return requestModelList!.elementAt(selectedIndex!);
  }
}