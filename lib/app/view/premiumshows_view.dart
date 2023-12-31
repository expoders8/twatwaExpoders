import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';
import '../../config/constant/constant.dart';
import '../controller/video_controller.dart';
import '../controller/comments_controller.dart';
import '../controller/other_user_controller.dart';
import '../controller/video_detail_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../ui/OtherUserProfile/other_user_profile.dart';
import '../../config/animation/translate_up_animation.dart';

// ignore: camel_case_types
class PremiumShowsViewPage extends StatefulWidget {
  const PremiumShowsViewPage({super.key});

  @override
  State<PremiumShowsViewPage> createState() => _PremiumShowsViewPageState();
}

// ignore: camel_case_types
class _PremiumShowsViewPageState extends State<PremiumShowsViewPage> {
  final PremiumShowVideoController videoController =
      Get.put(PremiumShowVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final CommentsController commentsController = Get.put(CommentsController());
  final OtherUserVideoController otherUserVideoController =
      Get.put(OtherUserVideoController());
  final OtherUserPlaylistController otherUserPlaylistController =
      Get.put(OtherUserPlaylistController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());

  String userId = "", followtext = "FOLLOW";

  @override
  void initState() {
    getUser();
    super.initState();
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

  Future<void> _pullRefresh() async {
    videoController.fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Obx(
        () {
          if (videoController.isLoading.value) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  buildLazyloading(),
                  buildLazyloading(),
                  buildLazyloading(),
                ],
              ),
            );
          } else {
            if (videoController.videoList[0].data != null) {
              if (videoController.videoList[0].data!.isEmpty) {
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
                    SizedBox(
                      height: Platform.isAndroid
                          ? videoController.isAddingMore.value
                              ? Get.height - 230
                              : Get.height - 180
                          : videoController.isAddingMore.value
                              ? Get.height - 290
                              : Get.height - 220,
                      child: RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: TranslateUpAnimation(
                          child: ListView.builder(
                            controller: videoController.scrollController,
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                videoController.videoList[0].data!.length,
                            itemBuilder: (context, index) {
                              if (index == 0 &&
                                  videoController.isAddingMore.value) {
                                return SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      buildLazyloading(),
                                      buildLazyloading(),
                                      buildLazyloading(),
                                    ],
                                  ),
                                );
                              } else {
                                var discoverData =
                                    videoController.videoList[0].data!;

                                if (discoverData.isNotEmpty) {
                                  var data = discoverData[index];
                                  int minutes =
                                      (data.videoDurationInSeconds! / 60)
                                          .floor();
                                  int seconds =
                                      (data.videoDurationInSeconds! % 60)
                                          .toInt();
                                  var numberOffollowcheck =
                                      data.numberOfFollowers == 0
                                          ? "Follwer"
                                          : "Follwers";
                                  followtext = data.hasFollowers!
                                      ? "UNFOLLOW"
                                      : "FOLLOW";
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.videoDetailsPage);
                                          videoDetailController
                                              .videoId(data.id.toString());
                                          commentsController
                                              .updateString(data.id.toString());
                                          upNextVideoController.updateString(
                                              data.categoryId.toString());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: Get.width,
                                                height: size.width > 500
                                                    ? 350
                                                    : 200,
                                                child: Image.network(
                                                  data.videoThumbnailImagePath
                                                      .toString(),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    "assets/splash.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  loadingBuilder:
                                                      (BuildContext context,
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
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                right: 10,
                                                top: 7,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              135, 0, 0, 0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  padding: EdgeInsets.all(
                                                      size.width > 500
                                                          ? 10
                                                          : 4),
                                                  child: Text(
                                                    "$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}",
                                                    style: TextStyle(
                                                        color: kWhiteColor,
                                                        fontSize:
                                                            size.width > 500
                                                                ? 18
                                                                : 12),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 170,
                                                    child: Text(
                                                      data.title.toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              kTextsecondarytopColor,
                                                          fontSize:
                                                              size.width > 500
                                                                  ? 19
                                                                  : 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "${data.numberOfViews.toString()} views",
                                                    style: TextStyle(
                                                        color:
                                                            kTextsecondarybottomColor,
                                                        fontSize:
                                                            size.width > 500
                                                                ? 16
                                                                : 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0, top: 2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width > 500
                                                            ? 150
                                                            : 100,
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          data.userName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  kTextsecondarytopColor,
                                                              fontSize:
                                                                  size.width >
                                                                          500
                                                                      ? 16
                                                                      : 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "${data.numberOfFollowers} $numberOffollowcheck",
                                                        style: TextStyle(
                                                          color:
                                                              kTextsecondarybottomColor,
                                                          fontSize:
                                                              size.width > 500
                                                                  ? 15
                                                                  : 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width > 500
                                                        ? 10
                                                        : 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    userId == data.userId
                                                        ? Container()
                                                        : Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OtherUserProfilePage(
                                                                      userId: data
                                                                          .userId,
                                                                      followcheck:
                                                                          followtext),
                                                            ),
                                                          );
                                                    otherUserVideoController
                                                        .updateString(data
                                                            .userId
                                                            .toString());
                                                    otherUserPlaylistController
                                                        .updateString(data
                                                            .userId
                                                            .toString());
                                                  },
                                                  child: SizedBox(
                                                    height: size.width > 500
                                                        ? 41
                                                        : 37,
                                                    width: size.width > 500
                                                        ? 41
                                                        : 37,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        data.userProfileImage
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          "assets/images/blank_profile.png",
                                                          fit: BoxFit.fill,
                                                        ),
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return SingleChildScrollView(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            child: Column(
                                                              children: [
                                                                buildLazyloading(),
                                                                buildLazyloading(),
                                                                buildLazyloading(),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
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
                      ),
                    ),
                    if (videoController.isAddingMore.value)
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
    );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      height: 200,
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
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
