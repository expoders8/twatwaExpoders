import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/video_controller.dart';
import '../routes/app_pages.dart';
import '../controller/comments_controller.dart';
import '../controller/video_detail_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../controller/getall_video_landing_controller.dart';

class CategoryVideoHomeView extends StatefulWidget {
  const CategoryVideoHomeView({super.key});

  @override
  State<CategoryVideoHomeView> createState() => _CategoryVideoHomeViewState();
}

class _CategoryVideoHomeViewState extends State<CategoryVideoHomeView> {
  final GetAllVideoLandingController videoController =
      Get.put(GetAllVideoLandingController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final CommentsController commentsController = Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (videoController.isLoading.value) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              buildLazyloading(),
            ],
          ),
        );
      } else {
        if (videoController.videoList[0].data != null) {
          if (videoController.videoList[0].data == null) {
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
            return SizedBox(
              height: Get.height + 50,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    videoController.videoList[0].data!.categories!.length,
                itemBuilder: (context, index) {
                  var discoverData =
                      videoController.videoList[0].data!.categories!;
                  // if (discoverData.isNotEmpty) {
                  var data = discoverData[index];
                  return SizedBox(
                    height: 210,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 19),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                                height: 17,
                                child: Image.asset(
                                  data.categoryName == "Education Videos"
                                      ? "assets/icons/education.png"
                                      : data.categoryName == "Premium Shows"
                                          ? "assets/icons/premiumShows.png"
                                          : data.categoryName == "Jobs Videos"
                                              ? "assets/icons/jobs.png"
                                              : data.categoryName ==
                                                      "Talent Videos"
                                                  ? "assets/icons/talent.png"
                                                  : "",
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                data.categoryName.toString(),
                                style: const TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontFamily: kFuturaPTDemi),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                var discoverData1 = data.videoList;
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: discoverData1!.length,
                                    itemBuilder: (context, index) {
                                      // if (discoverData.isNotEmpty) {
                                      var educationData = discoverData1[index];
                                      int minutes = (educationData
                                                  .videoDurationInSeconds! /
                                              60)
                                          .floor();
                                      int seconds = (educationData
                                                  .videoDurationInSeconds! %
                                              60)
                                          .toInt();
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.videoDetailsPage);
                                          videoDetailController.videoId(
                                              educationData.videoId.toString());
                                          upNextVideoController.updateString(
                                              educationData.categoryId
                                                  .toString());
                                          commentsController.updateString(
                                              educationData.videoId.toString());
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    height: 100,
                                                    child: Image.network(
                                                      educationData
                                                          .videoThumbnailImagePath
                                                          .toString(),
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        "assets/images/tranding1.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 10,
                                                    top: 7,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(
                                                              135, 0, 0, 0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Text(
                                                        "$minutes : $seconds",
                                                        style: const TextStyle(
                                                            color: kWhiteColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    width: 130,
                                                    child: Text(
                                                      educationData.title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              kTextsecondarytopColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "${educationData.numberOfViews.toString()} views",
                                                    style: const TextStyle(
                                                        color:
                                                            kTextsecondarybottomColor,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: Text(""),
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
