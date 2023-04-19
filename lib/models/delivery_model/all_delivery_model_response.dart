class AllDeliveryResponseModel {
  AllDeliveryResponseModel({
    this.delivery,
    this.deliveryPage,
    this.riders,
    this.status,
    this.trans,
  });

  List<Delivery>? delivery;
  dynamic deliveryPage;
  dynamic riders;
  Status? status;
  dynamic trans;

  factory AllDeliveryResponseModel.fromJson(Map<String, dynamic> json) => AllDeliveryResponseModel(
    delivery: json["delivery"] == null ? [] : List<Delivery>.from(json["delivery"]!.map((x) => Delivery.fromJson(x))),
    deliveryPage: json["delivery_page"],
    riders: json["riders"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    trans: json["trans"],
  );

  Map<String, dynamic> toJson() => {
    "delivery": delivery == null ? [] : List<dynamic>.from(delivery!.map((x) => x.toJson())),
    "delivery_page": deliveryPage,
    "riders": riders,
    "status": status?.toJson(),
    "trans": trans,
  };
}

class Delivery {
  Delivery({
    this.deliveryId,
    this.customerId,
    this.riderId,
    this.dispatchRider,
    this.pickupLocation,
    this.deliveryLocation,
    this.receiverName,
    this.senderName,
    this.senderPhoneNumber,
    this.customerName,
    this.phoneNumber,
    this.customerContact,
    this.deliverNumber,
    this.packageDetails,
    this.deliveryStatusName,
    this.deliveryStatus,
    this.amount,
    this.paymentStatus,
    this.transactionRef,
    this.paymentType,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? deliveryId;
  int? customerId;
  int? riderId;
  String? dispatchRider;
  String? pickupLocation;
  String? deliveryLocation;
  String? receiverName;
  String? senderName;
  String? senderPhoneNumber;
  dynamic customerName;
  String? phoneNumber;
  dynamic customerContact;
  String? deliverNumber;
  String? packageDetails;
  String? deliveryStatusName;
  int? deliveryStatus;
  int? amount;
  bool? paymentStatus;
  dynamic transactionRef;
  int? paymentType;
  dynamic active;
  dynamic deleted;
  DateTime? createdBy;
  DateTime? createdOn;
  DateTime? updatedBy;
  DateTime? updatedOn;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    deliveryId: json["deliveryId"],
    customerId: json["customerId"],
    riderId: json["riderId"],
    dispatchRider: json["dispatchRider"],
    pickupLocation: json["pickupLocation"],
    deliveryLocation: json["deliveryLocation"],
    receiverName: json["receiverName"],
    senderName: json["senderName"],
    senderPhoneNumber: json["senderPhoneNumber"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    customerContact: json["customerContact"],
    deliverNumber: json["deliverNumber"],
    packageDetails: json["packageDetails"],
    deliveryStatusName: json["deliveryStatusName"],
    deliveryStatus: json["deliveryStatus"],
    amount: json["amount"],
    paymentStatus: json["paymentStatus"],
    transactionRef: json["transactionRef"],
    paymentType: json["paymentType"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"] == null ? null : DateTime.parse(json["createdBy"]),
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"] == null ? null : DateTime.parse(json["updatedBy"]),
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "deliveryId": deliveryId,
    "customerId": customerId,
    "riderId": riderId,
    "dispatchRider": dispatchRider,
    "pickupLocation": pickupLocation,
    "deliveryLocation": deliveryLocation,
    "receiverName": receiverName,
    "senderName": senderName,
    "senderPhoneNumber": senderPhoneNumber,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "customerContact": customerContact,
    "deliverNumber": deliverNumber,
    "packageDetails": packageDetails,
    "deliveryStatusName": deliveryStatusName,
    "deliveryStatus": deliveryStatus,
    "amount": amount,
    "paymentStatus": paymentStatus,
    "transactionRef": transactionRef,
    "paymentType": paymentType,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy?.toIso8601String(),
    "createdOn": createdOn?.toIso8601String(),
    "updatedBy": updatedBy?.toIso8601String(),
    "updatedOn": updatedOn?.toIso8601String(),
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
