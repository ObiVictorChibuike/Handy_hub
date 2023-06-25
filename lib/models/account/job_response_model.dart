
class JobResponseModel {
  dynamic serviceProviders;
  dynamic serviceProviderPage;
  List<RequestedService>? jobs;
  dynamic requestedServicesPage;
  Status? status;
  dynamic counts;
  int? serviceProviderId;

  JobResponseModel({
    this.serviceProviders,
    this.serviceProviderPage,
    this.jobs,
    this.requestedServicesPage,
    this.status,
    this.counts,
    this.serviceProviderId,
  });

  factory JobResponseModel.fromJson(Map<String, dynamic> json) => JobResponseModel(
    serviceProviders: json["serviceProviders"],
    serviceProviderPage: json["serviceProvider_page"],
    jobs: json["requestedServices"] == null ? [] : List<RequestedService>.from(json["requestedServices"]!.map((x) => RequestedService.fromJson(x))),
    requestedServicesPage: json["requestedServices_page"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    counts: json["counts"],
    serviceProviderId: json["serviceProviderId"],
  );

  Map<String, dynamic> toJson() => {
    "serviceProviders": serviceProviders,
    "serviceProvider_page": serviceProviderPage,
    "requestedServices": jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x.toJson())),
    "requestedServices_page": requestedServicesPage,
    "status": status?.toJson(),
    "counts": counts,
    "serviceProviderId": serviceProviderId,
  };
}

class RequestedService {
  num? requestId;
  num? customerId;
  num? reminderId;
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
  num? rating;
  bool? hasRated;
  num? amount;
  bool? paymentStatus;
  dynamic transactionRef;
  dynamic paymentType;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  RequestedService({
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
    this.transactionRef,
    this.paymentType,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory RequestedService.fromJson(Map<String, dynamic> json) => RequestedService(
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
    rating: json["rating"],
    hasRated: json["hasRated"],
    amount: json["amount"],
    paymentStatus: json["paymentStatus"],
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
