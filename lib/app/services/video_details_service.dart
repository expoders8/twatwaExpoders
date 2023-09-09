import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/video_model.dart';
import '../ui/auth/login/login.dart';

class VideoDetailsService {
  Future<GetVideoByIdModel> fetchStoryDetail(String videoId, userId) async {
    var token = box.read('authToken');
    try {
      var response =
          await http.post(Uri.parse('$baseUrl/videoapi/api/Video/GetDetails'),
              body: json.encode({
                "videoId": videoId.toString(),
                "userId": token == null ? null : userId,
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
            "Authorization": "Bearer $token",
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        // detailModel = GetVideoByIdModel.fromJson(model);
        return GetVideoByIdModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
      } else {
        return Future.error("Server Error");
      }
    } catch (error) {
      return Future.error(error);
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
