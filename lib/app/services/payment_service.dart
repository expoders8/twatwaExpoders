import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class PaymentService {
  donate(
      String videoId,
      String userId,
      int amountDonated,
      String cardToken,
      String paymentMethod,
      String addressLine1,
      String addressLine2,
      String countryId,
      String stateId,
      String cityName,
      String postalCode) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/Payment/Donate'),
          body: json.encode({
            "donationId": "f9dabbd7-6fbc-4019-ba29-962df352b735",
            "toUserId": userId,
            "amountDonated": amountDonated,
            "cardToken": cardToken,
            "paymentReferenceId": "",
            "paymentMethod": "",
            "videoId": videoId,
            "addressLine1": addressLine1,
            "addressLine2": addressLine2,
            "countryId": countryId,
            "stateId": stateId,
            "cityName": cityName,
            "postalCode": postalCode,
            "paymentGateway": paymentMethod,
            "createdOn": null,
            "createdById": null,
            "updatedOn": null,
            "updatedById": null,
            "isActive": true
          }),
          headers: {
            'Content-type': 'application/json',
            // 'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey
          });
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        return decodedUser;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(
            "Server Error", "Error while payment, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to payment", e.toString());
      throw e.toString();
    }
  }
}
