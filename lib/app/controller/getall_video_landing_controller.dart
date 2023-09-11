import 'package:get/get.dart';

import '../services/video_service.dart';
import '../models/getall_video_landing.dart';

class GetAllVideoLandingController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoLanding>[].obs;
  VideoService videoService = VideoService();

  @override
  void onInit() {
    fetchAllLandingVideos();
    super.onInit();
  }

  void fetchAllLandingVideos() async {
    try {
      isLoading(true);
      var data = await videoService.getAllVideoLanding();
      videoList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
