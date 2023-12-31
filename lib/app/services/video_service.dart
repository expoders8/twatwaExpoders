import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/network_controller.dart';
import '../models/video_model.dart';
import '../models/getall_video_landing.dart';
import '../../config/constant/constant.dart';
import '../controller/hastage_controller.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../ui/auth/login/login.dart';

class VideoService {
  final NetworkController networkController = Get.put(NetworkController());
  Future<GetAllVideoModel> getAllVideo(VideoRequestModel getRequest) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/api/Video/GetVideos'),
              body: json.encode({
                "userId": getRequest.userId,
                "videoType": getRequest.videoType,
                "categoryId": getRequest.categoryId,
                "pageSize": getRequest.pageSize,
                "pageNumber": getRequest.pageNumber,
                "searchText": getRequest.searchText,
              }),
              headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': 'c5c0f404c1b243cbb7335bd9c550d0f4'
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllVideoModel.fromJson(data);
      } else {
        LoaderX.hide();
        if (networkController.isConnected.value) {
          SnackbarUtils.showErrorSnackbar("Server Error",
              "Error while fetch video, Please try after some time.");
        }
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      if (networkController.isConnected.value) {
        SnackbarUtils.showErrorSnackbar("Failed to fetch video", e.toString());
      }
      throw e.toString();
    }
  }

  Future<GetVideoOfTheDayData> getAllVideoOfTheDaY(
      VideoOfTheDayRequestModel getRequest) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/api/Video/GetVideoOfTheDay'),
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
            // 'Ocp-Apim-Subscription-Key': 'c5c0f404c1b243cbb7335bd9c550d0f4'
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetVideoOfTheDayData.fromJson(data['data']);
      } else {
        LoaderX.hide();
        if (networkController.isConnected.value) {
          SnackbarUtils.showErrorSnackbar("Server Error",
              "Error while fetch video, Please try after some time.");
        }
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      // if (networkController.isConnected.value) {
      //   SnackbarUtils.showErrorSnackbar("Failed to fetch video", e.toString());
      // }
      throw e.toString();
    }
  }

  getMyAnalytics(String userId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/Video/GetMyAnalytics/$userId'),
          headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        if (networkController.isConnected.value) {
          SnackbarUtils.showErrorSnackbar("Server Error",
              "Error while Analytics, Please try after some time.");
        }
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      if (networkController.isConnected.value) {
        SnackbarUtils.showErrorSnackbar("Failed to Analytics", e.toString());
      }
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
          "POST", Uri.parse("$baseUrl/api/Video/UploadVideo"))
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
      request.headers.addAll({
        "Authorization": "Bearer $token",
        // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
      });
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
      if (networkController.isConnected.value) {
        SnackbarUtils.showErrorSnackbar("Failed to update", error.toString());
      }
      return Future.error(error);
    }
  }

  videoView(String videoId) async {
    var token = box.read('authToken');
    String? deviceId = await PlatformDeviceId.getDeviceId;
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/Video/View/$videoId/$deviceId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
      } else {
        LoaderX.hide();
        if (networkController.isConnected.value) {
          SnackbarUtils.showErrorSnackbar("Server Error",
              "Error while Video View, Please try after some time.");
        }
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      if (networkController.isConnected.value) {
        SnackbarUtils.showErrorSnackbar("Failed to Video View", e.toString());
      }
      throw e.toString();
    }
  }

  Future<GetAllVideoLanding> getAllVideoLanding() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/Video/GetVideoLanding'), headers: {
        'Content-type': 'application/json',
        // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return GetAllVideoLanding.fromJson(data);
      } else {
        LoaderX.hide();
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      throw e.toString();
    }
  }

  authError() {
    LoaderX.hide();
    SnackbarUtils.showErrorSnackbar(
        "Authentication Error", "Please login again.");
    box.write('onBoard', 1);
    box.remove('user');
    box.remove('authToken');

    Get.offAll(() => const LoginPage());
  }
}
