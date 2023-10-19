import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/playlist_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../ui/auth/login/login.dart';

class PlaylistService {
  createPlaylist(
    String userId,
    String playlistName,
    String privacyType,
  ) async {
    try {
      var token = box.read('authToken');
      var response =
          await http.post(Uri.parse('$baseUrl/api/Video/AddPlaylist'),
              body: json.encode({
                "userId": userId,
                "playlistName": playlistName,
                "isActive": true,
                "isChecked": true,
                "privacyType": privacyType,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
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

  Future<PlaylistModel> getMyPlayLists(PlaylistRequestModel getRequest) async {
    try {
      var token = box.read('authToken');
      var response =
          await http.post(Uri.parse('$baseUrl/api/Video/GetMyPlayLists'),
              body: json.encode({
                "videoId": getRequest.videoId,
                "userId": getRequest.userId,
                "userName": getRequest.userName,
                "playlistId": getRequest.playlistId,
                "pageSize": getRequest.pageSize,
                "pageNumber": getRequest.pageNumber,
                "searchText": getRequest.searchText,
                "sortBy": getRequest.sortBy,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return PlaylistModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        // SnackbarUtils.showErrorSnackbar("Server Error",
        //     "Error while Playlist, Please try after some time.");
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
      var response =
          await http.post(Uri.parse('$baseUrl/api/Video/UpdatePlaylist'),
              body: json.encode({
                "playlistId": playlistId,
                "userId": userId,
                "playlistName": playlistName,
                "privacyType": privacyType,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
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
      var response =
          await http.post(Uri.parse('$baseUrl/api/Video/RemovePlaylist'),
              body: json.encode({
                "playlistId": playlistId,
                "userId": userId,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
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
      var response =
          await http.post(Uri.parse('$baseUrl/api/Video/AddVideoToPlaylist'),
              body: json.encode({
                "data": playlistData,
              }),
              headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
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

  authError() {
    LoaderX.hide();
    SnackbarUtils.showErrorSnackbar(
        "Authentication Error", "Please login again.");
    box.write('onBoard', 1);
    box.remove('user');
    box.remove('authToken');

    Get.offAll(() => const LoginPage());
  }
}
