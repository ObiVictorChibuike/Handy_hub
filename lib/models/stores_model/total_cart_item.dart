
class TotalCartItemResponse {
  TotalCartItemResponse({
    this.walletList,
    this.cart,
    this.status,
    this.transList,
  });

  dynamic walletList;
  Cart? cart;
  Status? status;
  dynamic transList;

  factory TotalCartItemResponse.fromJson(Map<String, dynamic> json) => TotalCartItemResponse(
    walletList: json["walletList"],
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    transList: json["transList"],
  );

  Map<String, dynamic> toJson() => {
    "walletList": walletList,
    "cart": cart?.toJson(),
    "status": status?.toJson(),
    "transList": transList,
  };
}

class Cart {
  Cart({
    this.cartList,
    this.cartCount,
    this.cartTotalSum,
  });

  List<CartList>? cartList;
  num? cartCount;
  num? cartTotalSum;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    cartList: json["cartList"] == null ? [] : List<CartList>.from(json["cartList"]!.map((x) => CartList.fromJson(x))),
    cartCount: json["cartCount"],
    cartTotalSum: json["cartTotalSum"],
  );

  Map<String, dynamic> toJson() => {
    "cartList": cartList == null ? [] : List<dynamic>.from(cartList!.map((x) => x.toJson())),
    "cartCount": cartCount,
    "cartTotalSum": cartTotalSum,
  };
}

class CartList {
  CartList({
    this.cartId,
    this.productId,
    this.customerId,
    this.vendorId,
    this.quantity,
    this.amount,
    this.productName,
    this.productDescription,
    this.photoUrl,
    this.photoUrlList,
    this.productImage,
    this.transactionRef,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? cartId;
  int? productId;
  int? customerId;
  int? vendorId;
  int? quantity;
  num? amount;
  String? productName;
  String? productDescription;
  dynamic photoUrl;
  List<PhotoUrlList>? photoUrlList;
  dynamic productImage;
  dynamic transactionRef;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
    cartId: json["cartId"],
    productId: json["productId"],
    customerId: json["customerId"],
    vendorId: json["vendorId"],
    quantity: json["quantity"],
    amount: json["amount"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    photoUrl: json["photoUrl"],
    photoUrlList: json["photoUrlList"] == null ? [] : List<PhotoUrlList>.from(json["photoUrlList"]!.map((x) => PhotoUrlList.fromJson(x))),
    productImage: json["productImage"],
    transactionRef: json["transactionRef"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "cartId": cartId,
    "productId": productId,
    "customerId": customerId,
    "vendorId": vendorId,
    "quantity": quantity,
    "amount": amount,
    "productName": productName,
    "productDescription": productDescription,
    "photoUrl": photoUrl,
    "photoUrlList": photoUrlList == null ? [] : List<dynamic>.from(photoUrlList!.map((x) => x.toJson())),
    "productImage": productImage,
    "transactionRef": transactionRef,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
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
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

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
