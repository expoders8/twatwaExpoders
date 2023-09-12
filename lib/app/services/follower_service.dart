import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/follower_model.dart';

class FollowerService {
  Future<GetFollower> getAllFollower() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    try {
      var response = await http
          .post(Uri.parse('$baseUrl/userapi/api/User/GetFollowerFollowing'),
              body: json.encode({
                "followerId": null,
                "followeeId": getUserData['id'],
                "userId": null,
                "userName": "",
                "pageSize": 50,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return GetFollower.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Follower, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Follower", e.toString());
      throw e.toString();
    }
  }

  Future<GetFollower> getAllOtherUserFollower(
      String otherUserId, checkText) async {
    try {
      var response = await http
          .post(Uri.parse('$baseUrl/userapi/api/User/GetFollowerFollowing'),
              body: json.encode({
                "followerId": checkText == "following" ? otherUserId : null,
                "followeeId": checkText == "" ? otherUserId : null,
                "userId": null,
                "userName": "",
                "pageSize": 50,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return GetFollower.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Follower, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Follower", e.toString());
      throw e.toString();
    }
  }

  Future<GetFollower> getAllFollowing() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    try {
      var response = await http
          .post(Uri.parse('$baseUrl/userapi/api/User/GetFollowerFollowing'),
              body: json.encode({
                "followerId": getUserData['id'],
                "followeeId": null,
                "userId": null,
                "userName": "",
                "pageSize": 50,
                "pageNumber": 1,
                "searchText": "",
                "sortBy": ""
              }),
              headers: {
            'Content-type': 'application/json',
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return GetFollower.fromJson(data);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Follower, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Follower", e.toString());
      throw e.toString();
    }
  }

  followAndUnfollow(String id) async {
    var token = box.read('authToken');
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    try {
      var response = await http.post(
          Uri.parse('$baseUrl/userapi/api/User/FollowUnFollow'),
          body:
              json.encode({"followerId": getUserData['id'], "followeeId": id}),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token",
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Follower, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Follower", e.toString());
      throw e.toString();
    }
  }
}
