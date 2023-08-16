class VideoRequestModel {
  String? videoId;
  String? userId;
  String? userName;
  String? videoType;
  String? currentUserId;
  String? categoryId;
  String? thumbnailId;
  String? categoryName;
  String? playlistId;
  String? videoReferenceId;
  String? videoEncoderReference;
  String? visibleStatus;
  String? videoUploadStatus;
  String? requestType;
  String? hashTag;
  int? pageSize;
  int? pageNumber;
  String? searchText;
  String? sortBy;
}

class GetAllVideoModel {
  bool? success;
  String? message;
  List<GetAllVideoDataModel>? data;
  int? code;

  GetAllVideoModel({this.success, this.message, this.data, this.code});

  GetAllVideoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllVideoDataModel>[];
      json['data'].forEach((v) {
        data!.add(GetAllVideoDataModel.fromJson(v));
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

class GetAllVideoDataModel {
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

  GetAllVideoDataModel(
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
      this.videoThumbnailImagePath});

  GetAllVideoDataModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
