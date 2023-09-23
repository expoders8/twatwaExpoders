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
  String? userProfileImage;
  String? categoryId;
  String? categoryName;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfShares;
  int? numberOfViews;
  int? numberOfFollowers;
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
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;
  String? videoUploadStatus;
  bool? isLiked;
  bool? isDisliked;
  bool? hasFollowers;
  List? hashTags;

  GetAllVideoDataModel(
      {this.id,
      this.videoReferenceId,
      this.videoEncoderReference,
      this.title,
      this.description,
      this.userId,
      this.userName,
      this.userProfileImage,
      this.categoryId,
      this.categoryName,
      this.numberOfLikes,
      this.numberOfDislikes,
      this.numberOfShares,
      this.numberOfViews,
      this.numberOfFollowers,
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
      this.hasFollowers,
      this.hashTags});

  GetAllVideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    videoEncoderReference = json['videoEncoderReference'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfShares = json['numberOfShares'];
    numberOfViews = json['numberOfViews'];
    numberOfFollowers = json['numberOfFollowers'];
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
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'] >= 0
            ? double.parse("${json['videoDurationInSeconds']}")
            : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    videoUploadStatus = json['videoUploadStatus'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    hasFollowers = json['hasFollowers'];
    hashTags = json['hashTags'];
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
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfShares'] = numberOfShares;
    data['numberOfViews'] = numberOfViews;
    data['numberOfFollowers'] = numberOfFollowers;
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
    data['hasFollowers'] = hasFollowers;
    data['hashTags'] = hashTags;
    return data;
  }
}

class GetVideoByIdModel {
  bool? success;
  String? message;
  GetVideoByIdDataModel? data;
  int? code;

  GetVideoByIdModel({this.success, this.message, this.data, this.code});

  GetVideoByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetVideoByIdDataModel.fromJson(json['data'])
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

class GetVideoByIdDataModel {
  String? id;
  String? videoReferenceId;
  String? videoEncoderReference;
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  String? categoryName;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfShares;
  int? numberOfViews;
  int? numberOfFollowers;
  String? videoQualityId;
  String? videoStreamingUrl;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoType;
  String? qualityJson;
  String? videoThumbnailId;
  String? videoHashTagId;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;
  String? videoUploadStatus;
  bool? isLiked;
  bool? isDisliked;
  bool? hasFollowers;
  List? hashTags;

  GetVideoByIdDataModel(
      {this.id,
      this.videoReferenceId,
      this.videoEncoderReference,
      this.title,
      this.description,
      this.userId,
      this.userName,
      this.userProfileImage,
      this.categoryId,
      this.categoryName,
      this.numberOfLikes,
      this.numberOfDislikes,
      this.numberOfShares,
      this.numberOfViews,
      this.numberOfFollowers,
      this.videoQualityId,
      this.videoStreamingUrl,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive,
      this.videoType,
      this.qualityJson,
      this.videoThumbnailId,
      this.videoHashTagId,
      this.videoDurationInSeconds,
      this.videoThumbnailImagePath,
      this.videoUploadStatus,
      this.isLiked,
      this.isDisliked,
      this.hasFollowers,
      this.hashTags});

  GetVideoByIdDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    videoEncoderReference = json['videoEncoderReference'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfShares = json['numberOfShares'];
    numberOfViews = json['numberOfViews'];
    numberOfFollowers = json['numberOfFollowers'];
    videoQualityId = json['videoQualityId'];
    videoStreamingUrl = json['videoStreamingUrl'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoType = json['videoType'];
    qualityJson = json['qualityJson'];
    videoThumbnailId = json['videoThumbnailId'];
    videoHashTagId = json['videoHashTagId'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    videoUploadStatus = json['videoUploadStatus'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    hasFollowers = json['hasFollowers'];
    hashTags = json['hashTags'];
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
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfShares'] = numberOfShares;
    data['numberOfViews'] = numberOfViews;
    data['numberOfFollowers'] = numberOfFollowers;
    data['videoQualityId'] = videoQualityId;
    data['videoStreamingUrl'] = videoStreamingUrl;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoType'] = videoType;
    data['qualityJson'] = qualityJson;
    data['videoThumbnailId'] = videoThumbnailId;
    data['videoHashTagId'] = videoHashTagId;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['videoUploadStatus'] = videoUploadStatus;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    data['hasFollowers'] = hasFollowers;
    data['hashTags'] = hashTags;
    return data;
  }
}

class GetVideoOfTheDay {
  bool? success;
  String? message;
  GetVideoOfTheDayData? data;
  int? code;

  GetVideoOfTheDay({this.success, this.message, this.data, this.code});

  GetVideoOfTheDay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetVideoOfTheDayData.fromJson(json['data'])
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

class GetVideoOfTheDayData {
  String? id;
  String? videoReferenceId;
  String? videoEncoderReference;
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  String? categoryName;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfShares;
  int? numberOfViews;
  String? videoQualityId;
  String? videoStreamingUrl;
  int? numberOfComments;
  int? numberOfPlaylists;
  int? numberOfFollowers;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoStreamingUrls;
  String? videoThumbnailImagePath;
  String? visibleStatusName;
  String? visibleStatusId;
  String? videoUploadStatus;
  String? thumbnailId;
  double? videoDurationInSeconds;
  String? videoDuration;
  bool? isLiked;
  bool? isDisliked;
  bool? isSaved;
  bool? isDonateEnabled;
  String? hashTags;

  GetVideoOfTheDayData(
      {this.id,
      this.videoReferenceId,
      this.videoEncoderReference,
      this.title,
      this.description,
      this.userId,
      this.userName,
      this.userProfileImage,
      this.categoryId,
      this.categoryName,
      this.numberOfLikes,
      this.numberOfDislikes,
      this.numberOfShares,
      this.numberOfViews,
      this.videoQualityId,
      this.videoStreamingUrl,
      this.numberOfComments,
      this.numberOfPlaylists,
      this.numberOfFollowers,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive,
      this.videoStreamingUrls,
      this.videoThumbnailImagePath,
      this.visibleStatusName,
      this.visibleStatusId,
      this.videoUploadStatus,
      this.thumbnailId,
      this.videoDurationInSeconds,
      this.videoDuration,
      this.isLiked,
      this.isDisliked,
      this.isSaved,
      this.isDonateEnabled,
      this.hashTags});

  GetVideoOfTheDayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    videoEncoderReference = json['videoEncoderReference'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfShares = json['numberOfShares'];
    numberOfViews = json['numberOfViews'];
    videoQualityId = json['videoQualityId'] ?? "";
    videoStreamingUrl = json['videoStreamingUrl'];
    numberOfComments = json['numberOfComments'];
    numberOfPlaylists = json['numberOfPlaylists'];
    numberOfFollowers = json['numberOfFollowers'];
    createdOn = json['createdOn'];
    createdById = json['createdById'] ?? "";
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoStreamingUrls = json['videoStreamingUrls'] ?? "";
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    visibleStatusName = json['visibleStatusName'] ?? "";
    visibleStatusId = json['visibleStatusId'] ?? "";
    videoUploadStatus = json['videoUploadStatus'] ?? "";
    thumbnailId = json['thumbnailId'] ?? "";
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoDuration = json['videoDuration'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    isSaved = json['isSaved'];
    isDonateEnabled = json['isDonateEnabled'];
    hashTags = json['hashTags'] ?? "";
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
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfShares'] = numberOfShares;
    data['numberOfViews'] = numberOfViews;
    data['videoQualityId'] = videoQualityId;
    data['videoStreamingUrl'] = videoStreamingUrl;
    data['numberOfComments'] = numberOfComments;
    data['numberOfPlaylists'] = numberOfPlaylists;
    data['numberOfFollowers'] = numberOfFollowers;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoStreamingUrls'] = videoStreamingUrls;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['visibleStatusName'] = visibleStatusName;
    data['visibleStatusId'] = visibleStatusId;
    data['videoUploadStatus'] = videoUploadStatus;
    data['thumbnailId'] = thumbnailId;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoDuration'] = videoDuration;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    data['isSaved'] = isSaved;
    data['isDonateEnabled'] = isDonateEnabled;
    data['hashTags'] = hashTags;
    return data;
  }
}
