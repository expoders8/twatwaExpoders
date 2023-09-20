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
  var selectedVideoId = "".obs;
  var selectedUserId = "".obs;

  @override
  void onInit() {
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
    getRequest.pageNumber = 1;
    getRequest.pageSize = 100;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchComment() async {
    try {
      isLoading(true);
      var stories = await commnetsService.getAllComments(createRequest());
      commentList.assign(stories);
    } finally {
      isLoading(false);
    }
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
