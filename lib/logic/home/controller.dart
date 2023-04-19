import 'dart:convert';

import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  bool? onCategoryHasData;
  List<CategoriesModel> categories = <CategoriesModel>[].obs;

  Future<List<CategoriesModel>> getCategories() async {
    onCategoryHasData = false;
    update();
    var url = "${BASE_URL}Category/all/category/dashboard";
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(Uri.parse(url),headers: headers);

    if (response.statusCode == 200){
      var categoriesJson = json.decode(response.body)['category'];
      print(categoriesJson);
      for(var categoryJson in categoriesJson){
        categories.add(CategoriesModel.fromJson(categoryJson));
      }
      onCategoryHasData = true;
      update();
    }

    return categories;

    // final List responseData = json.decode(response.body)['data']['category'];
    // categoriesModel.add(json.decode(response.body)['data']['category']);
    // print(categoriesModel);
    // return categoriesModel = json.decode(response.body)['data']['category'].map<CategoriesModel>((e) {
    //   return CategoriesModel.fromJson(e);
    // }).toList();
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}