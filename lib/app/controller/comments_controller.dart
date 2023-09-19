import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constant/constant.dart';
import '../models/comments_model.dart';
import '../services/comment_service.dart';

class CommentsController extends GetxController {
  var isLoading = true.obs;
  CommnetsService commnetsService = CommnetsService();
  var commentList = <GetAllComments>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  final scrollController = ScrollController();
  var selectedVideoId = "".obs;
  var selectedUserId = "".obs;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    if (selectedVideoId.value != "") {
      fetchComment();
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedVideoId.value = newValue;
    getUser();
    fetchComment();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);

    if (getUserData != null) {
      selectedUserId.value = getUserData['id'] ?? "";
    }
  }

  createRequest() {
    CommentRequestModel getRequest = CommentRequestModel();
    getRequest.videoId = selectedVideoId.toString();
    getRequest.userId =
        selectedUserId.value == "" ? null : selectedUserId.toString();
    getRequest.videoReferenceId = "";
    getRequest.currentUserId = null;
    getRequest.pageNumber = page.toInt();
    getRequest.pageSize = loadedItems == 0 ? limit.toInt() : loadedItems;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchComment() async {
    try {
      if (loadedItems == 0) {
        isAddingMore(false);
        isLoading(true);
      } else {
        isAddingMore(true);
      }
      var stories = await commnetsService.getAllComments(createRequest());
      if (stories.data != null) {
        if (loadedItems == 0) {
          commentList.assign(stories);
        } else {
          commentList.add(stories);
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
      fetchComment();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class ReplayCommentsController extends GetxController {
  var isLoading = true.obs;
  CommnetsService commnetsService = CommnetsService();
  var commentList = <GetAllComments>[].obs;

  void fetchReply(String videoId, userId, commentId) async {
    try {
      isLoading(true);
      var stories =
          await commnetsService.getAllReply(videoId, userId, commentId);
      commentList.assign(stories);
    } finally {
      isLoading(false);
    }
  }
}
