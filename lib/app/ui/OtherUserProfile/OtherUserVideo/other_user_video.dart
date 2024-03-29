import 'dart:async';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';
import '../../../controller/video_controller.dart';
import '../../../controller/comments_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../controller/other_user_controller.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_detail_controller.dart';

class OtherUserVideoPage extends StatefulWidget {
  final String? userId;
  const OtherUserVideoPage({super.key, this.userId});

  @override
  State<OtherUserVideoPage> createState() => _OtherUserVideoPageState();
}

class _OtherUserVideoPageState extends State<OtherUserVideoPage> {
  final OtherUserVideoController otherUserVideoController =
      Get.put(OtherUserVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (otherUserVideoController.isLoading.value) {
              return buildLazyloading();
            } else {
              if (otherUserVideoController.videoList[0].data != null) {
                if (otherUserVideoController.videoList[0].data!.isEmpty) {
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
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                          itemCount: otherUserVideoController
                              .videoList[0].data!.length,
                          itemBuilder: (context, index) {
                            if (index == 0 &&
                                otherUserVideoController.isAddingMore.value) {
                              return buildLazyloading();
                            } else {
                              var discoverData =
                                  otherUserVideoController.videoList[0].data!;

                              if (discoverData.isNotEmpty) {
                                var data = discoverData[index];
                                int minutes =
                                    (data.videoDurationInSeconds! / 60).floor();
                                int seconds =
                                    (data.videoDurationInSeconds! % 60).toInt();
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.videoDetailsPage);
                                    upNextVideoController.updateString(
                                        data.categoryId.toString());
                                    commentsController
                                        .updateString(data.id.toString());
                                    videoDetailController
                                        .videoId(data.id.toString());
                                  },
                                  child: SizedBox(
                                    height: 90,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      color: kCardColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                    data.videoThumbnailImagePath
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      "assets/Opentrend_light_applogo.jpeg",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return SizedBox(
                                                        width: 17,
                                                        height: 17,
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 135,
                                                        child: Text(
                                                          data.title.toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color:
                                                                  kTextsecondarytopColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Text(
                                                      "$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}",
                                                      style: const TextStyle(
                                                          color:
                                                              kButtonSecondaryColor,
                                                          fontSize: 11,
                                                          fontFamily:
                                                              kFuturaPTDemi),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                            width: 0.7,
                                                            color:
                                                                kWhiteColor)),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.asset(
                                                        "assets/icons/Play.png",
                                                        color: kWhiteColor,
                                                        scale: 9,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                            }
                          },
                        ),
                      ),
                      if (otherUserVideoController.isAddingMore.value)
                        const Center(
                          child: CircularProgressIndicator(
                            color: kShimmerEffectSecondary,
                          ),
                        )
                    ],
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
          },
        ),
      ),
    );
  }

  buildLazyloading() {
    return SizedBox(
      height: Get.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 0),
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
                    itemCount: 6,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
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
