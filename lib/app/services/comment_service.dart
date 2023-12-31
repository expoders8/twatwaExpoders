import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/comments_model.dart';

class CommnetsService {
  Future<GetAllComments> getAllComments(CommentRequestModel getRequest) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/api/Video/GetComments'),
              body: json.encode({
                "videoId": getRequest.videoId,
                "commentId": getRequest.commentId,
                "parentCommentId": getRequest.parentCommentId,
                "userId": getRequest.userId,
                "currentUserId": getRequest.currentUserId,
                "videoReferenceId": getRequest.videoReferenceId,
                "pageSize": getRequest.pageSize,
                "pageNumber": getRequest.pageNumber,
                "searchText": getRequest.searchText,
                "sortBy": getRequest.sortBy
              }),
              headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllComments.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Comments, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Comments", e.toString());
      throw e.toString();
    }
  }

  Future<GetAllComments> getAllReply(videoId, userId, parentCommentId) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/api/Video/GetComments'),
              body: json.encode({
                "videoId": videoId,
                "commentId": null,
                "parentCommentId": parentCommentId,
                "userId": userId,
                "currentUserId": null,
                "videoReferenceId": "",
                "pageSize": 50,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllComments.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Comments, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Comments", e.toString());
      throw e.toString();
    }
  }

  addComment(userId, videoId, comment, commentId, checkText) async {
    var token = box.read('authToken');
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/api/Video/AddComment'),
              body: json.encode({
                "id": null,
                "videoId": videoId,
                "userId": userId,
                "comment": comment,
                "parentCommentId": checkText == "reply" ? commentId : null,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Comments, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Comments", e.toString());
      throw e.toString();
    }
  }

  removeComment(commentId) async {
    var token = box.read('authToken');
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/api/Video/DeleteComment/$commentId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Comments, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Comments", e.toString());
      throw e.toString();
    }
  }

  likeComment(commentId) async {
    var token = box.read('authToken');
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/Video/LikeComment/$commentId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Comments, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Comments", e.toString());
      throw e.toString();
    }
  }
}
