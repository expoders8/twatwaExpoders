import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/auth_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

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
          "POST", Uri.parse("$baseUrl/userapi/api/User/UpdateProfile"))
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
        'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
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
}
