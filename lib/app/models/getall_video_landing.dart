class GetAllVideoLanding {
  bool? success;
  String? message;
  GetAllDataVideoLanding? data;
  int? code;

  GetAllVideoLanding({this.success, this.message, this.data, this.code});

  GetAllVideoLanding.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetAllDataVideoLanding.fromJson(json['data'])
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

class GetAllDataVideoLanding {
  List<DisocverVideo>? disocverVideo;
  List<TrendingVideo>? trendingVideo;
  List? followingVideo;
  String? categoriesVideo;
  VideoOfTheDay? videoOfTheDay;
  List<Categories>? categories;

  GetAllDataVideoLanding(
      {this.disocverVideo,
      this.trendingVideo,
      this.followingVideo,
      this.categoriesVideo,
      this.videoOfTheDay,
      this.categories});

  GetAllDataVideoLanding.fromJson(Map<String, dynamic> json) {
    if (json['disocverVideo'] != null) {
      disocverVideo = <DisocverVideo>[];
      json['disocverVideo'].forEach((v) {
        disocverVideo!.add(DisocverVideo.fromJson(v));
      });
    }
    if (json['trendingVideo'] != null) {
      trendingVideo = <TrendingVideo>[];
      json['trendingVideo'].forEach((v) {
        trendingVideo!.add(TrendingVideo.fromJson(v));
      });
    }
    if (json['followingVideo'] != null) {
      followingVideo = <Null>[];
      json['followingVideo'].forEach((v) {
        followingVideo!.add((v));
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
  String? hashTags;

  DisocverVideo(
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

  DisocverVideo.fromJson(Map<String, dynamic> json) {
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
    data['hashTags'] = hashTags;
    return data;
  }
}

class TrendingVideo {
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
  String? hashTags;

  TrendingVideo(
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

  TrendingVideo.fromJson(Map<String, dynamic> json) {
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
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoStreamingUrls;
  String? sVideoThumbnailImagePath;
  String? videoThumbnailImagePath;
  String? nVideoThumbanailClipPath;
  String? videoThumbanailClipPath;
  String? visibleStatusName;
  String? visibleStatusId;
  String? videoUploadStatus;
  String? thumbnailId;
  int? videoDurationInSeconds;
  String? videoDuration;
  bool? isLiked;
  bool? isDisliked;
  bool? isSaved;
  bool? isDonateEnabled;
  Null? hashTags;

  VideoOfTheDay(
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
      this.numberOfComments,
      this.numberOfPlaylists,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive,
      this.videoStreamingUrls,
      this.sVideoThumbnailImagePath,
      this.videoThumbnailImagePath,
      this.nVideoThumbanailClipPath,
      this.videoThumbanailClipPath,
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
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoStreamingUrls = json['videoStreamingUrls'];
    sVideoThumbnailImagePath = json['_VideoThumbnailImagePath'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    nVideoThumbanailClipPath = json['_VideoThumbanailClipPath'];
    videoThumbanailClipPath = json['videoThumbanailClipPath'];
    visibleStatusName = json['visibleStatusName'];
    visibleStatusId = json['visibleStatusId'];
    videoUploadStatus = json['videoUploadStatus'];
    thumbnailId = json['thumbnailId'];
    videoDurationInSeconds = json['videoDurationInSeconds'];
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
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoStreamingUrls'] = videoStreamingUrls;
    data['_VideoThumbnailImagePath'] = sVideoThumbnailImagePath;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['_VideoThumbanailClipPath'] = nVideoThumbanailClipPath;
    data['videoThumbanailClipPath'] = videoThumbanailClipPath;
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
  int? videoDurationInSeconds;
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
    videoDurationInSeconds = json['videoDurationInSeconds'];
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
