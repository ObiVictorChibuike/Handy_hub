import 'package:esolink/logic/request/request_controller.dart';
import 'package:esolink/logic/services_category/category_controller.dart';
import 'package:get/get.dart';
import 'package:esolink/logic/location/get_location.dart';

class DashboardController extends GetxController{
  final ctrl = Get.put(CategoryController());
  final requestController = Get.put(RequestController());
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
  }

  @override
  void onInit() {
    getLatLong();
    super.onInit();
  }
}