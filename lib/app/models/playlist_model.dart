class PlaylistRequestModel {
  String? videoId;
  String? userId;
  String? userName;
  String? playlistId;
  int? pageSize;
  int? pageNumber;
  String? searchText;
  String? sortBy;
}

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
  String? title;
  String? description;
  String? userId;
  String? userName;
  String? userProfileImage;
  String? categoryId;
  String? categoryName;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfViews;
  int? numberOfFollowers;
  String? videoStreamingUrl;
  String? createdOn;
  String? qualityJson;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;
  bool? isLiked;
  bool? isDisliked;
  bool? hasFollowers;

  Videos({
    this.id,
    this.videoReferenceId,
    this.title,
    this.description,
    this.userId,
    this.userName,
    this.categoryId,
    this.categoryName,
    this.numberOfLikes,
    this.numberOfDislikes,
    this.numberOfViews,
    this.videoStreamingUrl,
    this.createdOn,
    this.qualityJson,
    this.videoDurationInSeconds,
    this.videoThumbnailImagePath,
    this.isLiked,
    this.isDisliked,
  });

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoReferenceId = json['videoReferenceId'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    userName = json['userName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    numberOfLikes = json['numberOfLikes'];
    numberOfDislikes = json['numberOfDislikes'];
    numberOfViews = json['numberOfViews'];
    videoStreamingUrl = json['videoStreamingUrl'];
    createdOn = json['createdOn'];
    qualityJson = json['qualityJson'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videoReferenceId'] = videoReferenceId;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['userName'] = userName;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['numberOfLikes'] = numberOfLikes;
    data['numberOfDislikes'] = numberOfDislikes;
    data['numberOfViews'] = numberOfViews;
    data['videoStreamingUrl'] = videoStreamingUrl;
    data['createdOn'] = createdOn;
    data['qualityJson'] = qualityJson;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;

    return data;
  }
}
