import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../ui/auth/login/login.dart';
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
            "Error while fetch story, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to fetch story", e.toString());
      throw e.toString();
    }
  }

  // Future<GetStoryByIdModel> getstoryById(String id) async {
  //   var token = box.read('authToken');
  //   try {
  //     var response = await http.get(Uri.parse("$baseUrl/api/Story/GetById/$id"),
  //         headers: {"Authorization": "Bearer $token"});
  //     if (response.statusCode == 200) {
  //       var model = GetStoryByIdModel.fromJson(jsonDecode(response.body));
  //       return model;
  //     } else {
  //       return Future.error("Server Error");
  //     }
  //   } catch (error) {
  //     return Future.error(error);
  //   }
  // }

  authError() {
    LoaderX.hide();
    SnackbarUtils.showErrorSnackbar(
        "Authentication Error", "Please login again.");
    box.write('onBoard', 1);
    box.remove('user');

    Get.offAll(() => const LoginPage());
  }
}
