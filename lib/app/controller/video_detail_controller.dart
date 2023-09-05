import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../services/video_service.dart';
import '../../config/constant/constant.dart';

class VideoDetailController extends GetxController {
  var isLoading = true.obs;
  var storyId = "".obs;
  GetVideoByIdModel? detailModel;
  VideoService videoService = VideoService();
  RxString videoId = "".obs;

  @override
  void onInit() {
    fetchStoryDetail(videoId.toString(), "", null);
    super.onInit();
  }

  void fetchStoryDetail(String? videoIddata, String? check, userId) async {
    var token = box.read('authToken');
    try {
      isLoading(true);
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetDetails'),
          body: json.encode({
            "videoId": check == "upnext" ? videoIddata : videoId.toString(),
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
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var model = jsonDecode(response.body);
        detailModel = GetVideoByIdModel.fromJson(model);
      } else {
        return Future.error("Server Error");
      }
    } catch (error) {
      return Future.error(error);
    } finally {
      isLoading(false);
    }
  }
}
