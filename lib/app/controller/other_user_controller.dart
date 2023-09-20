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
  final RxString selectedOtherUserId = "".obs;
  @override
  void onInit() {
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
    getRequest.pageNumber = 1;
    getRequest.pageSize = 100;
    getRequest.searchText = "";
    getRequest.sortBy = "";
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

class OtherUserPlaylistController extends GetxController {
  var isLoading = true.obs;
  var playList = <PlaylistModel>[].obs;
  PlaylistService playlistService = PlaylistService();
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  final RxString selectedUserId = "".obs;

  @override
  void onInit() {
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
    getRequest.pageNumber = 1;
    getRequest.pageSize = 100;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  void fetchAllPlaylist() async {
    try {
      isLoading(true);
      var stories = await playlistService.getMyPlayLists(createRequest());
      playList.assign(stories);
    } finally {
      isLoading(false);
    }
  }
}
