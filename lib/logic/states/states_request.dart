import 'package:esolink/logic/api_services/base_url.dart';
import 'package:esolink/logic/api_services/http_services.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';

getAllState(BuildContext? context) async {
  StateBloc stateBloc = locator.get<StateBloc>();
  var url = "${BASE_URL}Category/all/states";
  var response = await get(url: url, context: context);
  print(url);
  print(response);
  List<StateModel> stateModel;
  stateModel = response['data']['state'].map<StateModel>((e) {
    return StateModel.fromJson(e);
  }).toList();
  stateBloc.addAllStates(stateModel);
}
