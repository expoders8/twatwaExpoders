class GetAllNotification {
  bool? success;
  String? message;
  List<GetAllNotificationData>? data;
  int? code;

  GetAllNotification({this.success, this.message, this.data, this.code});

  GetAllNotification.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllNotificationData>[];
      json['data'].forEach((v) {
        data!.add(GetAllNotificationData.fromJson(v));
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

class GetAllNotificationData {
  String? id;
  String? notificationTitle;
  String? notificationText;
  String? receiverUserId;
  String? notificationType;
  String? videoReferenceId;
  String? videoId;
  String? userId;
  String? userName;
  String? userProfilePhoto;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;

  GetAllNotificationData(
      {this.id,
      this.notificationTitle,
      this.notificationText,
      this.receiverUserId,
      this.notificationType,
      this.videoReferenceId,
      this.videoId,
      this.userId,
      this.userName,
      this.userProfilePhoto,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive});

  GetAllNotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationTitle = json['notificationTitle'];
    notificationText = json['notificationText'];
    receiverUserId = json['receiverUserId'];
    notificationType = json['notificationType'];
    videoReferenceId = json['videoReferenceId'];
    videoId = json['videoId'];
    userId = json['userId'];
    userName = json['userName'];
    userProfilePhoto = json['userProfilePhoto'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notificationTitle'] = notificationTitle;
    data['notificationText'] = notificationText;
    data['receiverUserId'] = receiverUserId;
    data['notificationType'] = notificationType;
    data['videoReferenceId'] = videoReferenceId;
    data['videoId'] = videoId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfilePhoto'] = userProfilePhoto;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    return data;
  }
}
