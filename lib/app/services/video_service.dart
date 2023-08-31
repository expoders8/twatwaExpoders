import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../models/getall_video_landing.dart';
import '../../config/constant/constant.dart';
import '../controller/hastage_controller.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class VideoService {
  Future<GetAllVideoModel> getAllVideo(VideoRequestModel getRequest) async {
    try {
      final response =
          await http.post(Uri.parse('$videobBaseUrl/api/Video/GetVideos'),
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

  Future<GetAllVideoModel> getAllMyVideo(userId, checkOtherUser) async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    try {
      final response =
          await http.post(Uri.parse('$videobBaseUrl/api/Video/GetVideos'),
              body: json.encode({
                "videoId": null,
                "userId":
                    checkOtherUser == "otherUser" ? userId : getUserData['id'],
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
                "pageSize": 25,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
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

  Future<GetAllVideoModel> getAllUpNextVideo(categoryId, userId) async {
    try {
      final response =
          await http.post(Uri.parse('$videobBaseUrl/api/Video/GetVideos'),
              body: json.encode({
                "videoId": null,
                "userId": userId,
                "userName": "",
                "videoType": "",
                "currentUserId": null,
                "categoryId": categoryId,
                "thumbnailId": null,
                "categoryName": "",
                "playlistId": null,
                "videoReferenceId": "",
                "videoEncoderReference": "",
                "visibleStatus": "",
                "videoUploadStatus": "",
                "requestType": "",
                "hashTag": "",
                "pageSize": 25,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllVideoModel.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while UpNext Video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to UpNext Video", e.toString());
      throw e.toString();
    }
  }

  Future<GetVideoOfTheDayData> getAllVideoOfTheDaY(
      VideoRequestModel getRequest) async {
    try {
      final response = await http
          .post(Uri.parse('$videobBaseUrl/api/Video/GetVideoOfTheDay'),
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
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetVideoOfTheDayData.fromJson(data['data']);
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
    try {
      final response =
          await http.post(Uri.parse('$videobBaseUrl/api/Video/GetDetails'),
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

  getMyAnalytics(String userId) async {
    try {
      final response = await http.get(
          Uri.parse('$videobBaseUrl/api/Video/GetMyAnalytics?userId=$userId'),
          headers: {
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Analytics, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Analytics", e.toString());
      throw e.toString();
    }
  }

  Future uploadVideo(String userId, String title, String description,
      File? photo, File? video, String categoryId) async {
    final GetAllHasTageController getAllHasTageController =
        Get.put(GetAllHasTageController());
    try {
      var token = box.read('authToken');
      http.Response response;
      var request = http.MultipartRequest(
          "POST", Uri.parse("$videobBaseUrl/api/Video/UploadVideo"))
        ..fields['Title'] = title
        ..fields['Description'] = description
        ..fields['UserId'] = userId
        ..fields['CategoryId'] = categoryId
        ..fields['VideoHashTag'] =
            getAllHasTageController.selectTagList.toList().toString();
      if (photo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('ImageFile', photo.path));
      }
      if (video != null) {
        request.files
            .add(await http.MultipartFile.fromPath('VideoFile', video.path));
      }
      request.headers.addAll({"Authorization": "Bearer $token"});
      response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        return responseData;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Upload Video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (error) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to update", error.toString());
      return Future.error(error);
    }
  }

  videoView(String videoId) async {
    var token = box.read('authToken');
    try {
      final response = await http
          .get(Uri.parse('$videobBaseUrl/api/Video/View/$videoId'), headers: {
        'Content-type': 'application/json',
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Video View, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Video View", e.toString());
      throw e.toString();
    }
  }

  Future<GetAllVideoLanding> getAllVideoLanding() async {
    try {
      final response = await http.get(
          Uri.parse('$videobBaseUrl/api/Video/GetVideoLanding'),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllVideoLanding.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Video View, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Video View", e.toString());
      throw e.toString();
    }
  }
}
