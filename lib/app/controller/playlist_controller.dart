import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constant/constant.dart';
import '../models/playlist_model.dart';
import '../services/playlist_service.dart';

class PlaylistController extends GetxController {
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
    getUser();
    scrollController.addListener(_scrollListener);
    var token = box.read('authToken') ?? "";
    if (token != "") {
      fetchAllPlaylist();
    }
    super.onInit();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);

    if (getUserData != null) {
      selectedUserId.value = getUserData['id'] ?? "";
    }
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
