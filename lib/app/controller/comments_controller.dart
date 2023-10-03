import 'package:get/get.dart';

import '../models/comments_model.dart';
import '../services/comment_service.dart';
import '../controller/network_controller.dart';

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
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      if (selectedVideoId.value != "") {
        fetchComment();
      }
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedVideoId.value = newValue;

    fetchComment();
  }

  createRequest() {
    CommentRequestModel getRequest = CommentRequestModel();
    getRequest.videoId = selectedVideoId.toString();
    getRequest.commentId = null;
    getRequest.parentCommentId = null;
    getRequest.userId = null;
    getRequest.currentUserId = null;
    getRequest.videoReferenceId = "";
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
  var selectedVideoId = "".obs;
  var selectedUserId = "".obs;
  var selectcommentId = "".obs;

  @override
  void onInit() {
    if (selectedVideoId.value != "") {
      fetchComment();
    }
    super.onInit();
  }

  void updateString(String newValue, String userId, String commentId) {
    selectedVideoId.value = newValue;
    selectedUserId.value = userId;
    selectcommentId.value = commentId;
    fetchComment();
  }

  void selectedCommentId(String newValue) {
    selectcommentId.value = newValue;
    fetchComment();
  }

  createRequest() {
    CommentRequestModel getRequest = CommentRequestModel();
    getRequest.videoId = selectedVideoId.toString();
    getRequest.commentId = null;
    getRequest.parentCommentId = selectcommentId.toString();
    getRequest.userId = null;
    getRequest.currentUserId = null;
    getRequest.videoReferenceId = "";
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
