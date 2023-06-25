// To parse this JSON data, do
//
//     final allReminderResponse = allReminderResponseFromJson(jsonString);

import 'dart:convert';

AllReminderResponse allReminderResponseFromJson(String str) => AllReminderResponse.fromJson(json.decode(str));

String allReminderResponseToJson(AllReminderResponse data) => json.encode(data.toJson());

class AllReminderResponse {
  List<Reminder>? reminder;
  Status? status;

  AllReminderResponse({
    this.reminder,
    this.status,
  });

  factory AllReminderResponse.fromJson(Map<String, dynamic> json) => AllReminderResponse(
    reminder: json["reminder"] == null ? [] : List<Reminder>.from(json["reminder"]!.map((x) => Reminder.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "reminder": reminder == null ? [] : List<dynamic>.from(reminder!.map((x) => x.toJson())),
    "status": status?.toJson(),
  };
}

class Reminder {
  int? reminderId;
  int? customerId;
  int? serviceProviderId;
  int? categoryId;
  int? days;
  DateTime? reminderDate;
  int? reminderStatus;
  bool? active;
  bool? deleted;
  dynamic createdBy;
  String? serviceProvider;
  String? category;
  String? reminderStatusName;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  Reminder({
    this.reminderId,
    this.customerId,
    this.serviceProviderId,
    this.categoryId,
    this.days,
    this.reminderDate,
    this.reminderStatus,
    this.active,
    this.deleted,
    this.createdBy,
    this.serviceProvider,
    this.category,
    this.reminderStatusName,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    reminderId: json["reminderId"],
    customerId: json["customerId"],
    serviceProviderId: json["serviceProviderId"],
    categoryId: json["categoryId"],
    days: json["days"],
    reminderDate: json["reminderDate"] == null ? null : DateTime.parse(json["reminderDate"]),
    reminderStatus: json["reminderStatus"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    serviceProvider: json["serviceProvider"],
    category: json["category"],
    reminderStatusName: json["reminderStatusName"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "reminderId": reminderId,
    "customerId": customerId,
    "serviceProviderId": serviceProviderId,
    "categoryId": categoryId,
    "days": days,
    "reminderDate": reminderDate?.toIso8601String(),
    "reminderStatus": reminderStatus,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "serviceProvider": serviceProvider,
    "category": category,
    "reminderStatusName": reminderStatusName,
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
