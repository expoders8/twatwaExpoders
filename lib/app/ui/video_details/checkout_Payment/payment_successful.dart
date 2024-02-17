import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../home/tab_page.dart';
import '../../../../config/constant/color_constant.dart';

class MoneyPaymentSuccessfulPage extends StatefulWidget {
  final String pickedDate;
  final String referenceId;
  final String referenceProvider;
  const MoneyPaymentSuccessfulPage(
      {super.key,
      required this.pickedDate,
      required this.referenceId,
      required this.referenceProvider});

  @override
  State<MoneyPaymentSuccessfulPage> createState() =>
      _MoneyPaymentSuccessfulPageState();
}

class _MoneyPaymentSuccessfulPageState
    extends State<MoneyPaymentSuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: kButtonSecondaryColor,
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(() => const TabPage());
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
          "Published",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.offAll(() => const TabPage());
          return Future.value(false);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  "assets/icons/payment_successful.png",
                ),
                const SizedBox(height: 60),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations you are premium member now.🤟",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 280,
                      child: Text(
                        textAlign: TextAlign.center,
                        "You will be receiving a confirmation email with order details",
                        style: TextStyle(
                          color: kTextsecondarybottomColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * 0.32,
                      child: Column(
                        children: [
                          Text(
                            widget.referenceId,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: kWhiteColor,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            "PAYMENT REFERENCE",
                            style: TextStyle(
                                fontSize: 11, color: kButtonSecondaryColor),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/icons/line_vertical.png",
                      scale: 2,
                    ),
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Column(
                        children: [
                          Text(
                            widget.referenceProvider != "stripe"
                                ? widget.referenceProvider
                                : "credit card",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: kWhiteColor,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            " PAYMENT MODE",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11, color: kButtonSecondaryColor),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/icons/line_vertical.png",
                      scale: 2,
                    ),
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Column(
                        children: [
                          Text(
                            widget.pickedDate.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: kWhiteColor,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            "PAYMENT DATE",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11, color: kButtonSecondaryColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: Get.width - 50,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: () {
                      Get.offAll(() => const TabPage());
                    },
                    child: const Text(
                      'GO TO HOME',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
