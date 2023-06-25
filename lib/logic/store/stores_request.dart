import 'dart:convert';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:get/get.dart';
import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/login/login_controller.dart';
import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../models/stores_model/product_details.dart';


Future<List<Stores>> fetchAllStoresByID(
    BuildContext? context, String? id) async {
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var url = "${BASE_URL}Stores/all/products/by/category?Id=$id";
  var response = await get(url: url, context: context, token: token);
  List<Stores> stores;
  stores = response['data']['product'].map<Stores>((e) {
    return Stores.fromJson(e);
  }).toList();
  return stores;
}

Future<ProductDetails> fetchAllProductDetails(BuildContext? context, String? id) async {
  var url = '${BASE_URL}Stores/single/product/Id?Id=$id';
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var response = await get(url: url, context: context, token: token);
  ProductDetails products;
  products = response['data'].map<ProductDetails>((e){
    return ProductDetails.fromJson(e);
  });
  print(products);
  return products;
}

Future<List<ProductDetails>> fetchAllProductDetail(int id) async {
  var url = '${BASE_URL}Stores/single/product/Id?Id=$id';
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'Bearer $token'
  };
  final response = await http.get(Uri.parse(url),headers: headers);

  final responseData = json.decode(response.body);
  print(responseData);
  print(response.statusCode);
  return responseData.map((e) => ProductDetails.fromJson(e));
}

Future<List<Stores>> fetchStoresById(String id) async{
  var url = '${BASE_URL}Stores/all/products/by/category?Id=$id';
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'Bearer $token'
  };
  final response = await http.get(Uri.parse(url),headers: headers);

  final List responseData = json.decode(response.body)['data']['product'];
  print(responseData);
  return responseData.map((e) => Stores.fromJson(e)).toList();

  // stores = response.body.map<Stores>((e) {
  //   return Stores.fromJson(e);
  // }).toList();
  // return stores;
}

fetchAllStoresCategories(BuildContext? context) async {
  StoresBLoc storesBLoc = locator.get<StoresBLoc>();
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var url = "https://gethandyhub.com/Stores/all/store/category";
  var response = await get(url: url, context: context, token: token);
  List<StoresCategory> storesCategories;
  storesCategories = response['data']['storeCategory'].map<StoresCategory>((e) {
    return StoresCategory.fromJson(e);
  }).toList();
  storesBLoc.addStoresCategories(storesCategories);
}
