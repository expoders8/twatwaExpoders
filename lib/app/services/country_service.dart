import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/country_model.dart';

class CountryService {
  static Future<List<CountryDataModel>> getCountry(String query) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/lookupapi/api/Lookup/GetCountries'),
          headers: {
            'Content-type': 'application/json',
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final List<dynamic> fetchCountry = data['data'];
        return fetchCountry
            .map((e) => CountryDataModel.fromJson(e))
            .where((value) {
          final titleLower = value.name!.toLowerCase();
          final searchLower = query.toLowerCase();

          return titleLower.contains(searchLower);
        }).toList();
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(
            "Server Error", "Error while country, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to country", e.toString());
      throw e.toString();
    }
  }
}
