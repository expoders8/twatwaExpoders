import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/get_setting_model.dart';

Future<GetSettingsModel> getSettings() async {
  try {
    var response = await http.get(Uri.parse(
        "https://opengiving-api.azurewebsites.net/api/Lookup/GetSettings?apiKey=ogkey2023"));
    if (response.statusCode == 200) {
      var res = GetSettingsModel.fromJson(jsonDecode(response.body));
      return res;
    } else {
      return Future.error("Server Error");
    }
  } catch (error) {
    return Future.error(error);
  }
}
