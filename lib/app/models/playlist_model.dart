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
  String? title;
  String? userId;
  String? categoryId;
  int? numberOfViews;
  double? videoDurationInSeconds;
  String? videoThumbnailImagePath;

  Videos({
    this.id,
    this.title,
    this.userId,
    this.categoryId,
    this.videoDurationInSeconds,
    this.videoThumbnailImagePath,
  });

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    numberOfViews = json['numberOfViews'];
    videoDurationInSeconds = json['videoDurationInSeconds'] == 0
        ? 0.00
        : json['videoDurationInSeconds'];
    videoThumbnailImagePath = json['videoThumbnailImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['userId'] = userId;
    data['categoryId'] = categoryId;
    data['numberOfViews'] = numberOfViews;
    data['videoDurationInSeconds'] = videoDurationInSeconds;
    data['videoThumbnailImagePath'] = videoThumbnailImagePath;

    return data;
  }
}
