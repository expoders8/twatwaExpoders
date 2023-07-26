import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/constant/color_constant.dart';
import '../../widgets/custom_textfield.dart';
import 'payment_type_saved_card.dart';

class CheckOutPaymentPage extends StatefulWidget {
  const CheckOutPaymentPage({super.key});

  @override
  State<CheckOutPaymentPage> createState() => _CheckOutPaymentPageState();
}

class _CheckOutPaymentPageState extends State<CheckOutPaymentPage> {
  int tabindex = 0;
  bool _switchValue = true;
  bool checkedValue = false;
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CupertinoSwitch(
                  //   trackColor: const Color(0xFF2A2B45),
                  //   activeColor: const Color(0xFF2A2B45),
                  //   thumbColor: kButtonColor,
                  //   value: _switchValue,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _switchValue = value;
                  //     });
                  //   },
                  // ),
                  Switch(
                    activeColor:
                        kButtonColor, // Set the active color when the switch is turned on.
                    inactiveTrackColor: const Color(0xFF2A2B45),
                    activeTrackColor: const Color(0xFF2A2B45),
                    inactiveThumbColor: kButtonSecondaryColor,
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
                      style:
                          TextStyle(color: kButtonSecondaryColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
              buildTextWidget("Billing Details", false),
              buildTextWidget("FLAT / HOUSENO. / BUILDING", true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5),
                child: CustomTextFormField(
                  hintText: 'Enter',
                  maxLines: 1,
                  ctrl: street1Controller,
                  name: "street1",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
              ),
              buildTextWidget("LOCALITY / COLONY / STREET", true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5),
                child: CustomTextFormField(
                  hintText: 'Enter',
                  maxLines: 1,
                  ctrl: street2Controller,
                  name: "street2",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
              ),
              buildTextWidget("STATE", true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5),
                child: CustomTextFormField(
                  hintText: 'Enter',
                  maxLines: 1,
                  ctrl: cityController,
                  name: "start",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
              ),
              buildTextWidget("CITY", true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5),
                child: CustomTextFormField(
                  hintText: 'Enter',
                  maxLines: 1,
                  ctrl: cityController,
                  name: "city",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: Get.width - 40,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: () {},
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
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
