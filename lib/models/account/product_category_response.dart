
class ProductCategoryResponse {
  dynamic product;
  dynamic productPage;
  List<StoreCategory>? storeCategory;
  Status? status;

  ProductCategoryResponse({
    this.product,
    this.productPage,
    this.storeCategory,
    this.status,
  });

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) => ProductCategoryResponse(
    product: json["product"],
    productPage: json["product_page"],
    storeCategory: json["storeCategory"] == null ? [] : List<StoreCategory>.from(json["storeCategory"]!.map((x) => StoreCategory.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product,
    "product_page": productPage,
    "storeCategory": storeCategory == null ? [] : List<dynamic>.from(storeCategory!.map((x) => x.toJson())),
    "status": status?.toJson(),
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

class StoreCategory {
  int? categoryId;
  String? name;
  String? description;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  StoreCategory({
    this.categoryId,
    this.name,
    this.description,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) => StoreCategory(
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "name": name,
    "description": description,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
  };
}
