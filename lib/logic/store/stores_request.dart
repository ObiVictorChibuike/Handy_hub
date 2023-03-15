import 'dart:convert';

import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/login/login_request.dart';
import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

String? token;

Future<List<Stores>> fetchAllStoresByID(
    BuildContext? context, String? id) async {
  token = ApiServices().getToken();
  var url = "${BASE_URL}Stores/all/products/by/category?Id=$id";
  var response = await get(url: url, context: context, token: token);
  List<Stores> stores;
  stores = response['data']['product'].map<Stores>((e) {
    return Stores.fromJson(e);
  }).toList();
  print(stores);
  return stores;
}

Future<List<Stores>> fetchStoresById(String id) async{
  var url = 'https://handyhub.goserp.co.uk/Stores/all/products/by/category?Id=$id';
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
  var url = "http://handyhub.goserp.co.uk/Stores/all/store/category";
  var response = await get(url: url, context: context, token: token);
  List<StoresCategory> storesCategories;
  storesCategories = response['data']['storeCategory'].map<StoresCategory>((e) {
    return StoresCategory.fromJson(e);
  }).toList();
  storesBLoc.addStoresCategories(storesCategories);
}
