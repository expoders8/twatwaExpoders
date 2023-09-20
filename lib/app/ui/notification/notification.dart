import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/constant/constant.dart';
import '../../../config/provider/dotted_line_provider.dart';
import '../../controller/notification_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../widgets/no_user_login_screen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  String authToken = "";
  @override
  void initState() {
    var authTokenValue = box.read('authToken');
    setState(() {
      authToken = authTokenValue ?? "";
    });
    super.initState();
  }

  Future<void> _pullRefresh() async {
    notificationController.fetchAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        title: const Text(
          "Notification",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: authToken != ""
          ? RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Obx(() {
                if (notificationController.isLoading.value) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        buildLazyloading(),
                      ],
                    ),
                  );
                } else {
                  if (notificationController.notificationList[0].data != null) {
                    if (notificationController
                        .notificationList[0].data!.isEmpty) {
                      return Center(
                        child: SizedBox(
                          width: Get.width - 80,
                          child: const Text(
                            "Video not Found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 15,
                                fontFamily: kFuturaPTDemi),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: notificationController
                            .notificationList[0].data!.length,
                        itemBuilder: (context, index) {
                          var discoverData =
                              notificationController.notificationList[0].data!;

                          if (discoverData.isNotEmpty) {
                            var data = discoverData[index];
                            String formattedDate = DateFormat('yyyy-MM-dd')
                                .format(
                                    DateTime.parse(data.createdOn.toString()));
                            String formattedTime = DateFormat('HH:mm:ss')
                                .format(
                                    DateTime.parse(data.createdOn.toString()));
                            final splittedDate = formattedDate.split("-");
                            final splittedTime = formattedTime.split(":");
                            final date1 = DateTime(
                              int.parse(splittedDate[0]),
                              int.parse(splittedDate[1]),
                              int.parse(splittedDate[2]),
                              int.parse(splittedTime[0]),
                              int.parse(splittedTime[1]),
                              int.parse(splittedTime[2]),
                            );
                            final date2 = DateTime.now();
                            final difference = date2.difference(date1).inDays;
                            final differenceHour =
                                date2.difference(date1).inHours;
                            final differenceMinute =
                                date2.difference(date1).inMinutes;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 2.5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 42,
                                            width: 42,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                data.userProfilePhoto
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  "assets/images/blank_profile.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: kWhiteColor,
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 33),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 208,
                                                          child: Text(
                                                            data.notificationTitle
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color:
                                                                    kTextsecondarybottomColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "2 Follwer",
                                                    style: TextStyle(
                                                      color:
                                                          kTextsecondarybottomColor,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        difference >= 1
                                            ? "${difference.toString()}d"
                                            : differenceHour >= 1
                                                ? "${differenceHour.toString()}h"
                                                : "${differenceMinute.toString()}m",
                                        style: const TextStyle(
                                          color: kTextsecondarybottomColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: Get.width - 25,
                                    height: 15,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "Video not Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                    fontFamily: kFuturaPTDemi),
                              ),
                            );
                          }
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: Text(
                        "Video not Found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 15,
                            fontFamily: kFuturaPTDemi),
                      ),
                    );
                  }
                }
              }),
            )
          : const NoUserLoginScreen(),
    );
  }

  buildLazyloading() {
    return SizedBox(
      height: Get.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 20),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: kButtonSecondaryColor,
                  highlightColor: kShimmerEffectSecondary,
                  enabled: true,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: 10,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
