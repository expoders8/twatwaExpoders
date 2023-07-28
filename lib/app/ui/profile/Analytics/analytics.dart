import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_list_model.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

enum Menu { lastweek, lastyear, today, lastmonth }

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String selecttext = "Today";
  List<Analytics> videos = [
    Analytics(
        image: "assets/images/tranding1.png",
        title: "We Don’t Talk Anymore feat. Selena Gomez",
        views: "65k followers",
        numberTop: 1,
        time: "3:43"),
    Analytics(
        image: "assets/images/tranding2.png",
        title: "The Chainsmokers & Coldplay - Something",
        views: "65k followers",
        numberTop: 2,
        time: ""),
    Analytics(
        image: "assets/images/tranding3.png",
        title: "We Don’t Talk Anymore feat. Selena Gomez",
        views: "65k followers",
        numberTop: 3,
        time: ""),
    Analytics(
        image: "assets/images/jobs1.png",
        title: "We Don’t Talk Anymore feat. Selena Gomez",
        views: "65k followers",
        numberTop: 4,
        time: ""),
    Analytics(
        image: "assets/images/jobs2.png",
        title: "The Chainsmokers & Coldplay - Something",
        views: "65k followers",
        numberTop: 5,
        time: ""),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Views",
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 14,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: kTransparentColor,
                  ),
                  child: PopupMenuButton<Menu>(
                    position: PopupMenuPosition.under,
                    color: kWhiteColor,
                    onSelected: (Menu item) {
                      setState(() {});
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                      PopupMenuItem<Menu>(
                        height: 30,
                        value: Menu.today,
                        textStyle: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 15,
                        ),
                        onTap: () {
                          selecttext = "Today";
                        },
                        child: const Text('Today'),
                      ),
                      PopupMenuItem<Menu>(
                        height: 30,
                        value: Menu.lastmonth,
                        textStyle: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 15,
                        ),
                        onTap: () {
                          selecttext = "Last month";
                        },
                        child: const Text('Last month'),
                      ),
                      PopupMenuItem<Menu>(
                        height: 30,
                        value: Menu.lastyear,
                        textStyle: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 15,
                        ),
                        onTap: () {
                          selecttext = "Last year";
                        },
                        child: const Text('Last year'),
                      ),
                      PopupMenuItem<Menu>(
                        height: 30,
                        value: Menu.lastweek,
                        textStyle: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 15,
                        ),
                        onTap: () {
                          selecttext = "Last Week";
                        },
                        child: const Text('Last Week'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: kCardColor,
                      child: Row(
                        children: [
                          Text(
                            selecttext,
                            style: const TextStyle(
                              color: kButtonSecondaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              "assets/icons/dropdown.png",
                              color: kButtonSecondaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "--------------------------------------------------------",
              style: TextStyle(
                color: kButtonSecondaryColor,
                letterSpacing: 3,
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 190,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1)),
                    minX: 0,
                    maxX: 7,
                    minY: 0,
                    maxY: 6,
                    backgroundColor: kBackGroundColor,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 1),
                          const FlSpot(1, 3),
                          const FlSpot(2, 1.5),
                          const FlSpot(3, 4),
                          const FlSpot(4, 2),
                          const FlSpot(5, 5),
                          const FlSpot(6, 2.5),
                        ],
                        isCurved: true,
                        colors: [kButtonColor],
                        dotData: FlDotData(
                          show: true,
                        ),
                        belowBarData: BarAreaData(
                          show: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              "Top videos",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "--------------------------------------------------------",
              style: TextStyle(
                color: kButtonSecondaryColor,
                letterSpacing: 3,
                fontSize: 10,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: 90,
                      child: Card(
                        color: kCardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4)),
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      videos[index].image,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 7),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 135,
                                              child: Text(
                                                videos[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        kTextsecondarytopColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              videos[index].views,
                                              style: const TextStyle(
                                                color:
                                                    kTextsecondarybottomColor,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 9),
                                child: Text(
                                  videos[index].time,
                                  style: const TextStyle(
                                      color: kButtonSecondaryColor,
                                      fontSize: 11,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: kWhiteColor)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    child: Text(
                                      videos[index].numberTop.toString(),
                                      style: const TextStyle(
                                          color: kButtonSecondaryColor,
                                          fontSize: 18,
                                          fontFamily: kFuturaPTDemi),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
