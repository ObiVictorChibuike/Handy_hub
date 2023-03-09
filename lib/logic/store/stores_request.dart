import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

Future<List<Stores>> fetchAllStoresByID(
    BuildContext? context, String? id) async {
  var url = "https://handyhub.goserp.co.uk/Stores/all/products/by/category?Id=$id";
  var response = await get(url: url, context: context);
  List<Stores> stores;
  stores = response['data']['product'].map<Stores>((e) {
    return Stores.fromJson(e);
  }).toList();
  return stores;
}

fetchAllStoresCategories(BuildContext? context) async {
  StoresBLoc storesBLoc = locator.get<StoresBLoc>();
  var url = "http://handyhub.goserp.co.uk/Stores/all/store/category";
  var response = await get(url: url, context: context);
  List<StoresCategory> storesCategories;
  storesCategories = response['data']['storeCategory'].map<StoresCategory>((e) {
    return StoresCategory.fromJson(e);
  }).toList();
  print(response);
  storesBLoc.addStoresCategories(storesCategories);
}
