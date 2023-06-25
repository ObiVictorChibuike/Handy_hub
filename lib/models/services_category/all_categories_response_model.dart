

class AllCategoryResponse {
  List<AllCategory>? category;
  Status? status;

  AllCategoryResponse({
    this.category,
    this.status,
  });

  factory AllCategoryResponse.fromJson(Map<String, dynamic> json) => AllCategoryResponse(
    category: json["category"] == null ? [] : List<AllCategory>.from(json["category"]!.map((x) => AllCategory.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
    "status": status?.toJson(),
  };
}

class AllCategory {
  int? categoryId;
  String? name;
  String? icon;
  dynamic publicId;
  String? description;
  SupervisorName? supervisorName;
  SupervisorEmail? supervisorEmail;
  String? supervisorNumber;
  Group? group;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  AllCategory({
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

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
    categoryId: json["categoryId"],
    name: json["name"],
    icon: json["icon"],
    publicId: json["publicId"],
    description: json["description"],
    supervisorName: supervisorNameValues.map[json["supervisorName"]]!,
    supervisorEmail: supervisorEmailValues.map[json["supervisorEmail"]]!,
    supervisorNumber: json["supervisorNumber"],
    group: groupValues.map[json["group"]]!,
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
    "supervisorName": supervisorNameValues.reverse[supervisorName],
    "supervisorEmail": supervisorEmailValues.reverse[supervisorEmail],
    "supervisorNumber": supervisorNumber,
    "group": groupValues.reverse[group],
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
  };
}

enum Group { B, C, E, D, G, GROUP_D, GROUP_GROUP_C, GROUP_C }

final groupValues = EnumValues({
  "B": Group.B,
  "C": Group.C,
  "D": Group.D,
  "E": Group.E,
  "g": Group.G,
  "c": Group.GROUP_C,
  "d": Group.GROUP_D,
  "group c": Group.GROUP_GROUP_C
});

enum SupervisorEmail { GOODYRHOME_GMAIL_COM, SUPERVISOR_EMAIL_GOODYRHOME_GMAIL_COM, PURPLE_GOODYRHOME_GMAIL_COM, GROUPD_ESOLINK_GMAIL_COM, GROUPB_ESOLINK_GMAIL_COM, SUPERVISOR_EMAIL_GROUPD_ESOLINK_GMAIL_COM }

final supervisorEmailValues = EnumValues({
  "goodyrhome@gmail.com ": SupervisorEmail.GOODYRHOME_GMAIL_COM,
  "groupb.esolink@gmail.com ": SupervisorEmail.GROUPB_ESOLINK_GMAIL_COM,
  "groupd.esolink@gmail.com": SupervisorEmail.GROUPD_ESOLINK_GMAIL_COM,
  "Goodyrhome@gmail.com": SupervisorEmail.PURPLE_GOODYRHOME_GMAIL_COM,
  "goodyrhome@gmail.com": SupervisorEmail.SUPERVISOR_EMAIL_GOODYRHOME_GMAIL_COM,
  "groupd.esolink@gmail.com ": SupervisorEmail.SUPERVISOR_EMAIL_GROUPD_ESOLINK_GMAIL_COM
});

enum SupervisorName { FORTUNE_JOHNBULL, ENWONGO_UDOFIA, GOODLUCK_OGEDZO, GOODLUCK, HELEN_EKANEM, OGEZO, SUPERVISOR_NAME_ENWONGO_UDOFIA }

final supervisorNameValues = EnumValues({
  "Enwongo Udofia": SupervisorName.ENWONGO_UDOFIA,
  "Fortune Johnbull": SupervisorName.FORTUNE_JOHNBULL,
  "Goodluck": SupervisorName.GOODLUCK,
  "Goodluck Ogedzo": SupervisorName.GOODLUCK_OGEDZO,
  "Helen Ekanem": SupervisorName.HELEN_EKANEM,
  "Ogezo": SupervisorName.OGEZO,
  "Enwongo Udofia ": SupervisorName.SUPERVISOR_NAME_ENWONGO_UDOFIA
});

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
