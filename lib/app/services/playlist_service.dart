import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class PlaylistService {
  createPlaylist(
    String userId,
    String playlistName,
    bool isChecked,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/AddPlaylist'),
          body: json.encode({
            "userId": userId,
            "playlistName": playlistName,
            "isActive": true,
            "isChecked": isChecked,
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Playlist, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Playlist", e.toString());
      throw e.toString();
    }
  }

  getMyPlayLists(
    String userId,
    String playlistName,
    bool isChecked,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetMyPlayLists'),
          body: json.encode({
            "videoId": null,
            "userId": userId,
            "userName": "",
            "playlistId": null,
            "pageSize": 0,
            "pageNumber": 0,
            "searchText": "",
            "sortBy": "",
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Playlist, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Playlist", e.toString());
      throw e.toString();
    }
  }
}
