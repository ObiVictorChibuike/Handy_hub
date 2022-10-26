import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

fetchAllRequest(BuildContext? context, String? catID, String customerID) async {
  RequestBLoc requestBLoc = locator.get<RequestBLoc>();

  var url =
      "https://api.esolink.com/Services/all/providers/by/category/and/location/Id?categoryId=$catID&customerId=1984";
  var response = await get(url: url, context: context);
  print(url);
  List<RequestsModel> requestModel;

  requestModel = response['data']['serviceProviders'].map<RequestsModel>((e) {
    return RequestsModel.fromJson(e);
  }).toList();
  print(response);

  requestBLoc.addAllRequest(requestModel);
}
