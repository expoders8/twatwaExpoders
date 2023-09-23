import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/state_model.dart';

class StateService {
  static Future<List<StateDataModel>> getStates(
      String query, String countryId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/lookupapi/api/Lookup/GetStates/$countryId'),
          headers: {
            'Content-type': 'application/json',
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final List<dynamic> fetchCountry = data['data'];
        return fetchCountry
            .map((e) => StateDataModel.fromJson(e))
            .where((value) {
          final titleLower = value.name!.toLowerCase();
          final searchLower = query.toLowerCase();

          return titleLower.contains(searchLower);
        }).toList();
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(
            "Server Error", "Error while State, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to State", e.toString());
      throw e.toString();
    }
  }
}
