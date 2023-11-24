class VideoRequestModel {
  String? userId;
  String? videoType;
  String? categoryId;
  int? pageSize;
  int? pageNumber;
  String? searchText;
}

class VideoOfTheDayRequestModel {
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
  String? title;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  int? numberOfViews;
  int? numberOfFollowers;
  String? qualityJson;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;
  String? videoUploadStatus;
  bool? hasFollowers;

  GetAllVideoDataModel({
    this.id,
    this.title,
    this.userId,
    this.userName,
    this.userProfileImage,
    this.categoryId,
    this.numberOfViews,
    this.numberOfFollowers,
    this.qualityJson,
    this.videoDurationInSeconds,
    this.videoThumbnailImagePath,
    this.videoUploadStatus,
    this.hasFollowers,
  });

  GetAllVideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    numberOfViews = json['numberOfViews'];
    numberOfFollowers = json['numberOfFollowers'];
    qualityJson = json['qualityJson'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'] >= 0
            ? double.parse("${json['videoDurationInSeconds']}")
            : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    videoUploadStatus = json['videoUploadStatus'];
    hasFollowers = json['hasFollowers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['numberOfViews'] = numberOfViews;
    data['numberOfFollowers'] = numberOfFollowers;
    data['qualityJson'] = qualityJson;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['videoUploadStatus'] = videoUploadStatus;
    data['hasFollowers'] = hasFollowers;
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
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfViews;
  int? numberOfFollowers;
  String? videoStreamingUrl;
  String? createdOn;
  String? qualityJson;
  bool? isLiked;
  bool? isDisliked;
  bool? hasFollowers;

  GetVideoByIdDataModel({
    this.id,
    this.videoReferenceId,
    this.title,
    this.description,
    this.userId,
    this.userName,
    this.userProfileImage,
    this.categoryId,
    this.numberOfLikes,
    this.numberOfDislikes,
    this.numberOfViews,
    this.numberOfFollowers,
    this.videoStreamingUrl,
    this.createdOn,
    this.qualityJson,
    this.isLiked,
    this.isDisliked,
    this.hasFollowers,
  });

  GetVideoByIdDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfViews = json['numberOfViews'];
    numberOfFollowers = json['numberOfFollowers'];
    videoStreamingUrl = json['videoStreamingUrl'];
    createdOn = json['createdOn'];
    qualityJson = json['qualityJson'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    hasFollowers = json['hasFollowers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videoReferenceId'] = videoReferenceId;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfViews'] = numberOfViews;
    data['numberOfFollowers'] = numberOfFollowers;
    data['videoStreamingUrl'] = videoStreamingUrl;
    data['createdOn'] = createdOn;
    data['qualityJson'] = qualityJson;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    data['hasFollowers'] = hasFollowers;
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
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfShares;
  int? numberOfViews;
  int? numberOfFollowers;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoThumbnailImagePath;
  bool? isLiked;
  bool? isDisliked;

  GetVideoOfTheDayData({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.userName,
    this.userProfileImage,
    this.categoryId,
    this.numberOfLikes,
    this.numberOfDislikes,
    this.numberOfShares,
    this.numberOfViews,
    this.numberOfFollowers,
    this.createdOn,
    this.createdById,
    this.updatedOn,
    this.updatedById,
    this.isActive,
    this.videoThumbnailImagePath,
    this.isLiked,
    this.isDisliked,
  });

  GetVideoOfTheDayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfShares = json['numberOfShares'];
    numberOfViews = json['numberOfViews'];
    numberOfFollowers = json['numberOfFollowers'];
    createdOn = json['createdOn'];
    createdById = json['createdById'] ?? "";
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];

    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfShares'] = numberOfShares;
    data['numberOfViews'] = numberOfViews;
    data['numberOfFollowers'] = numberOfFollowers;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    return data;
  }
}
