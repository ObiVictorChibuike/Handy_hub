
class UpdateStatusResponse {
  dynamic serviceProviders;
  dynamic serviceProviderPage;
  dynamic requestedServices;
  dynamic requestedServicesPage;
  Status? status;
  dynamic counts;
  int? serviceProviderId;

  UpdateStatusResponse({
    this.serviceProviders,
    this.serviceProviderPage,
    this.requestedServices,
    this.requestedServicesPage,
    this.status,
    this.counts,
    this.serviceProviderId,
  });

  factory UpdateStatusResponse.fromJson(Map<String, dynamic> json) => UpdateStatusResponse(
    serviceProviders: json["serviceProviders"],
    serviceProviderPage: json["serviceProvider_page"],
    requestedServices: json["requestedServices"],
    requestedServicesPage: json["requestedServices_page"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    counts: json["counts"],
    serviceProviderId: json["serviceProviderId"],
  );

  Map<String, dynamic> toJson() => {
    "serviceProviders": serviceProviders,
    "serviceProvider_page": serviceProviderPage,
    "requestedServices": requestedServices,
    "requestedServices_page": requestedServicesPage,
    "status": status?.toJson(),
    "counts": counts,
    "serviceProviderId": serviceProviderId,
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
