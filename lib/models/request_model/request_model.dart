class RequestsModel {
  int? serviceProviderId;
  int? customerTypeId;
  String? customerTypeName;
  String? fullName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? wallet;
  String? email;
  String? businessName;
  String? address;
  String? distance;
  dynamic distanceNumber;
  String? category;
  String? confirmed;
  int? categoryId;
  int? stateId;
  int? countryId;
  int? servicesRendered;
  String? photoUrl;
  String? publicId;
  String? photo;
  String? password;
  String? referralCode;
  // double? rating;
  String? fileName;
  String? fileExtension;
  String? description;
  String? latitude;
  String? longitude;
  bool? isConfirmed;
  String? active;
  String? deleted;
  String? createdBy;
  String? createdOn;
  String? lastSeen;
  String? updatedBy;
  String? updatedOn;
  String? images;
  List<BusinessPhoto>? businessPhoto;

  RequestsModel();

  RequestsModel.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json['serviceProviderId'];
    customerTypeId = json['customerTypeId'];
    customerTypeName = json['customerTypeName'];
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    wallet = json['wallet'];
    email = json['email'];
    businessName = json['businessName'];
    address = json['address'];
    distance = json['distance'];
    distanceNumber = json['distanceNumber'];
    category = json['category'];
    confirmed = json['confirmed'];
    categoryId = json['categoryId'];
    stateId = json['stateId'];
    countryId = json['countryId'];
    servicesRendered = json['servicesRendered'];
    photoUrl = json['photoUrl'];
    publicId = json['publicId'];
    photo = json['photo'];
    password = json['password'];
    referralCode = json['referralCode'];
    // rating = json['rating'];
    fileName = json['fileName'];
    fileExtension = json['fileExtension'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isConfirmed = json['isConfirmed'];
    active = json['active'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    lastSeen = json['lastSeen'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    images = json['images'];
    if (json['businessPhoto'] != null) {
      businessPhoto = <BusinessPhoto>[];
      json['businessPhoto'].forEach((v) {
        businessPhoto!.add(BusinessPhoto.fromJson(v));
      });
    }
  }
}

class BusinessPhoto {
  int? businessPhotoIdId;
  int? serviceProviderId;
  String? photoUrl;
  String? publicPhotoIdId;
  bool? active;
  bool? deleted;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  BusinessPhoto();

  BusinessPhoto.fromJson(Map<String, dynamic> json) {
    businessPhotoIdId = json['businessPhotoIdId'];
    serviceProviderId = json['serviceProviderId'];
    photoUrl = json['photoUrl'];
    publicPhotoIdId = json['publicPhotoIdId'];
    active = json['active'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
  }
}
