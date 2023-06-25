import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

getAllCategories(BuildContext? context) async {
  CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
  var url = "${BASE_URL}Category/all/category";
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var response = await get(url: url, context: context, token: token);
  print(url);
  List<CategoriesModel> categoriesModel;
  categoriesModel = response['data']['category'].map<CategoriesModel>((e) {
    return CategoriesModel.fromJson(e);
  }).toList();
  categoriesBloc.addAllCategories(categoriesModel);
}
