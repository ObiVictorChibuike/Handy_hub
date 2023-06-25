

class DashboardPhotoResponse {
  dynamic category;
  List<DashboardPhoto>? dashboardPhoto;
  Status? status;

  DashboardPhotoResponse({
    this.category,
    this.dashboardPhoto,
    this.status,
  });

  factory DashboardPhotoResponse.fromJson(Map<String, dynamic> json) => DashboardPhotoResponse(
    category: json["category"],
    dashboardPhoto: json["dashboardPhoto"] == null ? [] : List<DashboardPhoto>.from(json["dashboardPhoto"]!.map((x) => DashboardPhoto.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "dashboardPhoto": dashboardPhoto == null ? [] : List<dynamic>.from(dashboardPhoto!.map((x) => x.toJson())),
    "status": status?.toJson(),
  };
}

class DashboardPhoto {
  int? dashboardPhotoId;
  String? photoUrl;
  dynamic photoString;
  String? publicId;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  DashboardPhoto({
    this.dashboardPhotoId,
    this.photoUrl,
    this.photoString,
    this.publicId,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory DashboardPhoto.fromJson(Map<String, dynamic> json) => DashboardPhoto(
    dashboardPhotoId: json["dashboardPhotoId"],
    photoUrl: json["photoUrl"],
    photoString: json["photoString"],
    publicId: json["publicId"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "dashboardPhotoId": dashboardPhotoId,
    "photoUrl": photoUrl,
    "photoString": photoString,
    "publicId": publicId,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
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
