import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_controller.dart';
import '../../../controller/video_detail_controller.dart';
import '../../../routes/app_pages.dart';

class UserTopTrandingHomeView extends StatefulWidget {
  const UserTopTrandingHomeView({super.key});

  @override
  State<UserTopTrandingHomeView> createState() =>
      _UserTopTrandingHomeViewState();
}

class _UserTopTrandingHomeViewState extends State<UserTopTrandingHomeView> {
  final UserTopTrendingVideoController userTopTrendingVideoController =
      Get.put(UserTopTrendingVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userTopTrendingVideoController.isLoading.value) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              buildLazyloading(),
            ],
          ),
        );
      } else {
        if (userTopTrendingVideoController.videoList[0].data != null) {
          if (userTopTrendingVideoController.videoList[0].data!.isEmpty) {
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              scrollDirection: Axis.vertical,
              itemCount:
                  userTopTrendingVideoController.videoList[0].data!.length,
              itemBuilder: (context, index) {
                var discoverData =
                    userTopTrendingVideoController.videoList[0].data!;

                if (discoverData.isNotEmpty) {
                  var data = discoverData[index];
                  int minutes = (data.videoDurationInSeconds! / 60).floor();
                  int seconds = (data.videoDurationInSeconds! % 60).toInt();
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.videoDetailsPage);
                      videoDetailController.videoId(data.id);
                    },
                    child: SizedBox(
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
                                    child: Image.network(
                                      data.videoThumbnailImagePath.toString(),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        "assets/Opentrend_light_applogo.jpeg",
                                        fit: BoxFit.fill,
                                      ),
                                      fit: BoxFit.cover,
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
                                                data.title.toString(),
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
                                              "${data.numberOfViews} views",
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
                                  "$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}",
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
                                      userTopTrendingVideoController
                                          .videoList[0].data!.length
                                          .toString(),
                                      style: const TextStyle(
                                          color: kTextSecondaryColor,
                                          fontSize: 18,
                                          fontFamily: kFuturaPTDemi),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  color: kWhiteColor, fontSize: 15, fontFamily: kFuturaPTDemi),
            ),
          );
        }
      }
    });
  }

  buildLazyloading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: kButtonSecondaryColor,
              highlightColor: kShimmerEffectSecondary,
              enabled: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: [
                    buildcard(),
                    buildcard(),
                    buildcard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildcard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            height: 100,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 12.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
