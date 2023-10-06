import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../models/state_model.dart';
import '../../../models/country_model.dart';
import '../../widgets/custom_textfield.dart';
import '../../../services/state_service.dart';
import '../../../services/payment_service.dart';
import '../../../services/country_service.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';
import '../../video_details/checkout_Payment/paypal_screen.dart';
import '../../video_details/checkout_Payment/money_donate_card.dart';
import '../../video_details/checkout_Payment/payment_successful.dart';
import '../../video_details/checkout_Payment/payment_type_saved_card.dart';

class CheckOutPaymentPage extends StatefulWidget {
  final String? videoId;
  final String? userId;
  const CheckOutPaymentPage({super.key, this.videoId, this.userId});

  @override
  State<CheckOutPaymentPage> createState() => _CheckOutPaymentPageState();
}

class _CheckOutPaymentPageState extends State<CheckOutPaymentPage> {
  int tabindex = 0;
  bool _switchValue = true,
      checkedValue = false,
      isFormSubmitted = false,
      validateStateId = false,
      validateCountryId = false;

  String pickedCountryId = "",
      pickedStateId = "",
      donationAmount = "5",
      cardId = "",
      userId = "",
      cardToken = "";
  CardFieldInputDetails? creditCard;
  final _paymentDonationFormKey = GlobalKey<FormState>();
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  TextEditingController countrySearchController = TextEditingController();
  TextEditingController stateSearchController = TextEditingController();
  CardFormEditController controller = CardFormEditController();
  PaymentService paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: kButtonSecondaryColor,
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              "assets/icons/back.png",
              scale: 9,
            ),
          ),
        ),
        title: const Text(
          "Checkout Now",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Form(
              key: _paymentDonationFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextWidget("Donation Amount", false),
                  const SizedBox(height: 10),
                  MoneyDonateCard(
                    callbackAmount: (val) {
                      if (mounted) {
                        setState(() {
                          donationAmount = val;
                        });
                      }
                    },
                    // donateItemQty: widget.data.donated_Quantity,
                    // raisingItemQty: widget.data.raising_Item_Qty,
                  ),
                  buildTextWidget("PAYMENT DETAILS", false),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildSelectFildCard("SAVED CARDS", 0),
                        const SizedBox(width: 10),
                        buildSelectFildCard("PAYPAL", 1),
                        const SizedBox(width: 10),
                        buildSelectFildCard("DEBIT CARD", 2),
                        const SizedBox(width: 10),
                        buildSelectFildCard("CREDIT CARD", 3),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  tabindex == 0 ? const PaymentTypeSavedCard() : Container(),
                  tabindex == 2 ? buildPaymentCard() : Container(),
                  tabindex == 3 ? buildPaymentCard() : Container(),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CupertinoSwitch(
                        activeColor: kTextSecondaryColor,
                        thumbColor: kButtonColor,
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Save payment card for auto renewal for future. ",
                          style: TextStyle(
                              color: kButtonSecondaryColor, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  buildTextWidget("Billing Details", false),
                  buildTextWidget("FLAT / HOUSENO. / BUILDING", true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5),
                    child: CustomTextFormField(
                      hintText: 'FLAT / HOUSENO. / BUILDING',
                      maxLines: 1,
                      ctrl: street1Controller,
                      name: "street1",
                      formSubmitted: isFormSubmitted,
                      validationMsg: 'Please enter STREET1',
                    ),
                  ),
                  buildTextWidget("LOCALITY / COLONY / STREET", true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5),
                    child: CustomTextFormField(
                      hintText: 'LOCALITY / COLONY / STREET',
                      maxLines: 1,
                      ctrl: street2Controller,
                      name: "street2",
                      formSubmitted: isFormSubmitted,
                      validationMsg: 'Please enter STREET2',
                    ),
                  ),
                  buildTextWidget("Country", true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5),
                    child: TypeAheadField<CountryDataModel?>(
                      debounceDuration: const Duration(microseconds: 10),
                      hideSuggestionsOnKeyboardHide: true,
                      keepSuggestionsOnLoading: true,
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: countrySearchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xB3493F54),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                                color: validateCountryId == true
                                    ? const Color(0xFFB52116)
                                    : const Color(0xB3493F54)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                                color: validateCountryId == true
                                    ? const Color(0xFFB52116)
                                    : const Color(0xB3493F54)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                                color: validateCountryId == true
                                    ? const Color(0xFFB52116)
                                    : const Color(0xB3493F54)),
                          ),
                          hintText: 'Country',
                          hintStyle: const TextStyle(
                            fontFamily: kFuturaPTBook,
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,
                            fontSize: 14,
                          ),
                          hintMaxLines: 1,
                          contentPadding: const EdgeInsets.all(15),
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 50, minHeight: 10),
                          suffixIcon: Container(
                            padding: const EdgeInsets.only(right: 10),
                            height: 13.71,
                            width: 30.02,
                            child: Image.asset(
                              "assets/icons/dropdown.png",
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: kFuturaPTBook,
                          fontWeight: FontWeight.w400,
                          color: kWhiteColor,
                          fontSize: 14,
                        ),
                        autocorrect: true,
                      ),
                      noItemsFoundBuilder: (context) => const SizedBox(
                        child: Center(
                          child: Text('No Country found'),
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return CountryService.getCountry(pattern);
                      },
                      itemBuilder: (context, CountryDataModel? suggestion) {
                        return ListTile(
                          title: Text(suggestion!.name.toString()),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (CountryDataModel? suggestion) {
                        setState(() {
                          final country = suggestion!;
                          pickedCountryId = suggestion.id!;
                          countrySearchController.text = country.name!;
                          validateCountryId = false;
                        });
                      },
                    ),
                  ),
                  validateCountryId == true
                      ? const Padding(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          child: Text("Country is required",
                              style: TextStyle(
                                color: kErrorColor,
                                fontSize: 11,
                              )),
                        )
                      : Container(),
                  buildTextWidget("State", true),
                  pickedCountryId == ""
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 5),
                          child: Container(
                            height: 46,
                            width: Get.width,
                            padding: const EdgeInsets.only(top: 14, left: 12),
                            decoration: BoxDecoration(
                                color: const Color(0xB3493F54),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text(
                              "Select Country",
                              style: TextStyle(
                                fontFamily: kFuturaPTBook,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 5),
                          child: TypeAheadField<StateDataModel?>(
                            debounceDuration: const Duration(microseconds: 10),
                            hideSuggestionsOnKeyboardHide: true,
                            keepSuggestionsOnLoading: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: stateSearchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xB3493F54),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: validateStateId == true
                                          ? const Color(0xFFB52116)
                                          : const Color(0xB3493F54)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: validateStateId == true
                                          ? const Color(0xFFB52116)
                                          : const Color(0xB3493F54)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: validateStateId == true
                                          ? const Color(0xFFB52116)
                                          : const Color(0xB3493F54)),
                                ),
                                hintText: 'State',
                                hintStyle: const TextStyle(
                                  fontFamily: kFuturaPTBook,
                                  fontWeight: FontWeight.w400,
                                  color: kWhiteColor,
                                  fontSize: 14,
                                ),
                                hintMaxLines: 1,
                                contentPadding: const EdgeInsets.all(15),
                                suffixIconConstraints: const BoxConstraints(
                                    minWidth: 50, minHeight: 10),
                                suffixIcon: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  height: 13.71,
                                  width: 30.02,
                                  child: Image.asset(
                                    "assets/icons/dropdown.png",
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontFamily: kFuturaPTBook,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                                fontSize: 14,
                              ),
                              autocorrect: true,
                            ),
                            noItemsFoundBuilder: (context) => const SizedBox(
                              child: Center(
                                child: Text('No State found'),
                              ),
                            ),
                            suggestionsCallback: (pattern) {
                              return StateService.getStates(
                                  pattern, pickedCountryId);
                            },
                            itemBuilder: (context, StateDataModel? suggestion) {
                              return ListTile(
                                title: Text(suggestion!.name.toString()),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (StateDataModel? suggestion) {
                              setState(() {
                                final state = suggestion!;
                                pickedStateId = suggestion.id!;
                                stateSearchController.text = state.name!;
                                validateStateId = false;
                              });
                            },
                          ),
                        ),
                  validateStateId == true
                      ? const Padding(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          child: Text("State is required",
                              style: TextStyle(
                                color: kErrorColor,
                                fontSize: 11,
                              )),
                        )
                      : Container(),
                  buildTextWidget("CITY", true),
                  pickedStateId == ""
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 5),
                          child: Container(
                            height: 46,
                            width: Get.width,
                            padding: const EdgeInsets.only(top: 14, left: 12),
                            decoration: BoxDecoration(
                                color: const Color(0xB3493F54),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text(
                              "Select State",
                              style: TextStyle(
                                fontFamily: kFuturaPTBook,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 5),
                          child: CustomTextFormField(
                            hintText: 'Enter',
                            maxLines: 1,
                            ctrl: cityController,
                            name: "city",
                            formSubmitted: isFormSubmitted,
                            validationMsg: 'Please enter City',
                          ),
                        ),
                  const SizedBox(height: 25),
                  Center(
                    child: SizedBox(
                      width: Get.width - 40,
                      child: CupertinoButton(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(25),
                        onPressed: donetPayment,
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              color: kWhiteColor,
                              letterSpacing: 2,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  donetPayment() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_paymentDonationFormKey.currentState!.validate() &&
          pickedCountryId != "" &&
          pickedStateId != "") {
        LoaderX.show(context, 70.0);
        if (tabindex == 2 || tabindex == 3) {
          Stripe.instance
              .createToken(const CreateTokenParams.card(
                  params: CardTokenParams(
            currency: "USD",
          )))
              .then((value) async {
            if (mounted) {
              setState(() {
                cardToken = value.id;
                cardId = value.card!.id!;
              });
              await paymentService
                  .donate(
                      widget.videoId.toString(),
                      widget.userId.toString(),
                      int.parse(donationAmount),
                      value.id,
                      "STRIPE",
                      street1Controller.text,
                      street2Controller.text,
                      pickedCountryId,
                      pickedStateId,
                      cityController.text,
                      controller.details.postalCode.toString())
                  .then(
                (value) async {
                  if (value['success']) {
                    LoaderX.hide();
                    navigateTransactionResPage(value['data']['cardToken'],
                        value['data']['paymentGateway']);
                  } else {
                    LoaderX.hide();
                    SnackbarUtils.showErrorSnackbar(
                        "Failed to payment", value['message'].toString());
                  }
                  return null;
                },
              );
            }
          });
        } else if (tabindex == 1) {
          LoaderX.hide();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PaypalPayment(
                donationAmount: donationAmount,
                cityName: cityController.text,
                stateName: stateSearchController.text,
                title: "hello fdsfsdfsdfsdfsdfsdf",
                userFullName: "",
                isAnonymous: checkedValue,
                onFinish: (number) async {
                  Future.delayed(const Duration(seconds: 3), () async {
                    if (number != "") {
                      await paymentService
                          .donate(
                              widget.videoId.toString(),
                              widget.userId.toString(),
                              int.parse(donationAmount),
                              number,
                              "PAYPAL",
                              street1Controller.text,
                              street2Controller.text,
                              pickedCountryId,
                              pickedStateId,
                              cityController.text,
                              controller.details.postalCode.toString())
                          .then(
                        (value) async {
                          if (value['success']) {
                            LoaderX.hide();
                            navigateTransactionResPage(
                                value['data']['cardToken'],
                                value['data']['paymentGateway']);
                          } else {
                            LoaderX.hide();
                            SnackbarUtils.showErrorSnackbar("Failed to payment",
                                value['message'].toString());
                          }
                          return null;
                        },
                      );
                    } else {
                      SnackbarUtils.showErrorSnackbar("Please try again", "");
                    }
                  });
                },
                onFinishtime: (time) async {
                  if (time == 1) {
                    LoaderX.show(context, 70.0);
                  }
                },
              ),
            ),
          );
        } else {
          if (cardId != "") {
            Future.delayed(const Duration(seconds: 3), () async {
              await paymentService
                  .donate(
                      widget.videoId.toString(),
                      widget.userId.toString(),
                      int.parse(donationAmount),
                      cardToken,
                      "stripe",
                      street1Controller.text,
                      street2Controller.text,
                      pickedCountryId,
                      pickedStateId,
                      cityController.text,
                      controller.details.postalCode.toString())
                  .then(
                (value) async {
                  if (value['success']) {
                    LoaderX.hide();
                    navigateTransactionResPage(value['data']['cardToken'],
                        value['data']['paymentGateway']);
                  } else {
                    LoaderX.hide();
                    SnackbarUtils.showErrorSnackbar(
                        "Failed to payment", value['message'].toString());
                  }
                  return null;
                },
              );
            });
          }
        }
      }
    });
  }

  checkpayment(value) {
    LoaderX.hide();
    SnackbarUtils.showErrorSnackbar(value, "");
  }

  checkValidation() {
    if (pickedCountryId == "") {
      setState(() {
        validateCountryId = true;
      });
    }
    if (pickedStateId == "") {
      setState(() {
        validateStateId = true;
      });
    }
  }

  navigateTransactionResPage(String? refId, String? refrenceProvider) {
    LoaderX.hide();
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    // String convertedTime = DateFormat("hh:mm a").format(now);
    LoaderX.hide();
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MoneyPaymentSuccessfulPage(
          pickedDate: formattedDate,
          referenceId: refId.toString(),
          referenceProvider: refrenceProvider.toString(),
        ),
      ),
    );
  }

  Widget buildPaymentCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kWhiteColor),
        child: CardFormField(
          controller: controller,
          style: CardFormStyle(
            backgroundColor: kWhiteColor,
            textColor: kPrimaryColor,
            textErrorColor: kErrorColor,
            borderRadius: 10,
            cursorColor: kPrimaryColor,
            placeholderColor: kPrimaryColor,
            fontSize: 14,
          ),
          dangerouslyGetFullCardDetails: true,
          onCardChanged: (card) {
            if (mounted) {
              setState(() {
                creditCard = card;
              });
            }
          },
        ),
      ),
    );
  }

  Widget buildTextWidget(String text, bool textfildName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 20, 0, 5),
      child: Text(
        text,
        style: TextStyle(
            color: textfildName ? kButtonSecondaryColor : kWhiteColor,
            fontSize: textfildName ? 12 : 14),
      ),
    );
  }

  buildSelectFildCard(String text, int selectIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabindex = selectIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: tabindex == selectIndex ? kButtonColor : kBackGroundColor,
            border: Border.all(
                color: tabindex == selectIndex
                    ? kButtonColor
                    : kButtonSecondaryColor,
                width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: tabindex == selectIndex
                      ? kWhiteColor
                      : kButtonSecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
