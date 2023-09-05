class GetAllVideoLanding {
  bool? success;
  String? message;
  GetAllVideoLandingData? data;
  int? code;

  GetAllVideoLanding({this.success, this.message, this.data, this.code});

  GetAllVideoLanding.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetAllVideoLandingData.fromJson(json['data'])
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

class GetAllVideoLandingData {
  List<DisocverVideo>? disocverVideo;
  List? trendingVideo;
  List? followingVideo;
  List? categoriesVideo;
  VideoOfTheDay? videoOfTheDay;
  List<Categories>? categories;

  GetAllVideoLandingData(
      {this.disocverVideo,
      this.trendingVideo,
      this.followingVideo,
      this.categoriesVideo,
      this.videoOfTheDay,
      this.categories});

  GetAllVideoLandingData.fromJson(Map<String, dynamic> json) {
    if (json['disocverVideo'] != null) {
      disocverVideo = <DisocverVideo>[];
      json['disocverVideo'].forEach((v) {
        disocverVideo!.add(DisocverVideo.fromJson(v));
      });
    }
    if (json['trendingVideo'] != null) {
      trendingVideo = <Null>[];
      json['trendingVideo'].forEach((v) {
        trendingVideo!.add(v);
      });
    }
    if (json['followingVideo'] != null) {
      followingVideo = <Null>[];
      json['followingVideo'].forEach((v) {
        followingVideo!.add(v);
      });
    }
    categoriesVideo = json['categoriesVideo'];
    videoOfTheDay = json['videoOfTheDay'] != null
        ? VideoOfTheDay.fromJson(json['videoOfTheDay'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disocverVideo != null) {
      data['disocverVideo'] = disocverVideo!.map((v) => v.toJson()).toList();
    }
    if (trendingVideo != null) {
      data['trendingVideo'] = trendingVideo!.map((v) => v.toJson()).toList();
    }
    if (followingVideo != null) {
      data['followingVideo'] = followingVideo!.map((v) => v.toJson()).toList();
    }
    data['categoriesVideo'] = categoriesVideo;
    if (videoOfTheDay != null) {
      data['videoOfTheDay'] = videoOfTheDay!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisocverVideo {
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
  List? hashTags;

  DisocverVideo(
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
      this.hashTags});

  DisocverVideo.fromJson(Map<String, dynamic> json) {
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
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    videoUploadStatus = json['videoUploadStatus'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
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
    data['hashTags'] = hashTags;
    return data;
  }
}

class VideoOfTheDay {
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
  List? hashTags;

  VideoOfTheDay(
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

  VideoOfTheDay.fromJson(Map<String, dynamic> json) {
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
    videoQualityId = json['videoQualityId'];
    videoStreamingUrl = json['videoStreamingUrl'];
    numberOfComments = json['numberOfComments'];
    numberOfPlaylists = json['numberOfPlaylists'];
    numberOfFollowers = json['numberOfFollowers'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoStreamingUrls = json['videoStreamingUrls'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    visibleStatusName = json['visibleStatusName'];
    visibleStatusId = json['visibleStatusId'];
    videoUploadStatus = json['videoUploadStatus'];
    thumbnailId = json['thumbnailId'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoDuration = json['videoDuration'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
    isSaved = json['isSaved'];
    isDonateEnabled = json['isDonateEnabled'];
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

class Categories {
  String? categoryId;
  String? categoryName;
  List<VideoList>? videoList;

  Categories({this.categoryId, this.categoryName, this.videoList});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    if (json['videoList'] != null) {
      videoList = <VideoList>[];
      json['videoList'].forEach((v) {
        videoList!.add(VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    if (videoList != null) {
      data['videoList'] = videoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoList {
  String? videoId;
  String? videoReferenceId;
  String? videoEncoderReference;
  String? title;
  String? description;
  String? userId;
  String? userName;
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
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;

  VideoList(
      {this.videoId,
      this.videoReferenceId,
      this.videoEncoderReference,
      this.title,
      this.description,
      this.userId,
      this.userName,
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

  VideoList.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    videoReferenceId = json['videoReferenceId'];
    videoEncoderReference = json['videoEncoderReference'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
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
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['videoReferenceId'] = videoReferenceId;
    data['videoEncoderReference'] = videoEncoderReference;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userName'] = userName;
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




// class GetAllVideoLanding {
//   bool? success;
//   String? message;
//   GetAllDataVideoLanding? data;
//   int? code;

//   GetAllVideoLanding({this.success, this.message, this.data, this.code});

//   GetAllVideoLanding.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null
//         ? GetAllDataVideoLanding.fromJson(json['data'])
//         : null;
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['code'] = code;
//     return data;
//   }
// }

// class GetAllDataVideoLanding {
//   List? disocverVideo;
//   List<TrendingVideo>? trendingVideo;
//   List? followingVideo;
//   List? categoriesVideo;
//   VideoOfTheDay? videoOfTheDay;
//   List? categories;

//   GetAllDataVideoLanding(
//       {this.disocverVideo,
//       this.trendingVideo,
//       this.followingVideo,
//       this.categoriesVideo,
//       this.videoOfTheDay,
//       this.categories});

//   GetAllDataVideoLanding.fromJson(Map<String, dynamic> json) {
//     if (json['disocverVideo'] != null) {
//       disocverVideo = <Null>[];
//       json['disocverVideo'].forEach((v) {
//         disocverVideo!.add(v);
//       });
//     }
//     if (json['trendingVideo'] != null) {
//       trendingVideo = <TrendingVideo>[];
//       json['trendingVideo'].forEach((v) {
//         trendingVideo!.add(TrendingVideo.fromJson(v));
//       });
//     }
//     if (json['followingVideo'] != null) {
//       followingVideo = <Null>[];
//       json['followingVideo'].forEach((v) {
//         followingVideo!.add(v);
//       });
//     }
//     categoriesVideo = json['categoriesVideo'];
//     videoOfTheDay = json['videoOfTheDay'] != null
//         ? VideoOfTheDay.fromJson(json['videoOfTheDay'])
//         : null;
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(Categories.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (disocverVideo != null) {
//       data['disocverVideo'] = disocverVideo!.map((v) => v.toJson()).toList();
//     }
//     if (trendingVideo != null) {
//       data['trendingVideo'] = trendingVideo!.map((v) => v.toJson()).toList();
//     }
//     if (followingVideo != null) {
//       data['followingVideo'] = followingVideo!.map((v) => v.toJson()).toList();
//     }
//     data['categoriesVideo'] = categoriesVideo;
//     if (videoOfTheDay != null) {
//       data['videoOfTheDay'] = videoOfTheDay!.toJson();
//     }
//     if (categories != null) {
//       data['categories'] = categories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TrendingVideo {
//   String? id;
//   String? videoReferenceId;
//   String? videoEncoderReference;
//   String? title;
//   String? description;
//   String? userId;
//   String? userName;
//   String? userProfileImage;
//   String? categoryId;
//   String? categoryName;
//   int? numberOfLikes;
//   int? numberOfDislikes;
//   int? numberOfShares;
//   int? numberOfViews;
//   int? numberOfFollowers;
//   String? videoQualityId;
//   String? videoStreamingUrl;
//   String? createdOn;
//   String? createdById;
//   String? updatedOn;
//   String? updatedById;
//   bool? isActive;
//   String? videoType;
//   String? videoThumbnailId;
//   String? videoHashTagId;
//   double? videoDurationInSeconds;
//   String? videoThumbnailImagePath;
//   String? videoUploadStatus;
//   bool? isLiked;
//   bool? isDisliked;
//   List? hashTags;

//   TrendingVideo(
//       {this.id,
//       this.videoReferenceId,
//       this.videoEncoderReference,
//       this.title,
//       this.description,
//       this.userId,
//       this.userName,
//       this.userProfileImage,
//       this.categoryId,
//       this.categoryName,
//       this.numberOfLikes,
//       this.numberOfDislikes,
//       this.numberOfShares,
//       this.numberOfViews,
//       this.numberOfFollowers,
//       this.videoQualityId,
//       this.videoStreamingUrl,
//       this.createdOn,
//       this.createdById,
//       this.updatedOn,
//       this.updatedById,
//       this.isActive,
//       this.videoType,
//       this.videoThumbnailId,
//       this.videoHashTagId,
//       this.videoDurationInSeconds,
//       this.videoThumbnailImagePath,
//       this.videoUploadStatus,
//       this.isLiked,
//       this.isDisliked,
//       this.hashTags});

//   TrendingVideo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     videoReferenceId = json['videoReferenceId'] ?? "";
//     videoEncoderReference = json['videoEncoderReference'];
//     title = json['title'];
//     description = json['description'];
//     userId = json['userId'];
//     userName = json['userName'];
//     userProfileImage = json['userProfileImage'];
//     categoryId = json['categoryId'];
//     categoryName = json['categoryName'];
//     numberOfLikes = json['numberOfLikes'];
//     numberOfDislikes = json['numberOfDislikes'];
//     numberOfShares = json['numberOfShares'];
//     numberOfViews = json['numberOfViews'];
//     numberOfFollowers = json['numberOfFollowers'];
//     videoQualityId = json['videoQualityId'] ?? "";
//     videoStreamingUrl = json['videoStreamingUrl'] ?? "";
//     createdOn = json['createdOn'];
//     createdById = json['createdById'] ?? "";
//     updatedOn = json['updatedOn'];
//     updatedById = json['updatedById'];
//     isActive = json['isActive'];
//     videoType = json['videoType'];
//     videoThumbnailId = json['videoThumbnailId'] ?? "";
//     videoHashTagId = json['videoHashTagId'] ?? "";
//     videoDurationInSeconds = json['videoDurationInSeconds'] == 0
//         ? 0.00
//         : json['videoDurationInSeconds'];
//     videoThumbnailImagePath = json['videoThumbnailImagePath'];
//     videoUploadStatus = json['videoUploadStatus'];
//     isLiked = json['isLiked'];
//     isDisliked = json['isDisliked'];
//     hashTags = json['hashTags'] ?? "";
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['videoReferenceId'] = videoReferenceId;
//     data['videoEncoderReference'] = videoEncoderReference;
//     data['title'] = title;
//     data['description'] = description;
//     data['userId'] = userId;
//     data['userName'] = userName;
//     data['userProfileImage'] = userProfileImage;
//     data['categoryId'] = categoryId;
//     data['categoryName'] = categoryName;
//     data['numberOfLikes'] = numberOfLikes;
//     data['numberOfDislikes'] = numberOfDislikes;
//     data['numberOfShares'] = numberOfShares;
//     data['numberOfViews'] = numberOfViews;
//     data['numberOfFollowers'] = numberOfFollowers;
//     data['videoQualityId'] = videoQualityId;
//     data['videoStreamingUrl'] = videoStreamingUrl;
//     data['createdOn'] = createdOn;
//     data['createdById'] = createdById;
//     data['updatedOn'] = updatedOn;
//     data['updatedById'] = updatedById;
//     data['isActive'] = isActive;
//     data['videoType'] = videoType;
//     data['videoThumbnailId'] = videoThumbnailId;
//     data['videoHashTagId'] = videoHashTagId;
//     data['videoDurationInSeconds'] = videoDurationInSeconds;
//     data['videoThumbnailImagePath'] = videoThumbnailImagePath;
//     data['videoUploadStatus'] = videoUploadStatus;
//     data['isLiked'] = isLiked;
//     data['isDisliked'] = isDisliked;
//     data['hashTags'] = hashTags;
//     return data;
//   }
// }

// class VideoOfTheDay {
//   String? id;
//   String? videoReferenceId;
//   String? videoEncoderReference;
//   String? title;
//   String? description;
//   String? userId;
//   String? userName;
//   String? userProfileImage;
//   String? categoryId;
//   String? categoryName;
//   int? numberOfLikes;
//   int? numberOfDislikes;
//   int? numberOfShares;
//   int? numberOfViews;
//   String? videoQualityId;
//   String? videoStreamingUrl;
//   int? numberOfComments;
//   int? numberOfPlaylists;
//   int? numberOfFollowers;
//   String? createdOn;
//   String? createdById;
//   String? updatedOn;
//   String? updatedById;
//   bool? isActive;
//   String? videoStreamingUrls;
//   String? videoThumbnailImagePath;
//   String? visibleStatusName;
//   String? visibleStatusId;
//   String? videoUploadStatus;
//   String? thumbnailId;
//   double? videoDurationInSeconds;
//   String? videoDuration;
//   bool? isLiked;
//   bool? isDisliked;
//   bool? isSaved;
//   bool? isDonateEnabled;
//   String? hashTags;

//   VideoOfTheDay(
//       {this.id,
//       this.videoReferenceId,
//       this.videoEncoderReference,
//       this.title,
//       this.description,
//       this.userId,
//       this.userName,
//       this.userProfileImage,
//       this.categoryId,
//       this.categoryName,
//       this.numberOfLikes,
//       this.numberOfDislikes,
//       this.numberOfShares,
//       this.numberOfViews,
//       this.videoQualityId,
//       this.videoStreamingUrl,
//       this.numberOfComments,
//       this.numberOfPlaylists,
//       this.numberOfFollowers,
//       this.createdOn,
//       this.createdById,
//       this.updatedOn,
//       this.updatedById,
//       this.isActive,
//       this.videoStreamingUrls,
//       this.videoThumbnailImagePath,
//       this.visibleStatusName,
//       this.visibleStatusId,
//       this.videoUploadStatus,
//       this.thumbnailId,
//       this.videoDurationInSeconds,
//       this.videoDuration,
//       this.isLiked,
//       this.isDisliked,
//       this.isSaved,
//       this.isDonateEnabled,
//       this.hashTags});

//   VideoOfTheDay.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     videoReferenceId = json['videoReferenceId'];
//     videoEncoderReference = json['videoEncoderReference'];
//     title = json['title'];
//     description = json['description'];
//     userId = json['userId'];
//     userName = json['userName'];
//     userProfileImage = json['userProfileImage'];
//     categoryId = json['categoryId'];
//     categoryName = json['categoryName'];
//     numberOfLikes = json['numberOfLikes'];
//     numberOfDislikes = json['numberOfDislikes'];
//     numberOfShares = json['numberOfShares'];
//     numberOfViews = json['numberOfViews'];
//     videoQualityId = json['videoQualityId'];
//     videoStreamingUrl = json['videoStreamingUrl'];
//     numberOfComments = json['numberOfComments'];
//     numberOfPlaylists = json['numberOfPlaylists'];
//     numberOfFollowers = json['numberOfFollowers'];
//     createdOn = json['createdOn'];
//     createdById = json['createdById'];
//     updatedOn = json['updatedOn'];
//     updatedById = json['updatedById'];
//     isActive = json['isActive'];
//     videoStreamingUrls = json['videoStreamingUrls'];
//     videoThumbnailImagePath = json['videoThumbnailImagePath'];
//     visibleStatusName = json['visibleStatusName'];
//     visibleStatusId = json['visibleStatusId'];
//     videoUploadStatus = json['videoUploadStatus'];
//     thumbnailId = json['thumbnailId'];
//     videoDurationInSeconds = videoDurationInSeconds =
//         json['videoDurationInSeconds'] == 0
//             ? 0.00
//             : json['videoDurationInSeconds'];

//     videoDuration = json['videoDuration'];
//     isLiked = json['isLiked'];
//     isDisliked = json['isDisliked'];
//     isSaved = json['isSaved'];
//     isDonateEnabled = json['isDonateEnabled'];
//     hashTags = json['hashTags'] ?? "";
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['videoReferenceId'] = videoReferenceId;
//     data['videoEncoderReference'] = videoEncoderReference;
//     data['title'] = title;
//     data['description'] = description;
//     data['userId'] = userId;
//     data['userName'] = userName;
//     data['userProfileImage'] = userProfileImage;
//     data['categoryId'] = categoryId;
//     data['categoryName'] = categoryName;
//     data['numberOfLikes'] = numberOfLikes;
//     data['numberOfDislikes'] = numberOfDislikes;
//     data['numberOfShares'] = numberOfShares;
//     data['numberOfViews'] = numberOfViews;
//     data['videoQualityId'] = videoQualityId;
//     data['videoStreamingUrl'] = videoStreamingUrl;
//     data['numberOfComments'] = numberOfComments;
//     data['numberOfPlaylists'] = numberOfPlaylists;
//     data['numberOfFollowers'] = numberOfFollowers;
//     data['createdOn'] = createdOn;
//     data['createdById'] = createdById;
//     data['updatedOn'] = updatedOn;
//     data['updatedById'] = updatedById;
//     data['isActive'] = isActive;
//     data['videoStreamingUrls'] = videoStreamingUrls;
//     data['videoThumbnailImagePath'] = videoThumbnailImagePath;
//     data['visibleStatusName'] = visibleStatusName;
//     data['visibleStatusId'] = visibleStatusId;
//     data['videoUploadStatus'] = videoUploadStatus;
//     data['thumbnailId'] = thumbnailId;
//     data['videoDurationInSeconds'] = videoDurationInSeconds;
//     data['videoDuration'] = videoDuration;
//     data['isLiked'] = isLiked;
//     data['isDisliked'] = isDisliked;
//     data['isSaved'] = isSaved;
//     data['isDonateEnabled'] = isDonateEnabled;
//     data['hashTags'] = hashTags;
//     return data;
//   }
// }

// class Categories {
//   String? categoryId;
//   String? categoryName;
//   List<VideoList>? videoList;

//   Categories({this.categoryId, this.categoryName, this.videoList});

//   Categories.fromJson(Map<String, dynamic> json) {
//     categoryId = json['categoryId'];
//     categoryName = json['categoryName'];
//     if (json['videoList'] != null) {
//       videoList = <VideoList>[];
//       json['videoList'].forEach((v) {
//         videoList!.add(VideoList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['categoryId'] = categoryId;
//     data['categoryName'] = categoryName;
//     if (videoList != null) {
//       data['videoList'] = videoList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VideoList {
//   String? videoId;
//   String? videoReferenceId;
//   String? videoEncoderReference;
//   String? title;
//   String? description;
//   String? userId;
//   String? userName;
//   int? numberOfLikes;
//   int? numberOfDislikes;
//   int? numberOfShares;
//   int? numberOfViews;
//   String? videoQualityId;
//   String? videoStreamingUrl;
//   String? createdOn;
//   String? createdById;
//   String? updatedOn;
//   String? updatedById;
//   bool? isActive;
//   String? videoType;
//   String? videoThumbnailId;
//   String? videoHashTagId;
//   double? videoDurationInSeconds;
//   String? videoThumbnailImagePath;

//   VideoList(
//       {this.videoId,
//       this.videoReferenceId,
//       this.videoEncoderReference,
//       this.title,
//       this.description,
//       this.userId,
//       this.userName,
//       this.numberOfLikes,
//       this.numberOfDislikes,
//       this.numberOfShares,
//       this.numberOfViews,
//       this.videoQualityId,
//       this.videoStreamingUrl,
//       this.createdOn,
//       this.createdById,
//       this.updatedOn,
//       this.updatedById,
//       this.isActive,
//       this.videoType,
//       this.videoThumbnailId,
//       this.videoHashTagId,
//       this.videoDurationInSeconds,
//       this.videoThumbnailImagePath});

//   VideoList.fromJson(Map<String, dynamic> json) {
//     videoId = json['videoId'];
//     videoReferenceId = json['videoReferenceId'];
//     videoEncoderReference = json['videoEncoderReference'];
//     title = json['title'];
//     description = json['description'];
//     userId = json['userId'];
//     userName = json['userName'];
//     numberOfLikes = json['numberOfLikes'];
//     numberOfDislikes = json['numberOfDislikes'];
//     numberOfShares = json['numberOfShares'];
//     numberOfViews = json['numberOfViews'];
//     videoQualityId = json['videoQualityId'];
//     videoStreamingUrl = json['videoStreamingUrl'] ?? "";
//     createdOn = json['createdOn'];
//     createdById = json['createdById'];
//     updatedOn = json['updatedOn'];
//     updatedById = json['updatedById'];
//     isActive = json['isActive'];
//     videoType = json['videoType'] ?? "";
//     videoThumbnailId = json['videoThumbnailId'];
//     videoHashTagId = json['videoHashTagId'];
//     videoDurationInSeconds = videoDurationInSeconds =
//         json['videoDurationInSeconds'] == 0
//             ? 0.00
//             : json['videoDurationInSeconds'];
//     videoThumbnailImagePath = json['videoThumbnailImagePath'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['videoId'] = videoId;
//     data['videoReferenceId'] = videoReferenceId;
//     data['videoEncoderReference'] = videoEncoderReference;
//     data['title'] = title;
//     data['description'] = description;
//     data['userId'] = userId;
//     data['userName'] = userName;
//     data['numberOfLikes'] = numberOfLikes;
//     data['numberOfDislikes'] = numberOfDislikes;
//     data['numberOfShares'] = numberOfShares;
//     data['numberOfViews'] = numberOfViews;
//     data['videoQualityId'] = videoQualityId;
//     data['videoStreamingUrl'] = videoStreamingUrl;
//     data['createdOn'] = createdOn;
//     data['createdById'] = createdById;
//     data['updatedOn'] = updatedOn;
//     data['updatedById'] = updatedById;
//     data['isActive'] = isActive;
//     data['videoType'] = videoType;
//     data['videoThumbnailId'] = videoThumbnailId;
//     data['videoHashTagId'] = videoHashTagId;
//     data['videoDurationInSeconds'] = videoDurationInSeconds;
//     data['videoThumbnailImagePath'] = videoThumbnailImagePath;
//     return data;
//   }
// }
