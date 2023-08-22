import 'dart:convert';
import 'dart:io';
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

  Future uploadVideo(String userId, String title, String description,
      videoHashTagId, File? photo, File? video) async {
    // try {
    //   var token = box.read('authToken');
    //   http.Response response;
    //   var request = http.MultipartRequest(
    //       "POST", Uri.parse("$baseUrl/api/Video/UploadVideo"))
    //     ..fields['Title'] = title
    //     ..fields['Description'] = description
    //     ..fields['UserId'] = userId
    //     ..fields['VideoHashTagId'] = videoHashTagId;
    //   if (photo != null) {
    //     request.files
    //         .add(await http.MultipartFile.fromPath('ImageFile', photo.path));
    //   }
    //   if (video != null) {
    //     request.files
    //         .add(await http.MultipartFile.fromPath('VideoFile', video.path));
    //   }
    //   request.headers.addAll({"Authorization": "Bearer $token"});
    //   response = await http.Response.fromStream(await request.send());

    //   if (response.statusCode == 200) {
    //     final responseData = json.decode(response.body);
    //     if (responseData["success"] == true) {
    //       var userObj = responseData["data"];
    //       if (userObj != null) {
    //         box.write('user', jsonEncode(responseData["data"]));
    //       }
    //     }
    //     return responseData;
    //   } else {
    //     LoaderX.hide();
    //     SnackbarUtils.showErrorSnackbar("Server Error",
    //         "Error while update profile, Please try after some time.");
    //     return Future.error("Server Error");
    //   }
    // } catch (error) {
    //   LoaderX.hide();
    //   SnackbarUtils.showErrorSnackbar("Failed to update", error.toString());
    //   return Future.error(error);
    // }
  }
}
