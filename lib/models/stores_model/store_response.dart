
class StoreResponse {
  Response? response;
  Status? status;

  StoreResponse({
    this.response,
    this.status,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
    "status": status?.toJson(),
  };
}

class Response {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  List<StoreProduct>? data;

  Response({
    this.currentPage,
    this.totalPages,
    this.pageSize,
    this.totalCount,
    this.hasPrevious,
    this.hasNext,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    pageSize: json["pageSize"],
    totalCount: json["totalCount"],
    hasPrevious: json["hasPrevious"],
    hasNext: json["hasNext"],
    data: json["data"] == null ? [] : List<StoreProduct>.from(json["data"]!.map((x) => StoreProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "hasPrevious": hasPrevious,
    "hasNext": hasNext,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StoreProduct {
  int? productId;
  int? vendorId;
  int? stateId;
  int? categoryId;
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
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  StoreProduct({
    this.productId,
    this.vendorId,
    this.stateId,
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

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
    productId: json["productId"],
    vendorId: json["vendorId"],
    stateId: json["stateId"],
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
    "stateId": stateId,
    "categoryId": categoryId,
    "name": name,
    "vendorName": vendorName,
    "categoryName": categoryNameValues.reverse[categoryName],
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

enum CategoryName { SHOES_BAGS }

final categoryNameValues = EnumValues({
  "Shoes/Bags ": CategoryName.SHOES_BAGS
});

class PhotoUrlList {
  int? productPhotoIdId;
  int? productId;
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
