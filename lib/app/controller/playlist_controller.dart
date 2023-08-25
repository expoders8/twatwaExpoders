import 'package:get/get.dart';

import '../models/playlist_model.dart';
import '../services/playlist_service.dart';

class PlaylistController extends GetxController {
  var isLoading = true.obs;
  var playList = <PlaylistModel>[].obs;
  PlaylistService playlistService = PlaylistService();
  RxString user = "".obs;

  void fetchAllPlaylist() async {
    try {
      isLoading(true);
      var data = await playlistService.getMyPlayLists();
      playList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
