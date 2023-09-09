import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../ui/auth/login/login.dart';

class LikeStoryService {
  videoLike(videoId) async {
    var token = box.read('authToken');
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/videoapi/api/Video/Like/$videoId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while like video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to like video", e.toString());
      throw e.toString();
    }
  }

  videoDisLike(videoId) async {
    var token = box.read('authToken');
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/videoapi/api/Video/Dislike/$videoId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while like video, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to like video", e.toString());
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
