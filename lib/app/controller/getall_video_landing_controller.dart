import 'package:get/get.dart';

import '../services/video_service.dart';
import '../models/getall_video_landing.dart';
import '../controller/network_controller.dart';

class GetAllVideoLandingController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoLanding>[].obs;
  VideoService videoService = VideoService();
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      fetchAllLandingVideos();
    }
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
