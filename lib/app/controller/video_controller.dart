import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/video_model.dart';
import '../services/video_service.dart';
import '../../config/constant/constant.dart';
import '../controller/network_controller.dart';
import '../controller/comments_controller.dart';
import '../controller/video_detail_controller.dart';

class DiscoverVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "discover";
    getRequest.categoryId = null;
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class TrendingVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "trending";
    getRequest.categoryId = null;
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class SearchVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;
  var searchQuery = ''.obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = null;
    getRequest.pageNumber = 1;
    getRequest.pageSize = 10;
    getRequest.searchText = searchQuery.toString();
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

class UserTopTrendingVideoController extends GetxController {
  var isLoading = true.obs;
  VideoService videoService = VideoService();
  var videoList = <GetAllVideoModel>[].obs;
  RxString selectedVideoId = "".obs;

  @override
  void onInit() {
    getUser();
    fetchVideo();
    super.onInit();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (data != null) {
      selectedVideoId(getUserData['id'] ?? "");
    }
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = selectedVideoId.toString();
    getRequest.videoType = "trending";
    getRequest.categoryId = null;
    getRequest.pageNumber = 1;
    getRequest.pageSize = 10;
    getRequest.searchText = "";
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
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 20.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final RxString selectedUserId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    getUser();
    if (networkController.isConnected.value) {
      if (selectedUserId.value != "") {
        fetchVideo();
      }
    }

    super.onInit();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);

    if (getUserData != null) {
      selectedUserId.value = getUserData['id'] ?? "";
    }
    if (networkController.isConnected.value) {
      fetchVideo();
    }
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = selectedUserId.toString();
    getRequest.videoType = "";
    getRequest.categoryId = null;
    getRequest.pageNumber = 1;
    getRequest.pageSize = 100;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideo(createRequest());
      videoList.assign(stories);
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
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    var data = box.read('user');
    if (data != null) {
      var getUserData = jsonDecode(data);
      currentUserId(getUserData['id'] ?? "");
    }
    if (networkController.isConnected.value) {
      fetchVideoOfTheDay();
    }
    super.onInit();
  }

  createRequest() {
    VideoOfTheDayRequestModel getRequest = VideoOfTheDayRequestModel();
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
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = "9dd8f2d7-1939-4309-a244-77001b8eeb36";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class EducationVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());
  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = "e4a906a6-67c8-4ef4-bce3-975543ead8d3";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class TalentVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = "2c55d6db-89b1-4c66-bbbb-2fac7777fa8d";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class UpNextVideoController extends GetxController {
  final CommentsController commentsController = Get.put(CommentsController());
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var dataList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final NetworkController networkController = Get.put(NetworkController());

  final RxString selectedcategoryId = "".obs;
  final RxString checkVideoId = "".obs;
  final currentIndex = 0.obs;
  RxInt listIndex = 0.obs;
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      if (selectedcategoryId.value != "") {
        fetchVideo();
      }
    }

    super.onInit();
  }

  void updateString(String newValue) {
    selectedcategoryId.value = newValue;
    fetchVideo();
  }

  void updateCheckVideoId(String newValue) {
    checkVideoId.value = newValue;
    fetcheSkipVideo("");
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = selectedcategoryId.toString();
    getRequest.pageNumber = 1;
    getRequest.pageSize = 100;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      isLoading(true);
      var stories = await videoService.getAllVideo(createRequest());
      videoList.assign(stories);
    } finally {
      isLoading(false);
    }
  }

  fetcheSkipVideo(String vId) async {
    if (vId != "") {
      var currentVideoIndex =
          videoList[0].data?.indexWhere((video) => video.id == vId);
      if (currentVideoIndex! < videoList[0].data!.length - 1) {
        currentVideoIndex++;
      }
      var videoData = videoList[0].data![currentVideoIndex];
      videoDetailController.videoId(videoData.id.toString());
      commentsController.updateString(videoData.id.toString());
      selectedcategoryId.value = videoData.categoryId.toString();
      fetchVideo();
      commentsController.fetchComment();
    }
    return "done";
  }

  // fetcheAutoSkipVideo(String vId) async {
  //   if (vId != "") {
  //     var currentVideoIndex =
  //         videoList[0].data?.indexWhere((video) => video.id == vId);
  //     if (currentVideoIndex! < videoList[0].data!.length - 1) {
  //       currentVideoIndex++;
  //     }
  //     var videoData = videoList[0].data![currentVideoIndex];
  //     videoDetailController.videoId(videoData.id.toString());
  //     commentsController.updateString(videoData.id.toString());
  //     selectedcategoryId.value = videoData.categoryId.toString();
  //     fetchVideo();
  //     commentsController.fetchComment();
  //     return [
  //       videoData.videoThumbnailImagePath.toString(),
  //       videoData.title.toString(),
  //       videoData.description.toString()
  //     ];
  //   }
  // }

  fetchePreviousVideo(String vId) async {
    if (vId != "") {
      var currentVideoIndex =
          videoList[0].data?.indexWhere((video) => video.id == vId);
      if (currentVideoIndex! < videoList[0].data!.length - 1) {
        currentVideoIndex--;
      }
      var videoData = videoList[0].data![currentVideoIndex];
      videoDetailController.videoId(videoData.id.toString());
      commentsController.updateString(videoData.id.toString());
      selectedcategoryId.value = videoData.categoryId.toString();
      fetchVideo();
      commentsController.fetchComment();
    }

    return "done";
  }
}

class PremiumShowVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());
  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (networkController.isConnected.value) {
      fetchVideo();
    }
    super.onInit();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = null;
    getRequest.videoType = "";
    getRequest.categoryId = "6b022ebc-4354-45b1-9baf-5b1a6924babe";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    return getRequest;
  }

  void fetchVideo() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await videoService.getAllVideo(createRequest());
      if (stories.data != null) {
        videoList.assign(stories);
        if (loadedItems == 0) {
          videoList.assign(stories);
        } else {
          videoList.add(stories);
        }
      }
    } finally {
      isLoading(false);
      isAddingMore(false);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      // limit += 10;
      loadedItems += limit.toInt();
      if (networkController.isConnected.value) {
        fetchVideo();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
