class CountryModel {
  bool? success;
  String? message;
  List<CountryDataModel>? data;
  int? code;

  CountryModel({this.success, this.message, this.data, this.code});

  CountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CountryDataModel>[];
      json['data'].forEach((v) {
        data!.add(CountryDataModel.fromJson(v));
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

class CountryDataModel {
  String? id;
  String? name;
  String? createdOn;

  CountryDataModel({this.id, this.name, this.createdOn});

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdOn'] = createdOn;
    return data;
  }
}
