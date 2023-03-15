import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

import '../../views/widgets/custom_snack.dart';
import 'package:esolink/logic/login/login_request.dart';

String? customerId;
String? token;

Future<List<RequestsModel>> fetchAllRequest(
    BuildContext? context, String? catID,) async {
  // RequestBLoc requestBLoc = locator.get<RequestBLoc>();

  token = ApiServices().getToken();
  var url =
      "http://handyhub.goserp.co.uk/Services/all/providers/by/category/and/location/Id?categoryId=$catID&customerId=1";
  var response = await get(url: url, context: context, token: token);
  List<RequestsModel> requestModel;
  requestModel = response['data']['serviceProviders'].map<RequestsModel>((e) {
    return RequestsModel.fromJson(e);
  }).toList();
  print(requestModel);
  return requestModel;
  // requestBLoc.addAllRequest(requestModel);
  // fetchBusinessPhotos(context!, catID);
}

makeRequest(BuildContext? context) async {
  MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();
  var url = "https://handyhub.goserp.co.uk/Services/update/requested/service";

  print(makeRequestBloc.body);
  var response =
      await post(url: url, body: makeRequestBloc.body, context: context);
  if (response['data']['isSuccessful'] == true) {
    showMessageSnackBar(context!,
        title: "Success",
        content: response['data']['message']['friendlyMessage']);
  } else {
    showErrorSnackBar(context!,
        title: "Something Went Wrong",
        content: response['data']['message']['friendlyMessage']);
  }
}
