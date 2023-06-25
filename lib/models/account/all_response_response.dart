
class AllOrderResponse {
  List<Order>? order;
  dynamic orderPage;
  Status? status;

  AllOrderResponse({
    this.order,
    this.orderPage,
    this.status,
  });

  factory AllOrderResponse.fromJson(Map<String, dynamic> json) => AllOrderResponse(
    order: json["order"] == null ? [] : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
    orderPage: json["order_page"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x.toJson())),
    "order_page": orderPage,
    "status": status?.toJson(),
  };
}

class Order {
  num? orderId;
  num? productId;
  num? customerId;
  num? quantity;
  num? amount;
  String? productName;
  dynamic vendor;
  dynamic customerName;
  String? productDescription;
  dynamic photoUrl;
  List<PhotoUrlList>? photoUrlList;
  String? orderNumber;
  dynamic productImage;
  int? deliveryStatus;
  DeliveryStatusName? deliveryStatusName;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  DateTime? updatedOn;

  Order({
    this.orderId,
    this.productId,
    this.customerId,
    this.quantity,
    this.amount,
    this.productName,
    this.vendor,
    this.customerName,
    this.productDescription,
    this.photoUrl,
    this.photoUrlList,
    this.orderNumber,
    this.productImage,
    this.deliveryStatus,
    this.deliveryStatusName,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["orderId"],
    productId: json["productId"],
    customerId: json["customerId"],
    quantity: json["quantity"],
    amount: json["amount"],
    productName: json["productName"],
    vendor: json["vendor"],
    customerName: json["customerName"],
    productDescription: json["productDescription"],
    photoUrl: json["photoUrl"],
    photoUrlList: json["photoUrlList"] == null ? [] : List<PhotoUrlList>.from(json["photoUrlList"]!.map((x) => PhotoUrlList.fromJson(x))),
    orderNumber: json["orderNumber"],
    productImage: json["productImage"],
    deliveryStatus: json["deliveryStatus"],
    deliveryStatusName: deliveryStatusNameValues.map[json["deliveryStatusName"]]!,
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "productId": productId,
    "customerId": customerId,
    "quantity": quantity,
    "amount": amount,
    "productName": productName,
    "vendor": vendor,
    "customerName": customerName,
    "productDescription": productDescription,
    "photoUrl": photoUrl,
    "photoUrlList": photoUrlList == null ? [] : List<dynamic>.from(photoUrlList!.map((x) => x.toJson())),
    "orderNumber": orderNumber,
    "productImage": productImage,
    "deliveryStatus": deliveryStatus,
    "deliveryStatusName": deliveryStatusNameValues.reverse[deliveryStatusName],
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedOn": updatedOn?.toIso8601String(),
  };
}

enum DeliveryStatusName { PENDING, COMPLETED }

final deliveryStatusNameValues = EnumValues({
  "Completed": DeliveryStatusName.COMPLETED,
  "Pending": DeliveryStatusName.PENDING
});

class PhotoUrlList {
  num? productPhotoIdId;
  num? productId;
  String? photoUrl;
  String? publicPhotoIdId;
  bool? active;
  bool? deleted;
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  PhotoUrlList({
    this.productPhotoIdId,
    this.productId,
    this.photoUrl,
    this.publicPhotoIdId,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory PhotoUrlList.fromJson(Map<String, dynamic> json) => PhotoUrlList(
    productPhotoIdId: json["productPhotoIdId"],
    productId: json["productId"],
    photoUrl: json["photoUrl"],
    publicPhotoIdId: json["publicPhotoIdId"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "productPhotoIdId": productPhotoIdId,
    "productId": productId,
    "photoUrl": photoUrl,
    "publicPhotoIdId": publicPhotoIdId,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
