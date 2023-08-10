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
      String firstname,
      String lastName,
      String userEmail,
      String userName,
      File? profilePhoto) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse('$baseUrl/api/User/UpdateProfile'),
          body: json.encode({
            "userId": userId,
            "firstName": firstname,
            "lastName": lastName,
            "userEmail": userEmail,
            "userName": userName,
            "profilePhoto": "profilePhoto"
          }),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        var userObj = decodedUser["data"];
        if (userObj != null && decodedUser["success"]) {
          box.write('user', jsonEncode(decodedUser["data"]));
        }
        return LoginModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while user login, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to login", e.toString());
      throw e.toString();
    }
  }
}
