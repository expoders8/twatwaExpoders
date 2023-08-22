import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class NotificationService {
  updateNotificationSetting(
    String id,
    String userId,
    bool subscriptionAlert,
    bool recommended,
    bool channelAlert,
    bool commentAlert,
    bool replyOnCommentAlert,
    bool mentionAlert,
    bool activityOnOtherChannelAlert,
  ) async {
    try {
      var token = box.read('authToken');
      var response = await http.post(
          Uri.parse(
              '$notificationBaseUrl/api/Notification/UpdateNotificationSetting'),
          body: json.encode({
            "id": id,
            "userId": userId,
            "subscriptionAlert": subscriptionAlert,
            "recommendedVideoAlert": recommended,
            "activityOnChannelAlert": channelAlert,
            "activityOnCommentAlert": commentAlert,
            "replyOnCommentAlert": replyOnCommentAlert,
            "mentionAlert": mentionAlert,
            "activityOnOtherChannelAlert": activityOnOtherChannelAlert,
            "createdOn": "2023-08-22T09:05:27.348Z",
            "createdById": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "updatedOn": "2023-08-22T09:05:27.348Z",
            "updatedById": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "isActive": true
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
            "Error while notification setting, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to notification setting", e.toString());
      throw e.toString();
    }
  }

  getNotificationSetting(String userId) async {
    var token = box.read('authToken');
    try {
      final response = await http.get(
          Uri.parse(
              '$notificationBaseUrl/api/Notification/GetNotificationSetting/$userId'),
          headers: {
            'Content-type': 'application/json',
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while notification setting, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(
          "Failed to notification setting", e.toString());
      throw e.toString();
    }
  }
}
