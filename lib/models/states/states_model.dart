class StateModel {
  int? stateId, countryId;
  String? stateName;

  StateModel();

  StateModel.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    stateId = json['stateId'];
    stateName = json['stateName'];
  }
}
