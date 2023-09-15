import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constant/constant.dart';
import '../models/video_model.dart';
import '../services/video_service.dart';

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

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
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

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
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
    getRequest.searchText = searchQuery.toString();
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
    getRequest.videoId = null;
    getRequest.userId = selectedVideoId.toString();
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
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  final RxString selectedUserId = "".obs;

  @override
  void onInit() {
    getUser();
    scrollController.addListener(_scrollListener);
    if (selectedUserId.value != "") {
      fetchVideo();
    }
    super.onInit();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);

    if (getUserData != null) {
      selectedUserId.value = getUserData['id'] ?? "";
    }
    fetchVideo();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = selectedUserId.toString();
    getRequest.userName = "";
    getRequest.videoType = "";
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      loadedItems += limit.toInt();
      fetchVideo();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs; // Start with the first paged
  var limit = 10.obs; // Start with the first paged
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  RxString selectedVideoId = "".obs;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
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

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.categoryId = "e4a906a6-67c8-4ef4-bce3-975543ead8d3";
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
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

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class UpNextVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  final RxString selectedcategoryId = "".obs;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (selectedcategoryId.value != "") {
      fetchVideo();
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedcategoryId.value = newValue;
    fetchVideo();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = null;
    getRequest.userName = "";
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = selectedcategoryId.toString();
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
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
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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
      fetchVideo();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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
