// To parse this JSON data, do
//
//     final authUserResponse = authUserResponseFromJson(jsonString);

import 'dart:convert';

AuthUserResponse authUserResponseFromJson(String str) => AuthUserResponse.fromJson(json.decode(str));

String authUserResponseToJson(AuthUserResponse data) => json.encode(data.toJson());

class AuthUserResponse {
  AuthUserResponse({
    this.serviceProviders,
    this.serviceProviderPage,
    this.requestedServices,
    this.requestedServicesPage,
    this.status,
    this.counts,
    this.serviceProviderId,
  });

  List<ServiceProvider>? serviceProviders;
  dynamic serviceProviderPage;
  dynamic requestedServices;
  dynamic requestedServicesPage;
  Status? status;
  dynamic counts;
  num? serviceProviderId;

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) => AuthUserResponse(
    serviceProviders: json["serviceProviders"] == null ? [] : List<ServiceProvider>.from(json["serviceProviders"]!.map((x) => ServiceProvider.fromJson(x))),
    serviceProviderPage: json["serviceProvider_page"],
    requestedServices: json["requestedServices"],
    requestedServicesPage: json["requestedServices_page"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    counts: json["counts"],
    serviceProviderId: json["serviceProviderId"],
  );

  Map<String, dynamic> toJson() => {
    "serviceProviders": serviceProviders == null ? [] : List<dynamic>.from(serviceProviders!.map((x) => x.toJson())),
    "serviceProvider_page": serviceProviderPage,
    "requestedServices": requestedServices,
    "requestedServices_page": requestedServicesPage,
    "status": status?.toJson(),
    "counts": counts,
    "serviceProviderId": serviceProviderId,
  };
}

class ServiceProvider {
  ServiceProvider({
    this.serviceProviderId,
    this.customerTypeId,
    this.customerTypeName,
    this.fullName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.wallet,
    this.email,
    this.businessName,
    this.address,
    this.distance,
    this.distanceNumber,
    this.category,
    this.confirmed,
    this.categoryId,
    this.stateId,
    this.countryId,
    this.servicesRendered,
    this.photoUrl,
    this.publicId,
    this.photo,
    this.password,
    this.referralCode,
    this.rating,
    this.fileName,
    this.fileExtension,
    this.description,
    this.latitude,
    this.longitude,
    this.isConfirmed,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.lastSeen,
    this.updatedBy,
    this.updatedOn,
    this.images,
    this.businessPhoto,
  });

  int? serviceProviderId;
  int? customerTypeId;
  String? customerTypeName;
  dynamic fullName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  num? wallet;
  String? email;
  dynamic businessName;
  String? address;
  dynamic distance;
  num? distanceNumber;
  dynamic category;
  dynamic confirmed;
  num? categoryId;
  num? stateId;
  num? countryId;
  num? servicesRendered;
  String? photoUrl;
  dynamic publicId;
  dynamic photo;
  dynamic password;
  dynamic referralCode;
  num? rating;
  dynamic fileName;
  dynamic fileExtension;
  String? description;
  dynamic latitude;
  dynamic longitude;
  bool? isConfirmed;
  dynamic active;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdOn;
  dynamic lastSeen;
  dynamic updatedBy;
  dynamic updatedOn;
  dynamic images;
  dynamic businessPhoto;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
    serviceProviderId: json["serviceProviderId"],
    customerTypeId: json["customerTypeId"],
    customerTypeName: json["customerTypeName"],
    fullName: json["fullName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    wallet: json["wallet"],
    email: json["email"],
    businessName: json["businessName"],
    address: json["address"],
    distance: json["distance"],
    distanceNumber: json["distanceNumber"],
    category: json["category"],
    confirmed: json["confirmed"],
    categoryId: json["categoryId"],
    stateId: json["stateId"],
    countryId: json["countryId"],
    servicesRendered: json["servicesRendered"],
    photoUrl: json["photoUrl"],
    publicId: json["publicId"],
    photo: json["photo"],
    password: json["password"],
    referralCode: json["referralCode"],
    rating: json["rating"],
    fileName: json["fileName"],
    fileExtension: json["fileExtension"],
    description: json["description"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isConfirmed: json["isConfirmed"],
    active: json["active"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"],
    lastSeen: json["lastSeen"],
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
    images: json["images"],
    businessPhoto: json["businessPhoto"],
  );

  Map<String, dynamic> toJson() => {
    "serviceProviderId": serviceProviderId,
    "customerTypeId": customerTypeId,
    "customerTypeName": customerTypeName,
    "fullName": fullName,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "wallet": wallet,
    "email": email,
    "businessName": businessName,
    "address": address,
    "distance": distance,
    "distanceNumber": distanceNumber,
    "category": category,
    "confirmed": confirmed,
    "categoryId": categoryId,
    "stateId": stateId,
    "countryId": countryId,
    "servicesRendered": servicesRendered,
    "photoUrl": photoUrl,
    "publicId": publicId,
    "photo": photo,
    "password": password,
    "referralCode": referralCode,
    "rating": rating,
    "fileName": fileName,
    "fileExtension": fileExtension,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "isConfirmed": isConfirmed,
    "active": active,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn,
    "lastSeen": lastSeen,
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
    "images": images,
    "businessPhoto": businessPhoto,
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
