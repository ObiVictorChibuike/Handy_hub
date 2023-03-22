import 'dart:convert';

import '../../models/faq_model.dart';
import '../../models/services_category/categories.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  Future<List<CategoriesModel>> getCategories() async {
    var url = "${BASE_URL}Category/all/category/dashboard";
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(Uri.parse(url),headers: headers);
    var categories = <CategoriesModel>[];

    if (response.statusCode == 200){
      var categoriesJson = json.decode(response.body)['category'];
      print(categoriesJson);
      for(var categoryJson in categoriesJson){
        categories.add(CategoriesModel.fromJson(categoryJson));
      }
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
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
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