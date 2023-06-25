

class AllStateResponse {
  List<State>? state;
  dynamic country;
  Status? status;

  AllStateResponse({
    this.state,
    this.country,
    this.status,
  });

  factory AllStateResponse.fromJson(Map<String, dynamic> json) => AllStateResponse(
    state: json["state"] == null ? [] : List<State>.from(json["state"]!.map((x) => State.fromJson(x))),
    country: json["country"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "state": state == null ? [] : List<dynamic>.from(state!.map((x) => x.toJson())),
    "country": country,
    "status": status?.toJson(),
  };
}

class State {
  int? stateId;
  int? countryId;
  String? stateName;

  State({
    this.stateId,
    this.countryId,
    this.stateName,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    stateId: json["stateId"],
    countryId: json["countryId"],
    stateName: json["stateName"],
  );

  Map<String, dynamic> toJson() => {
    "stateId": stateId,
    "countryId": countryId,
    "stateName": stateName,
  };
}

class Status {
  bool? isSuccessful;
  dynamic customToken;
  dynamic customSetting;
  Message? message;

  Status({
    this.isSuccessful,
    this.customToken,
    this.customSetting,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    isSuccessful: json["isSuccessful"],
    customToken: json["customToken"],
    customSetting: json["customSetting"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccessful": isSuccessful,
    "customToken": customToken,
    "customSetting": customSetting,
    "message": message?.toJson(),
  };
}

class Message {
  String? friendlyMessage;
  dynamic technicalMessage;
  dynamic messageId;
  dynamic searchResultMessage;
  dynamic shortErrorMessage;

  Message({
    this.friendlyMessage,
    this.technicalMessage,
    this.messageId,
    this.searchResultMessage,
    this.shortErrorMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    friendlyMessage: json["friendlyMessage"],
    technicalMessage: json["technicalMessage"],
    messageId: json["messageId"],
    searchResultMessage: json["searchResultMessage"],
    shortErrorMessage: json["shortErrorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "friendlyMessage": friendlyMessage,
    "technicalMessage": technicalMessage,
    "messageId": messageId,
    "searchResultMessage": searchResultMessage,
    "shortErrorMessage": shortErrorMessage,
  };
}
