import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../services/payment_service.dart';
import '../../../../config/constant/constant.dart';
import '../../profile/Analytics/user_top_tranding.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';
import '../../../../config/provider/dotted_line_provider.dart';

enum Menu { lastweek, lastyear, today, lastmonth }

class AnalyticsPage extends StatefulWidget {
  final int amount;
  const AnalyticsPage({super.key, required this.amount});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  PaymentService paymentService = PaymentService();
  String selecttext = "Today", userId = "";
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userId = getUserData['id'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "Views",
            //       style: TextStyle(
            //         color: kWhiteColor,
            //         fontSize: 14,
            //       ),
            //     ),
            //     Theme(
            //       data: ThemeData(
            //         splashColor: kTransparentColor,
            //       ),
            //       child: PopupMenuButton<Menu>(
            //         position: PopupMenuPosition.under,
            //         color: kWhiteColor,
            //         onSelected: (Menu item) {
            //           setState(() {});
            //         },
            //         itemBuilder: (BuildContext context) =>
            //             <PopupMenuEntry<Menu>>[
            //           PopupMenuItem<Menu>(
            //             height: 30,
            //             value: Menu.today,
            //             textStyle: const TextStyle(
            //               color: kPrimaryColor,
            //               fontSize: 15,
            //             ),
            //             onTap: () {
            //               selecttext = "Today";
            //             },
            //             child: const Text('Today'),
            //           ),
            //           PopupMenuItem<Menu>(
            //             height: 30,
            //             value: Menu.lastmonth,
            //             textStyle: const TextStyle(
            //               color: kPrimaryColor,
            //               fontSize: 15,
            //             ),
            //             onTap: () {
            //               selecttext = "Last month";
            //             },
            //             child: const Text('Last month'),
            //           ),
            //           PopupMenuItem<Menu>(
            //             height: 30,
            //             value: Menu.lastyear,
            //             textStyle: const TextStyle(
            //               color: kPrimaryColor,
            //               fontSize: 15,
            //             ),
            //             onTap: () {
            //               selecttext = "Last year";
            //             },
            //             child: const Text('Last year'),
            //           ),
            //           PopupMenuItem<Menu>(
            //             height: 30,
            //             value: Menu.lastweek,
            //             textStyle: const TextStyle(
            //               color: kPrimaryColor,
            //               fontSize: 15,
            //             ),
            //             onTap: () {
            //               selecttext = "Last Week";
            //             },
            //             child: const Text('Last Week'),
            //           ),
            //         ],
            //         child: Container(
            //           padding: const EdgeInsets.all(10),
            //           color: kCardColor,
            //           child: Row(
            //             children: [
            //               Text(
            //                 selecttext,
            //                 style: const TextStyle(
            //                   color: kButtonSecondaryColor,
            //                   fontSize: 14,
            //                 ),
            //               ),
            //               const SizedBox(width: 10),
            //               Container(
            //                 padding: const EdgeInsets.only(top: 5),
            //                 height: 20,
            //                 width: 20,
            //                 child: Image.asset(
            //                   "assets/icons/dropdown.png",
            //                   color: kButtonSecondaryColor,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // SizedBox(
            //   width: Get.width - 25,
            //   height: 8,
            //   child: CustomPaint(
            //     painter: DottedLinePainter(),
            //   ),
            // ),
            // SizedBox(
            //   height: 200,
            //   width: Get.width,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: LineChart(
            //       LineChartData(
            //         gridData: FlGridData(show: true),
            //         titlesData: FlTitlesData(
            //           leftTitles: SideTitles(
            //             showTitles: true,
            //           ), // Hide left titles
            //           bottomTitles: SideTitles(
            //             showTitles: true, // Hide bottom titles
            //           ),
            //           rightTitles:
            //               SideTitles(showTitles: false), // Show right titles
            //           topTitles:
            //               SideTitles(showTitles: false), // Show top titles
            //         ),
            //         borderData: FlBorderData(
            //           show: true,
            //           border: const Border(
            //             bottom: BorderSide(
            //                 color: kButtonSecondaryColor,
            //                 width: 1), // Customize bottom line
            //             left: BorderSide(
            //                 color: kButtonSecondaryColor,
            //                 width: 1), // Customize left line
            //           ),
            //         ),
            //         backgroundColor: kBackGroundColor,
            //         lineBarsData: [
            //           LineChartBarData(
            //             spots: [
            //               const FlSpot(5, 100),
            //               const FlSpot(12, 86),
            //               const FlSpot(13, 120),
            //               const FlSpot(14, 135),
            //               const FlSpot(15, 120),
            //               const FlSpot(16, 130),
            //               const FlSpot(17, 140),
            //             ],
            //             isCurved: true,
            //             colors: [kButtonColor],
            //             dotData: FlDotData(show: false),
            //             belowBarData: BarAreaData(show: false),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Balance",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          String.fromCharCodes(Runes('\$')),
                          style: const TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.amount.toString(),
                          style: const TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                widget.amount == 0
                    ? Container()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: withdrawAmout,
                        child: const Text(
                          "Withdraw",
                          style: TextStyle(
                              color: kWhiteColor,
                              letterSpacing: 1,
                              fontSize: 13),
                        ),
                      )
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Top videos",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width - 25,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            const Expanded(
              child: UserTopTrandingHomeView(),
            )
          ],
        ),
      ),
    );
  }

  withdrawAmout() async {
    LoaderX.show(context, 70.0);
    await paymentService
        .userWithdrawAmount(userId, widget.amount.toString())
        .then((value) => {
              if (value["success"])
                {
                  LoaderX.hide(),
                  // Get.offAll(() => const ProfilePage(initialtabIndex: 2)),
                  SnackbarUtils.showSnackbar(value["message"].toString(), "")
                }
              else
                {
                  LoaderX.hide(),
                  SnackbarUtils.showErrorSnackbar(
                      "Failed to withdrawAmount", value["message"].toString())
                }
            });
  }
}
