import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class VideoService {
  Future<GetAllVideoModel> getAllVideo(VideoRequestModel getRequest) async {
    var token = box.read('authToken');
    try {
      final response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetVideos'),
          body: json.encode({
            "videoId": getRequest.videoId,
            "userId": getRequest.userId,
            "userName": getRequest.userName,
            "videoType": getRequest.videoType,
            "currentUserId": getRequest.currentUserId,
            "categoryId": getRequest.categoryId,
            "thumbnailId": getRequest.thumbnailId,
            "categoryName": getRequest.categoryName,
            "playlistId": getRequest.playlistId,
            "videoReferenceId": getRequest.videoReferenceId,
            "videoEncoderReference": getRequest.videoEncoderReference,
            "visibleStatus": getRequest.visibleStatus,
            "videoUploadStatus": getRequest.videoUploadStatus,
            "requestType": getRequest.requestType,
            "hashTag": getRequest.hashTag,
            "pageSize": getRequest.pageSize,
            "pageNumber": getRequest.pageNumber,
            "searchText": getRequest.searchText,
            "sortBy": getRequest.sortBy
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllVideoModel.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while fetch video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to fetch video", e.toString());
      throw e.toString();
    }
  }

  Future<GetVideoByIdModel> getByIdVideo(String id) async {
    var token = box.read('authToken');
    try {
      final response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetDetails'),
          body: json.encode({
            "videoId": id,
            "userId": null,
            "userName": "",
            "videoType": "",
            "currentUserId": null,
            "categoryId": null,
            "thumbnailId": null,
            "categoryName": "",
            "playlistId": null,
            "videoReferenceId": "",
            "videoEncoderReference": "",
            "visibleStatus": "",
            "videoUploadStatus": "",
            "requestType": "",
            "hashTag": "",
            "pageSize": 0,
            "pageNumber": 0,
            "searchText": "",
            "sortBy": ""
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetVideoByIdModel.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while fetch video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to fetch video", e.toString());
      throw e.toString();
    }
  }

  Future<GetVideoByIdModel> videoLike(String id) async {
    var token = box.read('authToken');
    try {
      final response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetDetails'),
          body: json.encode({
            "videoId": id,
            "userId": null,
            "userName": "",
            "videoType": "",
            "currentUserId": null,
            "categoryId": null,
            "thumbnailId": null,
            "categoryName": "",
            "playlistId": null,
            "videoReferenceId": "",
            "videoEncoderReference": "",
            "visibleStatus": "",
            "videoUploadStatus": "",
            "requestType": "",
            "hashTag": "",
            "pageSize": 0,
            "pageNumber": 0,
            "searchText": "",
            "sortBy": ""
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetVideoByIdModel.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while fetch video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to fetch video", e.toString());
      throw e.toString();
    }
  }
}
