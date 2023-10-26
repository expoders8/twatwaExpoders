import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/auth_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../ui/auth/login/login.dart';

class UserService {
  Future<LoginModel> updateUserProfile(
      String userId,
      String firstName,
      String lastName,
      String userEmail,
      String userName,
      File? profilePhoto) async {
    try {
      var token = box.read('authToken');
      http.Response response;
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/api/User/UpdateProfile"))
        ..fields['userId'] = userId
        ..fields['firstName'] = firstName
        ..fields['lastName'] = lastName
        ..fields['userName'] = userName
        ..fields['userEmail'] = userEmail;
      // ..fields['profilePhoto'] = profilePhoto!.path;
      if (profilePhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'profilePhoto', profilePhoto.path));
      }
      request.headers.addAll({
        "Authorization": "Bearer $token",
        // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
      });
      response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["success"] == true) {
          var userObj = responseData["data"];
          if (userObj != null) {
            box.write('user', jsonEncode(responseData["data"]));
          }
        }
        return LoginModel.fromJson(responseData);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while update profile, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (error) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to update", error.toString());
      return Future.error(error);
    }
  }

  userAccountDelete() async {
    var token = box.read('authToken');
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/User/Delete'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        authError();
        return Future.error("Authentication Error");
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while userDelete, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to userDelete", e.toString());
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
