import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/playlist_model.dart';
import '../models/video_model.dart';
import '../services/playlist_service.dart';
import '../services/video_service.dart';

class OtherUserVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final scrollController = ScrollController();
  final RxString selectedOtherUserId = "".obs;
  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (selectedOtherUserId.value != "") {
      fetchVideo();
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedOtherUserId.value = newValue;
    fetchVideo();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = selectedOtherUserId.toString();
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

class OtherUserPlaylistController extends GetxController {
  var isLoading = true.obs;
  var playList = <PlaylistModel>[].obs;
  PlaylistService playlistService = PlaylistService();
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  final scrollController = ScrollController();
  final RxString selectedUserId = "".obs;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (selectedUserId.value != "") {
      fetchAllPlaylist();
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedUserId.value = newValue;
    fetchAllPlaylist();
  }

  createRequest() {
    PlaylistRequestModel getRequest = PlaylistRequestModel();
    getRequest.videoId = null;
    getRequest.userId = selectedUserId.toString();
    getRequest.userName = "";
    getRequest.playlistId = null;
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchAllPlaylist() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await playlistService.getMyPlayLists(createRequest());
      if (stories.data != null) {
        playList.assign(stories);
        if (loadedItems == 0) {
          playList.assign(stories);
        } else {
          playList.add(stories);
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
      fetchAllPlaylist();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
