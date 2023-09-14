class CommentRequestModel {
  String? videoId;
  String? commentId;
  String? parentCommentId;
  String? videoReferenceId;
  String? currentUserId;
  String? userId;
  int? pageSize;
  int? pageNumber;
  String? searchText;
  String? sortBy;
}

class GetAllComments {
  bool? success;
  String? message;
  List<GetAllCommentsData>? data;
  int? code;

  GetAllComments({this.success, this.message, this.data, this.code});

  GetAllComments.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllCommentsData>[];
      json['data'].forEach((v) {
        data!.add(GetAllCommentsData.fromJson(v));
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

class GetAllCommentsData {
  String? id;
  String? userId;
  String? videoId;
  String? comment;
  String? createdOn;
  String? createdById;
  String? updatedOn;
  String? updatedById;
  String? parentCommentId;
  int? totalCommentLikes;
  int? totalCommentDisLikes;
  int? totalCommentReplies;
  String? commentUserFirstName;
  String? commentUserLastName;
  String? commentUserName;
  String? commentUserProfilePhoto;
  late bool isLiked;
  bool? isDisliked;

  GetAllCommentsData(
      {this.id,
      this.userId,
      this.videoId,
      this.comment,
      this.createdOn,
      this.createdById,
      this.updatedOn,
      this.updatedById,
      this.parentCommentId,
      this.totalCommentLikes,
      this.totalCommentDisLikes,
      this.totalCommentReplies,
      this.commentUserFirstName,
      this.commentUserLastName,
      this.commentUserName,
      this.commentUserProfilePhoto,
      required this.isLiked,
      this.isDisliked});

  GetAllCommentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    videoId = json['videoId'];
    comment = json['comment'];
    createdOn = json['createdOn'];
    createdById = json['createdById'];
    updatedOn = json['updatedOn'];
    updatedById = json['updatedById'];
    parentCommentId = json['parentCommentId'];
    totalCommentLikes = json['totalCommentLikes'];
    totalCommentDisLikes = json['totalCommentDisLikes'];
    totalCommentReplies = json['totalCommentReplies'];
    commentUserFirstName = json['commentUserFirstName'];
    commentUserLastName = json['commentUserLastName'];
    commentUserName = json['commentUserName'];
    commentUserProfilePhoto = json['commentUserProfilePhoto'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['videoId'] = videoId;
    data['comment'] = comment;
    data['createdOn'] = createdOn;
    data['createdById'] = createdById;
    data['updatedOn'] = updatedOn;
    data['updatedById'] = updatedById;
    data['parentCommentId'] = parentCommentId;
    data['totalCommentLikes'] = totalCommentLikes;
    data['totalCommentDisLikes'] = totalCommentDisLikes;
    data['totalCommentReplies'] = totalCommentReplies;
    data['commentUserFirstName'] = commentUserFirstName;
    data['commentUserLastName'] = commentUserLastName;
    data['commentUserName'] = commentUserName;
    data['commentUserProfilePhoto'] = commentUserProfilePhoto;
    data['isLiked'] = isLiked;
    data['isDisliked'] = isDisliked;
    return data;
  }
}
