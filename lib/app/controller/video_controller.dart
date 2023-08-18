import 'package:get/get.dart';

import '../models/video_model.dart';
import '../services/video_service.dart';

class DiscoverVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;

  @override
  void onInit() {
    fetchVideo();
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = null;
    getRequest.userName = "";
    getRequest.videoType = "discover";
    getRequest.currentUserId = null;
    getRequest.categoryId = null;
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = 1;
    getRequest.pageSize = 10;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
      }
    } finally {
      isLoading(false);
    }
  }
}

class TrendingVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;
  RxString selectedVideoId = "".obs;

  @override
  void onInit() {
    fetchVideo();
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = null;
    getRequest.userName = "";
    getRequest.videoType = "trending";
    getRequest.currentUserId = null;
    getRequest.categoryId = null;
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = 1;
    getRequest.pageSize = 10;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetByIdVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;
  RxString selectedVideoId = "".obs;

  @override
  void onInit() {
    fetchVideo();
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = null;
    getRequest.userName = "";
    getRequest.videoType = "trending";
    getRequest.currentUserId = null;
    getRequest.categoryId = null;
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = 1;
    getRequest.pageSize = 10;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
      }
    } finally {
      isLoading(false);
    }
  }
}
