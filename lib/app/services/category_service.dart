import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';

class CategoryService {
  getAllCategory() async {
    try {
      var response = await http.post(
          Uri.parse('$baseUrl/api/Lookup/GetCategories'),
          body: json.encode({"categoryId": null, "searchText": ""}),
          headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        box.write('category', decodedUser["data"]);
        return decodedUser["data"];
      } else {
        LoaderX.hide();
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();

      throw e.toString();
    }
  }
}
