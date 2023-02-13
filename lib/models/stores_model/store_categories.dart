class StoresCategory {
  int? categoryId;
  String? name;
  String? photoUrl;
  String? description;
  bool? active;
  bool? deleted;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  StoresCategory();

  StoresCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    photoUrl = json['image'];
    description = json['description'];
    active = json['active'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
  }
}
