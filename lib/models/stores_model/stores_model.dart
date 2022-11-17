class Stores {
  int? productId;
  int? vendorId;
  int? categoryId;
  String? name;
  String? vendorName;
  String? categoryName;
  String? image;
  String? images;
  int? publicId;
  String? photoUrl;
  List<PhotoUrlList>? photoUrlList;
  String? description;
  double? amount;
  bool? active;
  bool? deleted;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  Stores(
      {this.productId,
      this.vendorId,
      this.categoryId,
      this.name,
      this.vendorName,
      this.categoryName,
      this.image,
      this.images,
      this.publicId,
      this.photoUrl,
      this.photoUrlList,
      this.description,
      this.amount,
      this.active,
      this.deleted,
      this.createdBy,
      this.createdOn,
      this.updatedBy,
      this.updatedOn});

  Stores.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    vendorId = json['vendorId'];
    categoryId = json['categoryId'];
    name = json['name'];
    vendorName = json['vendorName'];
    categoryName = json['categoryName'];
    image = json['image'];
    images = json['images'];
    publicId = json['publicId'];
    photoUrl = json['photoUrl'];
    if (json['photoUrlList'] != null) {
      photoUrlList = <PhotoUrlList>[];
      json['photoUrlList'].forEach((v) {
        photoUrlList!.add(PhotoUrlList.fromJson(v));
      });
    }
    description = json['description'];
    amount = json['amount'];
    active = json['active'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
  }
}

class PhotoUrlList {
  int? productPhotoIdId;
  int? productId;
  String? photoUrl;
  String? publicPhotoIdId;
  bool? active;
  bool? deleted;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  PhotoUrlList(
      {this.productPhotoIdId,
      this.productId,
      this.photoUrl,
      this.publicPhotoIdId,
      this.active,
      this.deleted,
      this.createdBy,
      this.createdOn,
      this.updatedBy,
      this.updatedOn});

  PhotoUrlList.fromJson(Map<String, dynamic> json) {
    productPhotoIdId = json['productPhotoIdId'];
    productId = json['productId'];
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
