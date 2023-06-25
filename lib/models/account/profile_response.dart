

class ProfileResponse {
  List<ServiceProvider>? serviceProviders;
  dynamic serviceProviderPage;
  dynamic requestedServices;
  dynamic requestedServicesPage;
  Status? status;
  dynamic counts;
  int? serviceProviderId;

  ProfileResponse({
    this.serviceProviders,
    this.serviceProviderPage,
    this.requestedServices,
    this.requestedServicesPage,
    this.status,
    this.counts,
    this.serviceProviderId,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
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
  String? category;
  dynamic confirmed;
  int? categoryId;
  int? stateId;
  int? countryId;
  int? servicesRendered;
  dynamic photoString;
  String? photoUrl;
  dynamic publicId;
  dynamic photo;
  dynamic password;
  String? referralCode;
  num? rating;
  dynamic fileName;
  dynamic fileExtension;
  String? description;
  dynamic latitude;
  dynamic longitude;
  bool? isConfirmed;
  bool? active;
  bool? isOnline;
  bool? isVerified;
  dynamic deleted;
  dynamic createdBy;
  DateTime? createdOn;
  DateTime? lastSeen;
  dynamic updatedBy;
  dynamic updatedOn;
  dynamic images;
  List<BusinessPhoto>? businessPhoto;

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
    this.photoString,
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
    this.isOnline,
    this.isVerified,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.lastSeen,
    this.updatedBy,
    this.updatedOn,
    this.images,
    this.businessPhoto,
  });

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
    photoString: json["photoString"],
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
    isOnline: json["isOnline"],
    isVerified: json["isVerified"],
    deleted: json["deleted"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
    updatedBy: json["updatedBy"],
    updatedOn: json["updatedOn"],
    images: json["images"],
    businessPhoto: json["businessPhoto"] == null ? [] : List<BusinessPhoto>.from(json["businessPhoto"]!.map((x) => BusinessPhoto.fromJson(x))),
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
    "photoString": photoString,
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
    "isOnline": isOnline,
    "isVerified": isVerified,
    "deleted": deleted,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
    "lastSeen": lastSeen?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedOn": updatedOn,
    "images": images,
    "businessPhoto": businessPhoto == null ? [] : List<dynamic>.from(businessPhoto!.map((x) => x.toJson())),
  };
}

class BusinessPhoto {
  int? businessPhotoIdId;
  int? serviceProviderId;
  String? photoUrl;
  String? publicPhotoIdId;
  bool? active;
  bool? deleted;
  dynamic createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  BusinessPhoto({
    this.businessPhotoIdId,
    this.serviceProviderId,
    this.photoUrl,
    this.publicPhotoIdId,
    this.active,
    this.deleted,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  factory BusinessPhoto.fromJson(Map<String, dynamic> json) => BusinessPhoto(
    businessPhotoIdId: json["businessPhotoIdId"],
    serviceProviderId: json["serviceProviderId"],
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
    "businessPhotoIdId": businessPhotoIdId,
    "serviceProviderId": serviceProviderId,
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
