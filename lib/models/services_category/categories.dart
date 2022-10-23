class CategoriesModel {
  int? categoryId;
  String? name;
  String? icon;
  String? publicId;
  String? description;
  String? supervisorName;
  String? supervisorEmail;
  String? supervisorNumber;
  String? group;
  bool? active;
  bool? deleted;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  CategoriesModel();

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    icon = json['icon'];
    publicId = json['publicId'];
    description = json['description'];
    supervisorName = json['supervisorName'];
    supervisorEmail = json['supervisorEmail'];
    supervisorNumber = json['supervisorNumber'];
    group = json['group'];
    active = json['active'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
  }
}
