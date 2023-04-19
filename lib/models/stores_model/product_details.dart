// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    this.product,
    this.productPage,
    this.storeCategory,
    this.status,
  });

  List<Product>? product;
  List<Product>? productPage;
  List<StoreCategory>? storeCategory;
  Status? status;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    product: json["product"] == null ? [] : List<Product>.from(json["product"]!.map((x) => Product.fromJson(x))),
    productPage: json["product_page"] == null ? [] : List<Product>.from(json["product_page"]!.map((x) => Product.fromJson(x))),
    storeCategory: json["storeCategory"] == null ? [] : List<StoreCategory>.from(json["storeCategory"]!.map((x) => StoreCategory.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
    "product_page": productPage == null ? [] : List<dynamic>.from(productPage!.map((x) => x.toJson())),
    "storeCategory": storeCategory == null ? [] : List<dynamic>.from(storeCategory!.map((x) => x.toJson())),
    "status": status?.toJson(),
  };
}

class Product {
  Product({
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

  num? productId;
  num? vendorId;
  num? categoryId;
  String? name;
  String? vendorName;
  String? categoryName;
  String? image;
  List<String>? images;
  String? publicId;
  String? photoUrl;
  List<PhotoUrlList>? photoUrlList;
  String? description;
  num? amount;
  bool? active;
  bool? deleted;
  String? createdBy;
  DateTime? createdOn;
  String? updatedBy;
  DateTime? updatedOn;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    vendorId: json["vendorId"],
    categoryId: json["categoryId"],
    name: json["name"],
    vendorName: json["vendorName"],
    categoryName: json["categoryName"],
    image: json["image"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    publicId: json["publicId"],
    photoUrl: json["photoUrl"],
    photoUrlList: json["photoUrlList"] == null ? [] : List<PhotoUrlList>.from(json["photoUrlList"]!.map((x) => PhotoUrlList.fromJson(x))),
    description: json["description"],
    amount: json["amount"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "vendorId": vendorId,
    "categoryId": categoryId,
    "name": name,
    "vendorName": vendorName,
    "categoryName": categoryName,
    "image": image,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "publicId": publicId,
    "photoUrl": photoUrl,
    "photoUrlList": photoUrlList == null ? [] : List<dynamic>.from(photoUrlList!.map((x) => x.toJson())),
    "description": description,
    "amount": amount,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedOn": updatedOn?.toIso8601String(),
  };
}

class PhotoUrlList {
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

  int? productPhotoIdId;
  int? productId;
  String? photoUrl;
  String? publicPhotoIdId;
  bool? active;
  bool? deleted;
  String? createdBy;
  DateTime? createdOn;
  String? updatedBy;
  DateTime? updatedOn;

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
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
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
  String? customToken;
  String? customSetting;
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
  String? technicalMessage;
  String? messageId;
  String? searchResultMessage;
  String? shortErrorMessage;

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

  int? categoryId;
  String? name;
  String? description;
  bool? active;
  bool? deleted;
  String? createdBy;
  DateTime? createdOn;
  String? updatedBy;
  DateTime? updatedOn;

  factory StoreCategory.fromJson(Map<String, dynamic> json) => StoreCategory(
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "name": name,
    "description": description,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedOn": updatedOn?.toIso8601String(),
  };
}
