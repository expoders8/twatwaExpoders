class GetAllHasTags {
  bool? success;
  String? message;
  List<HasTagsData>? data;
  int? code;

  GetAllHasTags({this.success, this.message, this.data, this.code});

  GetAllHasTags.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HasTagsData>[];
      json['data'].forEach((v) {
        data!.add(HasTagsData.fromJson(v));
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

class HasTagsData {
  String? id;
  String? name;
  String? categoryId;
  String? categoryName;
  String? createdOn;

  HasTagsData(
      {this.id, this.name, this.categoryId, this.categoryName, this.createdOn});

  HasTagsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['createdOn'] = createdOn;
    return data;
  }
}
