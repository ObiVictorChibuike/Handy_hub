import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/logic/services_category/category_controller.dart';
import 'package:esolink/models/account/update_location_response.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:get/get.dart';
import 'package:esolink/logic/location/get_location.dart';

import '../models/account/rating_response.dart';
import 'api_services/local/local_storage.dart';
import 'api_services/remote/network_servcises/dio_service_config/dio_client.dart';

class DashboardController extends GetxController{
  final ctrl = Get.put(CategoryController());

  int index = 0;

  switchTab(int selectedIndex){
    index = selectedIndex;
    update();
  }

  double? latitude, longitude;

  Future<void> getLatLong() async {
    await GetLocation.instance!.checkLocation.then((value) async {
      latitude = value.latitude;
      longitude = value.longitude;
      ctrl.lat = value.latitude;
      ctrl.long = value.longitude;
      update();
    });
    // await checkLoginStatus();
  }

  @override
  void onInit() {
    getLatLong();
    super.onInit();
  }

  bool? loginStatus;

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    if (loginStatus == true){
      // updateLocation();
    }else{
      null;
    }
    return isLoggedIn;
  }

}