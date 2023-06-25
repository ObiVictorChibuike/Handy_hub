
class CreateDeliveryResponseModel {
  CreateDeliveryResponseModel({
    this.delivery,
    this.deliveryPage,
    this.riders,
    this.status,
    this.trans,
  });

  dynamic delivery;
  dynamic deliveryPage;
  dynamic riders;
  Status? status;
  dynamic trans;

  factory CreateDeliveryResponseModel.fromJson(Map<String, dynamic> json) => CreateDeliveryResponseModel(
    delivery: json["delivery"],
    deliveryPage: json["delivery_page"],
    riders: json["riders"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    trans: json["trans"],
  );

  Map<String, dynamic> toJson() => {
    "delivery": delivery,
    "delivery_page": deliveryPage,
    "riders": riders,
    "status": status?.toJson(),
    "trans": trans,
  };
}

class Status {
  Status({
    this.isSuccessful,
    this.customToken,
    this.customSetting,
    this.message,
  });

  bool? isSuccessful;
  dynamic customToken;
  dynamic customSetting;
  Message? message;

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
  Message({
    this.friendlyMessage,
    this.technicalMessage,
    this.messageId,
    this.searchResultMessage,
    this.shortErrorMessage,
  });

  String? friendlyMessage;
  dynamic technicalMessage;
  dynamic messageId;
  dynamic searchResultMessage;
  dynamic shortErrorMessage;

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
