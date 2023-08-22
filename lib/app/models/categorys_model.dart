class GetAllCategory {
  bool? success;
  String? message;
  List? data;
  int? code;

  GetAllCategory({this.success, this.message, this.data, this.code});

  GetAllCategory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(GetAllCategory.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class CategoryData {
  String? id;
  String? name;
  String? icon;
  String? iconSelected;
  String? createdOn;

  CategoryData(
      {this.id, this.name, this.icon, this.iconSelected, this.createdOn});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    iconSelected = json['iconSelected'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['iconSelected'] = iconSelected;
    data['createdOn'] = createdOn;
    return data;
  }
}
