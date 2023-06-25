
class AllVendorProductResponse {
  List<VendorProduct>? product;
  dynamic productPage;
  dynamic storeCategory;
  Status? status;

  AllVendorProductResponse({
    this.product,
    this.productPage,
    this.storeCategory,
    this.status,
  });

  factory AllVendorProductResponse.fromJson(Map<String, dynamic> json) => AllVendorProductResponse(
    product: json["product"] == null ? [] : List<VendorProduct>.from(json["product"]!.map((x) => VendorProduct.fromJson(x))),
    productPage: json["product_page"],
    storeCategory: json["storeCategory"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
    "product_page": productPage,
    "storeCategory": storeCategory,
    "status": status?.toJson(),
  };
}

class VendorProduct {
  num? productId;
  num? vendorId;
  num? categoryId;
  String? name;
  String? vendorName;
  String? categoryName;
  dynamic image;
  dynamic images;
  dynamic publicId;
  dynamic photoUrl;
  List<PhotoUrlList>? photoUrlList;
  String? description;
  num? amount;
  bool? active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  VendorProduct({
    this.productId,
    this.vendorId,
    this.categoryId,
    this.name,
    this.vendorName,
    this.categoryName,
    this.image,
    this.images,
    this.publicId,
    this.photoUrl,
    this.photoUrlList,
    this.description,
    this.amount,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory VendorProduct.fromJson(Map<String, dynamic> json) => VendorProduct(
    productId: json["productId"],
    vendorId: json["vendorId"],
    categoryId: json["categoryId"],
    name: json["name"],
    vendorName: json["vendorName"],
    categoryName: json["categoryName"],
    image: json["image"],
    images: json["images"],
    publicId: json["publicId"],
    photoUrl: json["photoUrl"],
    photoUrlList: json["photoUrlList"] == null ? [] : List<PhotoUrlList>.from(json["photoUrlList"]!.map((x) => PhotoUrlList.fromJson(x))),
    description: json["description"],
    amount: json["amount"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "vendorId": vendorId,
    "categoryId": categoryId,
    "name": name,
    "vendorName": vendorName,
    "categoryName": categoryName,
    "image": image,
    "images": images,
    "publicId": publicId,
    "photoUrl": photoUrl,
    "photoUrlList": photoUrlList == null ? [] : List<dynamic>.from(photoUrlList!.map((x) => x.toJson())),
    "description": description,
    "amount": amount,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
  };
}

class PhotoUrlList {
  int? productPhotoIdId;
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
