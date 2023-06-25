// To parse this JSON data, do
//
//     final allRequestedServicesResponse = allRequestedServicesResponseFromJson(jsonString);

import 'dart:convert';

AllRequestedServicesResponse allRequestedServicesResponseFromJson(String str) => AllRequestedServicesResponse.fromJson(json.decode(str));

String allRequestedServicesResponseToJson(AllRequestedServicesResponse data) => json.encode(data.toJson());

class AllRequestedServicesResponse {
  Response? response;
  Status? status;

  AllRequestedServicesResponse({
    this.response,
    this.status,
  });

  factory AllRequestedServicesResponse.fromJson(Map<String, dynamic> json) => AllRequestedServicesResponse(
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
  List<RequestedServices>? data;

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
    data: json["data"] == null ? [] : List<RequestedServices>.from(json["data"]!.map((x) => RequestedServices.fromJson(x))),
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

class RequestedServices {
  int? requestId;
  int? customerId;
  int? reminderId;
  String? fullName;
  dynamic customerName;
  String? email;
  String? phoneNumber;
  String? phoneNumber2;
  String? location;
  String? refNumber;
  String? serviceProvider;
  String? category;
  String? photoUrl;
  dynamic photo;
  int? categoryId;
  int? serviceProviderId;
  int? jobStatusId;
  String? jobStatusName;
  double? rating;
  bool? hasRated;
  int? amount;
  bool? paymentStatus;
  bool? isVerified;
  dynamic transactionRef;
  dynamic paymentType;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  RequestedServices({
    this.requestId,
    this.customerId,
    this.reminderId,
    this.fullName,
    this.customerName,
    this.email,
    this.phoneNumber,
    this.phoneNumber2,
    this.location,
    this.refNumber,
    this.serviceProvider,
    this.category,
    this.photoUrl,
    this.photo,
    this.categoryId,
    this.serviceProviderId,
    this.jobStatusId,
    this.jobStatusName,
    this.rating,
    this.hasRated,
    this.amount,
    this.paymentStatus,
    this.isVerified,
    this.transactionRef,
    this.paymentType,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory RequestedServices.fromJson(Map<String, dynamic> json) => RequestedServices(
    requestId: json["requestId"],
    customerId: json["customerId"],
    reminderId: json["reminderId"],
    fullName: json["fullName"],
    customerName: json["customerName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    phoneNumber2: json["phoneNumber2"],
    location: json["location"],
    refNumber: json["refNumber"],
    serviceProvider: json["serviceProvider"],
    category: json["category"],
    photoUrl: json["photoUrl"],
    photo: json["photo"],
    categoryId: json["categoryId"],
    serviceProviderId: json["serviceProviderId"],
    jobStatusId: json["jobStatusId"],
    jobStatusName: json["jobStatusName"],
    rating: json["rating"]?.toDouble(),
    hasRated: json["hasRated"],
    amount: json["amount"],
    paymentStatus: json["paymentStatus"],
    isVerified: json["isVerified"],
    transactionRef: json["transactionRef"],
    paymentType: json["paymentType"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "customerId": customerId,
    "reminderId": reminderId,
    "fullName": fullName,
    "customerName": customerName,
    "email": email,
    "phoneNumber": phoneNumber,
    "phoneNumber2": phoneNumber2,
    "location": location,
    "refNumber": refNumber,
    "serviceProvider": serviceProvider,
    "category": category,
    "photoUrl": photoUrl,
    "photo": photo,
    "categoryId": categoryId,
    "serviceProviderId": serviceProviderId,
    "jobStatusId": jobStatusId,
    "jobStatusName": jobStatusName,
    "rating": rating,
    "hasRated": hasRated,
    "amount": amount,
    "paymentStatus": paymentStatus,
    "isVerified": isVerified,
    "transactionRef": transactionRef,
    "paymentType": paymentType,
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
