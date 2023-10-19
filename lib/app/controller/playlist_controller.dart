import 'dart:convert';
import 'package:get/get.dart';

import '../models/playlist_model.dart';
import '../services/playlist_service.dart';
import '../../config/constant/constant.dart';
import '../controller/network_controller.dart';

class PlaylistController extends GetxController {
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
    getUser();
    var token = box.read('authToken') ?? "";
    if (networkController.isConnected.value) {
      if (token != "") {
        fetchAllPlaylist();
      }
    }
    super.onInit();
  }

  Future getUser() async {
    var data = box.read('user');
    if (data != null) {
      var getUserData = jsonDecode(data);

      if (getUserData != null) {
        selectedUserId.value = getUserData['id'] ?? "";
      }
      if (networkController.isConnected.value) {
        fetchAllPlaylist();
      }
    }
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
