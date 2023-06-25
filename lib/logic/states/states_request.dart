import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

getAllState(BuildContext? context) async {
  StateBloc stateBloc = locator.get<StateBloc>();
  var url = "${BASE_URL}Category/all/states";
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final token = await LocalCachedData.instance.getAuthToken();
  var response = await get(url: url, context: context, token: token);
 
  List<StateModel> stateModel;
  stateModel = response['data']['state'].map<StateModel>((e) {
    return StateModel.fromJson(e);
  }).toList();
  stateBloc.addAllStates(stateModel);
}
