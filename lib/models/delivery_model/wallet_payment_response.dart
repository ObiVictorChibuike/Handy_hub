
class WalletPaymentResponse {
  WalletPaymentResponse({
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
  Trans? trans;

  factory WalletPaymentResponse.fromJson(Map<String, dynamic> json) => WalletPaymentResponse(
    delivery: json["delivery"],
    deliveryPage: json["delivery_page"],
    riders: json["riders"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    trans: json["trans"] == null ? null : Trans.fromJson(json["trans"]),
  );

  Map<String, dynamic> toJson() => {
    "delivery": delivery,
    "delivery_page": deliveryPage,
    "riders": riders,
    "status": status?.toJson(),
    "trans": trans?.toJson(),
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

class Trans {
  Trans({
    this.transactionId,
    this.operationTypeId,
    this.operationTypeName,
    this.paymentTypeId,
    this.paymentTypeName,
    this.customerId,
    this.custormerName,
    this.serviceProvider,
    this.serviceProviderId,
    this.amount,
    this.balance,
    this.transactionRef,
    this.paymentStatus,
    this.paymentStatusName,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? transactionId;
  int? operationTypeId;
  dynamic operationTypeName;
  int? paymentTypeId;
  dynamic paymentTypeName;
  int? customerId;
  dynamic custormerName;
  dynamic serviceProvider;
  int? serviceProviderId;
  int? amount;
  int? balance;
  dynamic transactionRef;
  bool? paymentStatus;
  dynamic paymentStatusName;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  factory Trans.fromJson(Map<String, dynamic> json) => Trans(
    transactionId: json["transactionId"],
    operationTypeId: json["operationTypeId"],
    operationTypeName: json["operationTypeName"],
    paymentTypeId: json["paymentTypeId"],
    paymentTypeName: json["paymentTypeName"],
    customerId: json["customerId"],
    custormerName: json["custormerName"],
    serviceProvider: json["serviceProvider"],
    serviceProviderId: json["serviceProviderId"],
    amount: json["amount"],
    balance: json["balance"],
    transactionRef: json["transactionRef"],
    paymentStatus: json["paymentStatus"],
    paymentStatusName: json["paymentStatusName"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "operationTypeId": operationTypeId,
    "operationTypeName": operationTypeName,
    "paymentTypeId": paymentTypeId,
    "paymentTypeName": paymentTypeName,
    "customerId": customerId,
    "custormerName": custormerName,
    "serviceProvider": serviceProvider,
    "serviceProviderId": serviceProviderId,
    "amount": amount,
    "balance": balance,
    "transactionRef": transactionRef,
    "paymentStatus": paymentStatus,
    "paymentStatusName": paymentStatusName,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
  };
}
