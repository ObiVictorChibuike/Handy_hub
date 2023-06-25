import 'dart:convert';
import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:get/get.dart';
import '../../models/faq_model.dart';
import '../../models/services_category/categories.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;
import 'local/local_storage.dart';

class ApiServices{
  Future<List<Category>> getCategories() async {
    var url = "${BASE_URL}Category/all/category/dashboard";
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final token = await LocalCachedData.instance.getAuthToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse(url),headers: headers);
    var categories = <Category>[];

    if (response.statusCode == 200){
      var categoriesJson = json.decode(response.body);
      categories = CategoriesModel.fromJson(categoriesJson).category!;
    }
    return categories;

    // final List responseData = json.decode(response.body)['data']['category'];
    // categoriesModel.add(json.decode(response.body)['data']['category']);
    // print(categoriesModel);
    // return categoriesModel = json.decode(response.body)['data']['category'].map<CategoriesModel>((e) {
    //   return CategoriesModel.fromJson(e);
    // }).toList();
  }

  Future<List<AllCategory>> getAllCategories() async {
    var url = "${BASE_URL}Category/all/category";
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final token = await LocalCachedData.instance.getAuthToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse(url),headers: headers);
    var categories = <AllCategory>[];

    if (response.statusCode == 200){
      var categoriesJson = json.decode(response.body);
      print(categoriesJson);
      categories = AllCategoryResponse.fromJson(categoriesJson).category!;
    }

    return categories;

    // final List responseData = json.decode(response.body)['data']['category'];
    // categoriesModel.add(json.decode(response.body)['data']['category']);
    // print(categoriesModel);
    // return categoriesModel = json.decode(response.body)['data']['category'].map<CategoriesModel>((e) {
    //   return CategoriesModel.fromJson(e);
    // }).toList();
  }

  Future<List<Faq>> getFaqs() async {
    var url = "${BASE_URL}/Category/all/faq";
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final token = await LocalCachedData.instance.getAuthToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse(url),headers: headers);
    final List responseData = json.decode(response.body)["faq"];
    print(responseData);
    return responseData.map((e) => Faq.fromJson(e)).toList();

    // final List responseData = json.decode(response.body)['data']['category'];
    // categoriesModel.add(json.decode(response.body)['data']['category']);
    // print(categoriesModel);
    // return categoriesModel = json.decode(response.body)['data']['category'].map<CategoriesModel>((e) {
    //   return CategoriesModel.fromJson(e);
    // }).toList();
  }
}