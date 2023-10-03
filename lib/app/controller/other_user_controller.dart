import 'package:get/get.dart';

import '../models/video_model.dart';
import '../models/playlist_model.dart';
import '../services/video_service.dart';
import '../services/playlist_service.dart';
import '../controller/network_controller.dart';

class OtherUserVideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <GetAllVideoModel>[].obs;
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  VideoService videoService = VideoService();
  final RxString selectedOtherUserId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());
  @override
  void onInit() {
    if (networkController.isConnected.value) {
      if (selectedOtherUserId.value != "") {
        fetchVideo();
      }
    }
    super.onInit();
  }

  void updateString(String newValue) {
    selectedOtherUserId.value = newValue;
    fetchVideo();
  }

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.userId = selectedOtherUserId.toString();
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

class OtherUserPlaylistController extends GetxController {
  var isLoading = true.obs;
  var playList = <PlaylistModel>[].obs;
  PlaylistService playlistService = PlaylistService();
  var page = 1.obs;
  var limit = 10.obs;
  int loadedItems = 0;
  var isAddingMore = false.obs;
  final RxString selectedUserId = "".obs;
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      if (selectedUserId.value != "") {
        fetchAllPlaylist();
      }
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
