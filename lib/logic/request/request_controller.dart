import 'package:dio/dio.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_error.dart';
import 'package:esolink/models/request_model/request_category_model.dart';
import 'package:get/get.dart';

class RequestController extends GetxController{
  bool? onCategoryHasData;
  RequestCategoryModel? requestCategoryModel;

  Future<RequestCategoryModel> getRequestCategories() async {
    onCategoryHasData = true;
    update();
    try{
      var response = await NetworkProvider().call(path: "/Category/all/category", method: RequestMethod.get,);
      requestCategoryModel = RequestCategoryModel.fromJson(response!.data);
      onCategoryHasData = false;
      update();
      return requestCategoryModel!;
    }on DioError catch (err) {
      onCategoryHasData = false;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      onCategoryHasData = false;
      update();
      throw err.toString();
    }
  }

  String? selectedCategory;

  @override
  void onInit() {
    getRequestCategories();
    super.onInit();
  }
}