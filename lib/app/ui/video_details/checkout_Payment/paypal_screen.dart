// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../services/payment_service.dart';
import '../../../services/paypal.service.dart';

class PaypalPayment extends StatefulWidget {
  final String userFullName;
  final String cityName;
  final String stateName;
  final String title;
  final String donationAmount;
  final Function onFinish;
  final Function onFinishtime;
  final bool isAnonymous;

  const PaypalPayment(
      {super.key,
      required this.onFinish,
      required this.donationAmount,
      required this.isAnonymous,
      required this.onFinishtime,
      required this.userFullName,
      required this.cityName,
      required this.stateName,
      required this.title});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  String money = "";
  String paypalDomainUrl = "";
  String paypalClientId = "";
  String paypalClientSecret = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late Future<DonationModel>? moneyDonateFuture;
  var checkoutUrl;
  var executeUrl;
  var payerID;
  var accessToken;
  PaypalServices services = PaypalServices();
  PaymentService paymentService = PaymentService();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            payerID = res['id'];
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": "Money",
        "quantity": 1,
        "price": widget.donationAmount,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = widget.donationAmount;
    String subTotalAmount = widget.donationAmount;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = widget.userFullName;
    String userLastName = 'Expo';
    String addressCity = widget.cityName;
    String addressStreet = widget.stateName;
    String addressZipCode = '';
    String addressCountry = '';
    String addressState = '';
    String addressPhoneNumber = "+";

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": "$userFirstName $userLastName",
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": widget.title,
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  widget.onFinishtime(1);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}
