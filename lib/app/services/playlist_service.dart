import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/playlist_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class PlaylistService {
  createPlaylist(
    String userId,
    String playlistName,
    String privacyType,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/AddPlaylist'),
          body: json.encode({
            "userId": userId,
            "playlistName": playlistName,
            "isActive": true,
            "isChecked": true,
            "privacyType": privacyType,
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

  Future<PlaylistModel> getMyPlayLists() async {
    try {
      var data = box.read('user');
      var getUserData = jsonDecode(data);
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/GetMyPlayLists'),
          body: json.encode({
            "videoId": null,
            "userId": getUserData['id'],
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
        return PlaylistModel.fromJson(decodedUser);
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

  editPlaylist(
    String playlistId,
    String userId,
    String playlistName,
    String privacyType,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/UpdatePlaylist'),
          body: json.encode({
            "playlistId": playlistId,
            "userId": userId,
            "playlistName": playlistName,
            "privacyType": privacyType,
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
            "Error while Update Playlist, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to Update Playlist", e.toString());
      throw e.toString();
    }
  }

  removePlaylist(
    String playlistId,
    String userId,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/RemovePlaylist'),
          body: json.encode({
            "playlistId": playlistId,
            "userId": userId,
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
            "Error while Remove Playlist, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to Remove Playlist", e.toString());
      throw e.toString();
    }
  }

  addVideoToPlaylist(
    List playlistData,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$videobBaseUrl/api/Video/AddVideoToPlaylist'),
          body: json.encode({
            "data": playlistData,
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
            "Error while Add Video To Playlist, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to Add Video To Playlist", e.toString());
      throw e.toString();
    }
  }
}
