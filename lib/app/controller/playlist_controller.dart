import 'package:get/get.dart';

import '../../config/constant/constant.dart';
import '../models/playlist_model.dart';
import '../services/playlist_service.dart';

class PlaylistController extends GetxController {
  var isLoading = true.obs;
  var playList = <PlaylistModel>[].obs;
  PlaylistService playlistService = PlaylistService();

  @override
  void onInit() {
    var token = box.read('authToken') ?? "";
    if (token != "") {
      fetchAllPlaylist("", "");
    }
    super.onInit();
  }

  void fetchAllPlaylist(String userId, checkOtherplaylist) async {
    try {
      isLoading(true);
      var data =
          await playlistService.getMyPlayLists(userId, checkOtherplaylist);
      playList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
