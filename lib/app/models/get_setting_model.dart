class GetSettingsModel {
  bool? success;
  String? message;
  GetSettingsModelData? data;
  int? code;

  GetSettingsModel({this.success, this.message, this.data, this.code});

  GetSettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetSettingsModelData.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class GetSettingsModelData {
  String? stripePublishableApiKey;
  String? googlePlaceApiKey;
  String? paypalDomainUrl;
  String? paypalClientId;
  String? paypalClientSecret;
  String? ipRegistryKey;

  GetSettingsModelData(
      {this.stripePublishableApiKey,
      this.googlePlaceApiKey,
      this.paypalDomainUrl,
      this.paypalClientId,
      this.paypalClientSecret,
      this.ipRegistryKey});

  GetSettingsModelData.fromJson(Map<String, dynamic> json) {
    stripePublishableApiKey = json['stripePublishableApiKey'];
    googlePlaceApiKey = json['googlePlaceApiKey'];
    paypalDomainUrl = json['paypalDomainUrl'];
    paypalClientId = json['paypalClientId'];
    paypalClientSecret = json['paypalClientSecret'];
    ipRegistryKey = json['ipRegistryKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stripePublishableApiKey'] = stripePublishableApiKey;
    data['googlePlaceApiKey'] = googlePlaceApiKey;
    data['paypalDomainUrl'] = paypalDomainUrl;
    data['paypalClientId'] = paypalClientId;
    data['paypalClientSecret'] = paypalClientSecret;
    data['ipRegistryKey'] = ipRegistryKey;
    return data;
  }
}
