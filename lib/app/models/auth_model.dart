class LoginModel {
  bool? success;
  String? message;
  LoginDataModel? data;
  int? code;

  LoginModel({this.success, this.message, this.data, this.code});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? LoginDataModel.fromJson(json['data']) : null;
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

class LoginDataModel {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? profilePhoto;
  String? coverPhoto;
  String? passwordHash;
  String? lastLoginDate;
  String? lastLoginFailedCount;
  String? passwordChangedOn;
  String? passwordExpirationDate;
  bool? isLoggedIn;
  String? status;
  bool? isEmailVerified;
  String? emailVerifiedOn;
  String? emailVerificationToken;
  bool? isPhoneVerified;
  String? phoneVerifiedOn;
  String? userTypeId;
  String? userType;
  String? authToken;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;

  LoginDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.profilePhoto,
      this.coverPhoto,
      this.passwordHash,
      this.lastLoginDate,
      this.lastLoginFailedCount,
      this.passwordChangedOn,
      this.passwordExpirationDate,
      this.isLoggedIn,
      this.status,
      this.isEmailVerified,
      this.emailVerifiedOn,
      this.emailVerificationToken,
      this.isPhoneVerified,
      this.phoneVerifiedOn,
      this.userTypeId,
      this.userType,
      this.authToken,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    profilePhoto = json['profilePhoto'];
    coverPhoto = json['coverPhoto'];
    passwordHash = json['passwordHash'];
    lastLoginDate = json['lastLoginDate'];
    lastLoginFailedCount = json['lastLoginFailedCount'];
    passwordChangedOn = json['passwordChangedOn'];
    passwordExpirationDate = json['passwordExpirationDate'];
    isLoggedIn = json['isLoggedIn'];
    status = json['status'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedOn = json['emailVerifiedOn'];
    emailVerificationToken = json['emailVerificationToken'];
    isPhoneVerified = json['isPhoneVerified'];
    phoneVerifiedOn = json['phoneVerifiedOn'];
    userTypeId = json['userTypeId'];
    userType = json['userType'];
    authToken = json['authToken'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['profilePhoto'] = profilePhoto;
    data['coverPhoto'] = coverPhoto;
    data['passwordHash'] = passwordHash;
    data['lastLoginDate'] = lastLoginDate;
    data['lastLoginFailedCount'] = lastLoginFailedCount;
    data['passwordChangedOn'] = passwordChangedOn;
    data['passwordExpirationDate'] = passwordExpirationDate;
    data['isLoggedIn'] = isLoggedIn;
    data['status'] = status;
    data['isEmailVerified'] = isEmailVerified;
    data['emailVerifiedOn'] = emailVerifiedOn;
    data['emailVerificationToken'] = emailVerificationToken;
    data['isPhoneVerified'] = isPhoneVerified;
    data['phoneVerifiedOn'] = phoneVerifiedOn;
    data['userTypeId'] = userTypeId;
    data['userType'] = userType;
    data['authToken'] = authToken;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    return data;
  }
}

class SignUpModel {
  bool? success;
  String? message;
  DataModel? data;
  int? code;

  SignUpModel({this.success, this.message, this.data, this.code});
  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
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

class DataModel {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? profilePhoto;
  String? coverPhoto;
  String? passwordHash;
  String? lastLoginDate;
  int? lastLoginFailedCount;
  String? passwordChangedOn;
  String? passwordExpirationDate;
  bool? isLoggedIn;
  String? status;
  bool? isEmailVerified;
  String? emailVerifiedOn;
  String? emailVerificationToken;
  bool? isPhoneVerified;
  String? phoneVerifiedOn;
  String? userTypeId;
  String? userType;
  String? authToken;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;

  DataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.profilePhoto,
      this.coverPhoto,
      this.passwordHash,
      this.lastLoginDate,
      this.lastLoginFailedCount,
      this.passwordChangedOn,
      this.passwordExpirationDate,
      this.isLoggedIn,
      this.status,
      this.isEmailVerified,
      this.emailVerifiedOn,
      this.emailVerificationToken,
      this.isPhoneVerified,
      this.phoneVerifiedOn,
      this.userTypeId,
      this.userType,
      this.authToken,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    profilePhoto = json['profilePhoto'];
    coverPhoto = json['coverPhoto'];
    passwordHash = json['passwordHash'];
    lastLoginDate = json['lastLoginDate'];
    lastLoginFailedCount = json['lastLoginFailedCount'];
    passwordChangedOn = json['passwordChangedOn'];
    passwordExpirationDate = json['passwordExpirationDate'];
    isLoggedIn = json['isLoggedIn'];
    status = json['status'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedOn = json['emailVerifiedOn'];
    emailVerificationToken = json['emailVerificationToken'];
    isPhoneVerified = json['isPhoneVerified'];
    phoneVerifiedOn = json['phoneVerifiedOn'];
    userTypeId = json['userTypeId'];
    userType = json['userType'];
    authToken = json['authToken'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['profilePhoto'] = profilePhoto;
    data['coverPhoto'] = coverPhoto;
    data['passwordHash'] = passwordHash;
    data['lastLoginDate'] = lastLoginDate;
    data['lastLoginFailedCount'] = lastLoginFailedCount;
    data['passwordChangedOn'] = passwordChangedOn;
    data['passwordExpirationDate'] = passwordExpirationDate;
    data['isLoggedIn'] = isLoggedIn;
    data['status'] = status;
    data['isEmailVerified'] = isEmailVerified;
    data['emailVerifiedOn'] = emailVerifiedOn;
    data['emailVerificationToken'] = emailVerificationToken;
    data['isPhoneVerified'] = isPhoneVerified;
    data['phoneVerifiedOn'] = phoneVerifiedOn;
    data['userTypeId'] = userTypeId;
    data['userType'] = userType;
    data['authToken'] = authToken;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    return data;
  }
}

class ForgotPasswordModel {
  bool? success;
  String? message;
  String? data;
  int? code;

  ForgotPasswordModel({this.success, this.message, this.data, this.code});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    data['code'] = code;
    return data;
  }
}

// class ResetPasswordModel {
//   late bool success;
//   String? message;
//   String? data;
//   int? code;
//   int? totalCount;

//   ResetPasswordModel({
//     required this.success,
//     this.message,
//     this.data,
//     this.code,
//     this.totalCount,
//   });

//   ResetPasswordModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? json["data"] : null;
//     code = json['code'];
//     totalCount = json['totalCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = data;
//     }
//     data['code'] = code;
//     data['totalCount'] = totalCount;
//     return data;
//   }
// }
class ResetPasswordModel {
  bool? success;
  String? message;
  String? data;
  int? code;

  ResetPasswordModel({this.success, this.message, this.data, this.code});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    data['code'] = code;
    return data;
  }
}
