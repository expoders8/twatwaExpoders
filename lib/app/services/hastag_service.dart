import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/hastage_model.dart';

class HashTagsService {
  getAllHastag(String id) async {
    try {
      var response = await http.post(
          Uri.parse('$baseUrl/api/Lookup/GetHashTags'),
          body: json.encode({"categoryId": id, "searchText": ""}),
          headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        final List<dynamic> fetchCategory = decodedUser['data'];
        return fetchCategory.map((json) => HasTagsData.fromJson(json)).toList();
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
