import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/auth_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class AuthService {
  Future<LoginModel> login(String email, String password) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/Auth/Login'),
          body: json.encode({"email": email, "password": password}),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        var userObj = decodedUser["data"];
        if (userObj != null && decodedUser["success"]) {
          box.write('user', jsonEncode(decodedUser["data"]));
          box.write('authToken', decodedUser["data"]['authToken']);
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

  Future<SignUpModel> signUp(String firstName, String lastName, String emailId,
      String password, String userName, String phoneNumber) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/Auth/Register'),
          body: json.encode({
            "firstName": firstName,
            "lastName": lastName,
            "email": emailId,
            "password": password,
            "userName": userName,
            "phoneNumber": phoneNumber,
          }),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        var userObj = decodedUser["data"];
        if (userObj != null && decodedUser["success"]) {
          box.write('user', jsonEncode(decodedUser["data"]));
          box.write('authToken', decodedUser["data"]['authToken']);
        }
        return SignUpModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while user signup, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Signup", e.toString());
      throw e.toString();
    }
  }

  verifyEmail(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/api/User/VerifyEmail?token=$token'),
      );
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while user verifyEmail, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Signup", e.toString());
      throw e.toString();
    }
  }

  Future<ForgotPasswordModel> forgotPassowrd(String emailId) async {
    try {
      var response =
          await http.post(Uri.parse('$baseUrl/api/Auth/ForgotPassword'),
              body: json.encode({
                "email": emailId,
              }),
              headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return ForgotPasswordModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while sending the mail, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to send email", e.toString());
      throw e.toString();
    }
  }

  Future<LoginModel> socialLogin(
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    String? googleToken,
    String? provider,
    String? fcmToken,
  ) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/Auth/SocialLogin'),
          body: json.encode({
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "profilePicture": profilePicture,
            "googleToken": googleToken,
            "provider": provider,
            "currency": "",
            "fcmToken": fcmToken
          }),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        var userObj = decodedUser["data"];
        if (userObj != null && decodedUser["success"]) {
          box.write('user', jsonEncode(decodedUser["data"]));
          box.write('authToken', decodedUser["data"]['authToken']);
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

  Future<ResetPasswordModel> changePassowrd(
      String userId, String oldPass, String newPass, String currentPass) async {
    var token = box.read('authToken');
    try {
      var response = await http.post(
          Uri.parse('$baseUrl/api/User/ChangePassword'),
          body: json.encode({
            "userId": userId,
            "oldPassword": oldPass,
            "newPassword": newPass,
            "confirmPassword": currentPass,
          }),
          headers: {
            "Authorization": "Bearer $token",
            'Content-type': 'application/json'
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return ResetPasswordModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while sending the mail, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to send email", e.toString());
      throw e.toString();
    }
  }

  otpVerification(String phoneNumber, String otp) async {
    try {
      var response =
          await http.post(Uri.parse('$baseUrl/api/Auth/OTPVerification'),
              body: json.encode({
                "phoneNumber": phoneNumber,
                "otp": otp,
              }),
              headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Verification the Otp, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to Verification Otp", e.toString());
      throw e.toString();
    }
  }

  otpSend(String phoneNumber) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/Auth/OTPSend'),
          body: json.encode({
            "phoneNumber": phoneNumber,
          }),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Send the Otp, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Send Otp", e.toString());
      throw e.toString();
    }
  }
}
