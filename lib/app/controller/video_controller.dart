import 'dart:convert';

import 'package:get/get.dart';

import '../../config/constant/constant.dart';
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

class MyVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;

  void fetchMyVideo(String userId, checkText) async {
    try {
      isLoading(true);
      var stories = await videoService.getAllMyVideo(userId, checkText);
      if (stories.data != null) {
        videoList.assign(stories);
      }
    } finally {
      isLoading(false);
    }
  }
}

class VideoOfTheDayController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetVideoOfTheDayData>[].obs;
  RxString currentUserId = "".obs;

  @override
  void onInit() {
    var data = box.read('user');
    if (data != null) {
      var getUserData = jsonDecode(data);
      currentUserId(getUserData['id'] ?? "");
    }
    fetchVideoOfTheDay();
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId =
        currentUserId.toString() == "" ? null : currentUserId.toString();
    getRequest.userName = "";
    getRequest.videoType = "";
    getRequest.currentUserId =
        currentUserId.toString() == "" ? null : currentUserId.toString();
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

  void fetchVideoOfTheDay() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideoOfTheDaY(createRequest());
      videoList.assign(stories);
    } finally {
      isLoading(false);
    }
  }
}

class JobsVideoController extends GetxController {
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
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = "9dd8f2d7-1939-4309-a244-77001b8eeb36";
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

class TalentVideoController extends GetxController {
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
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = "2c55d6db-89b1-4c66-bbbb-2fac7777fa8d";
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

class PremiumShowVideoController extends GetxController {
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
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = "6b022ebc-4354-45b1-9baf-5b1a6924babe";
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
