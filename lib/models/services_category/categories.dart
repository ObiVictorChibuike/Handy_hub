
class CategoriesModel {
  CategoriesModel({
    this.category,
    this.status,
  });

  List<Category>? category;
  Status? status;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
    "status": status?.toJson(),
  };
}

class Category {
  Category({
    this.categoryId,
    this.name,
    this.icon,
    this.publicId,
    this.description,
    this.supervisorName,
    this.supervisorEmail,
    this.supervisorNumber,
    this.group,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? categoryId;
  String? name;
  String? icon;
  dynamic publicId;
  String? description;
  String? supervisorName;
  String? supervisorEmail;
  String? supervisorNumber;
  String? group;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["categoryId"],
    name: json["name"],
    icon: json["icon"],
    publicId: json["publicId"],
    description: json["description"],
    supervisorName: json["supervisorName"],
    supervisorEmail: json["supervisorEmail"],
    supervisorNumber: json["supervisorNumber"],
    group: json["group"],
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
    "icon": icon,
    "publicId": publicId,
    "description": description,
    "supervisorName": supervisorName,
    "supervisorEmail": supervisorEmail,
    "supervisorNumber": supervisorNumber,
    "group": group,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
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
