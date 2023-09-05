import 'package:get/get.dart';

import '../models/comments_model.dart';
import '../services/comment_service.dart';

class CommentsController extends GetxController {
  var isLoading = true.obs;
  CommnetsService commnetsService = CommnetsService();
  var commentList = <GetAllComments>[].obs;

  void fetchComments(String videoId, userId) async {
    try {
      isLoading(true);
      var stories = await commnetsService.getAllComments(videoId, userId);
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
