import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class LikeStoryService {
  videoLike(videoId) async {
    var token = box.read('authToken');
    try {
      final response = await http
          .get(Uri.parse('$videobBaseUrl/api/Video/Like/$videoId'), headers: {
        'Content-type': 'application/json',
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
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
          Uri.parse('$videobBaseUrl/api/Video/Dislike/$videoId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
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
}
