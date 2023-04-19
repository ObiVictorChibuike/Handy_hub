
class CardPaymentCheckoutResponse {
  CardPaymentCheckoutResponse({
    this.walletList,
    this.cart,
    this.status,
    this.transList,
  });

  dynamic walletList;
  dynamic cart;
  Status? status;
  List<TransList>? transList;

  factory CardPaymentCheckoutResponse.fromJson(Map<String, dynamic> json) => CardPaymentCheckoutResponse(
    walletList: json["walletList"],
    cart: json["cart"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    transList: json["transList"] == null ? [] : List<TransList>.from(json["transList"]!.map((x) => TransList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "walletList": walletList,
    "cart": cart,
    "status": status?.toJson(),
    "transList": transList == null ? [] : List<dynamic>.from(transList!.map((x) => x.toJson())),
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

class TransList {
  TransList({
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

  num? transactionId;
  num? operationTypeId;
  dynamic operationTypeName;
  num? paymentTypeId;
  dynamic paymentTypeName;
  num? customerId;
  dynamic custormerName;
  dynamic serviceProvider;
  num? serviceProviderId;
  num? amount;
  num? balance;
  String? transactionRef;
  bool? paymentStatus;
  dynamic paymentStatusName;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  factory TransList.fromJson(Map<String, dynamic> json) => TransList(
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
