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
  List<Categories>? categories;

  GetAllVideoLandingData(
      {this.disocverVideo,
      this.trendingVideo,
      this.followingVideo,
      this.categories});

  GetAllVideoLandingData.fromJson(Map<String, dynamic> json) {
    if (json['disocverVideo'] != null) {
      disocverVideo = <DisocverVideo>[];
      json['disocverVideo'].forEach((v) {
        disocverVideo!.add(DisocverVideo.fromJson(v));
      });
    }
    if (json['trendingVideo'] != null) {
      trendingVideo = [];
      json['trendingVideo'].forEach((v) {
        trendingVideo!.add(v);
      });
    }
    if (json['followingVideo'] != null) {
      followingVideo = [];
      json['followingVideo'].forEach((v) {
        followingVideo!.add(v);
      });
    }

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

    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisocverVideo {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? userProfileImage;
  String? categoryId;
  String? categoryName;
  int? numberOfViews;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoType;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;

  DisocverVideo({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.userProfileImage,
    this.categoryId,
    this.categoryName,
    this.numberOfViews,
    this.createdOn,
    this.createdById,
    this.updatedOn,
    this.updatedById,
    this.isActive,
    this.videoType,
    this.videoDurationInSeconds,
    this.videoThumbnailImagePath,
  });

  DisocverVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userProfileImage = json['userProfileImage'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfViews = json['numberOfViews'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoType = json['videoType'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userProfileImage'] = userProfileImage;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfViews'] = numberOfViews;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoType'] = videoType;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
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
  String? title;
  String? description;
  String? categoryId;
  int? numberOfViews;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  bool? isActive;
  String? videoType;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;

  VideoList(
      {this.videoId,
      this.title,
      this.description,
      this.categoryId,
      this.numberOfViews,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.isActive,
      this.videoType,
      this.videoDurationInSeconds,
      this.videoThumbnailImagePath});

  VideoList.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    description = json['description'];
    categoryId = json['categoryId'];
    numberOfViews = json['numberOfViews'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    isActive = json['isActive'];
    videoType = json['videoType'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['title'] = title;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['numberOfViews'] = numberOfViews;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['isActive'] = isActive;
    data['videoType'] = videoType;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    return data;
  }
}
