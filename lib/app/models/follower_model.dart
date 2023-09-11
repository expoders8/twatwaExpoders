class GetFollower {
  bool? success;
  String? message;
  List<GetFollowerData>? data;
  int? code;

  GetFollower({this.success, this.message, this.data, this.code});

  GetFollower.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFollowerData>[];
      json['data'].forEach((v) {
        data!.add(GetFollowerData.fromJson(v));
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

class GetFollowerData {
  String? id;
  String? followerId;
  String? followeeId;
  String? followedOn;
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  int? numberOfFollowers;
  bool? isMyFollowing;
  bool? isMyFollower;
  String? userFcmKey;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;

  GetFollowerData(
      {this.id,
      this.followerId,
      this.followeeId,
      this.followedOn,
      this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.profilePhoto,
      this.numberOfFollowers,
      this.isMyFollowing,
      this.isMyFollower,
      this.userFcmKey,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive});

  GetFollowerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followerId = json['followerId'];
    followeeId = json['followeeId'];
    followedOn = json['followedOn'];
    userId = json['userId'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePhoto = json['profilePhoto'];
    numberOfFollowers = json['numberOfFollowers'];
    isMyFollowing = json['isMyFollowing'];
    isMyFollower = json['isMyFollower'];
    userFcmKey = json['userFcmKey'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['followerId'] = followerId;
    data['followeeId'] = followeeId;
    data['followedOn'] = followedOn;
    data['userId'] = userId;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePhoto'] = profilePhoto;
    data['numberOfFollowers'] = numberOfFollowers;
    data['isMyFollowing'] = isMyFollowing;
    data['isMyFollower'] = isMyFollower;
    data['userFcmKey'] = userFcmKey;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    return data;
  }
}
