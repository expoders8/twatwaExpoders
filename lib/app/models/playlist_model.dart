class PlaylistModel {
  bool? success;
  String? message;
  List<PlaylistDataModel>? data;
  int? code;

  PlaylistModel({this.success, this.message, this.data, this.code});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlaylistDataModel>[];
      json['data'].forEach((v) {
        data!.add(PlaylistDataModel.fromJson(v));
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

class PlaylistDataModel {
  String? id;
  String? userId;
  String? playlistName;
  String? privacyType;
  bool? isActive;
  bool? isChecked;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  String? videoIds;
  List<Videos>? videos;

  PlaylistDataModel(
      {this.id,
      this.userId,
      this.playlistName,
      this.privacyType,
      this.isActive,
      this.isChecked,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.videoIds,
      this.videos});

  PlaylistDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    playlistName = json['playlistName'];
    privacyType = json['privacyType'];
    isActive = json['isActive'];
    isChecked = json['isChecked'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    videoIds = json['video_Ids'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['playlistName'] = playlistName;
    data['privacyType'] = privacyType;
    data['isActive'] = isActive;
    data['isChecked'] = isChecked;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['video_Ids'] = videoIds;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String? id;
  String? videoReferenceId;
  String? videoEncoderReference;
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? categoryId;
  String? categoryName;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfShares;
  int? numberOfViews;
  String? videoQualityId;
  String? videoStreamingUrl;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoType;
  String? videoThumbnailId;
  String? videoHashTagId;
  int? videoDurationInSeconds;
  String? videoThumbnailImagePath;
  String? videoUploadStatus;
  bool? isLiked;
  bool? isDisliked;
  List? hashTags;

  Videos(
      {this.id,
      this.videoReferenceId,
      this.videoEncoderReference,
      this.title,
      this.description,
      this.userId,
      this.userName,
      this.categoryId,
      this.categoryName,
      this.numberOfLikes,
      this.numberOfDislikes,
      this.numberOfShares,
      this.numberOfViews,
      this.videoQualityId,
      this.videoStreamingUrl,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive,
      this.videoType,
      this.videoThumbnailId,
      this.videoHashTagId,
      this.videoDurationInSeconds,
      this.videoThumbnailImagePath,
      this.videoUploadStatus,
      this.isLiked,
      this.isDisliked,
      this.hashTags});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    videoEncoderReference = json['videoEncoderReference'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfShares = json['numberOfShares'];
    numberOfViews = json['numberOfViews'];
    videoQualityId = json['videoQualityId'];
    videoStreamingUrl = json['videoStreamingUrl'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoType = json['videoType'];
    videoThumbnailId = json['videoThumbnailId'];
    videoHashTagId = json['videoHashTagId'];
    videoDurationInSeconds = json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    videoUploadStatus = json['videoUploadStatus'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    if (json['hashTags'] != null) {
      hashTags = <Null>[];
      json['hashTags'].forEach((v) {
        hashTags!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videoReferenceId'] = videoReferenceId;
    data['videoEncoderReference'] = videoEncoderReference;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userName'] = userName;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfShares'] = numberOfShares;
    data['numberOfViews'] = numberOfViews;
    data['videoQualityId'] = videoQualityId;
    data['videoStreamingUrl'] = videoStreamingUrl;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoType'] = videoType;
    data['videoThumbnailId'] = videoThumbnailId;
    data['videoHashTagId'] = videoHashTagId;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['videoUploadStatus'] = videoUploadStatus;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    if (hashTags != null) {
      data['hashTags'] = hashTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
