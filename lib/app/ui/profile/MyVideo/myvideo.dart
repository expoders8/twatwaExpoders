import 'dart:async';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';
import '../../../services/video_service.dart';
import '../../../controller/video_controller.dart';
import '../../../controller/comments_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_detail_controller.dart';

class MyVideoPage extends StatefulWidget {
  const MyVideoPage({super.key});

  @override
  State<MyVideoPage> createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  final MyVideoController myVideoController = Get.put(MyVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());
  VideoService videoService = VideoService();

  Timer? timer;
  // void _startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     myVideoController.fetchMyVideo();
  //   });
  // }

  Future<void> _pullRefresh() async {
    myVideoController.fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Obx(
          () {
            if (myVideoController.isLoading.value) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    buildLazyloading(),
                  ],
                ),
              );
            } else {
              if (myVideoController.videoList[0].data != null) {
                if (myVideoController.videoList[0].data!.isEmpty) {
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
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          itemCount:
                              myVideoController.videoList[0].data!.length,
                          itemBuilder: (context, index) {
                            if (index == 0 &&
                                myVideoController.isAddingMore.value) {
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
                                  myVideoController.videoList[0].data!;

                              if (discoverData.isNotEmpty) {
                                var data = discoverData[index];

                                return GestureDetector(
                                  onTap: () {
                                    if (data.videoUploadStatus == "Success") {
                                      Get.toNamed(Routes.videoDetailsPage);
                                      upNextVideoController.updateString(
                                          data.categoryId.toString());
                                      commentsController
                                          .updateString(data.id.toString());
                                      videoDetailController
                                          .videoId(data.id.toString());
                                    }
                                  },
                                  child: SizedBox(
                                    height: size.width > 500 ? 200 : 90,
                                    child: Stack(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          color: kCardColor,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 3),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      height: size.width > 500
                                                          ? 200
                                                          : 100,
                                                      width: size.width > 500
                                                          ? 250
                                                          : 100,
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
                                                          return SizedBox(
                                                            width: 17,
                                                            height: 17,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    kWhiteColor,
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
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 7),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    size.width >
                                                                            500
                                                                        ? 300
                                                                        : 135,
                                                                child: Text(
                                                                  data.title
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color:
                                                                          kTextsecondarytopColor,
                                                                      fontSize: size.width >
                                                                              500
                                                                          ? 16
                                                                          : 13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                "${data.numberOfViews} views",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kTextsecondarybottomColor,
                                                                  fontSize:
                                                                      size.width >
                                                                              500
                                                                          ? 15
                                                                          : 11,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                data.videoUploadStatus ==
                                                        "Uploading"
                                                    ? Container()
                                                    : data.videoUploadStatus ==
                                                            "Processing"
                                                        ? Container()
                                                        : data.videoUploadStatus ==
                                                                "Failed"
                                                            ? Container()
                                                            : Container()
                                                // GestureDetector(
                                                //     onTap:
                                                //         showTypeBottomSheet,
                                                //     child: Container(
                                                //       padding:
                                                //           const EdgeInsets
                                                //               .all(11),
                                                //       width: 40,
                                                //       height: 40,
                                                //       child:
                                                //           Image.asset(
                                                //         "assets/icons/eclips-vartical.png",
                                                //       ),
                                                //     ),
                                                //   )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: data.videoUploadStatus ==
                                                  "Uploading"
                                              ? videoUploding(data
                                                  .videoUploadStatus
                                                  .toString())
                                              : data.videoUploadStatus ==
                                                      "Processing"
                                                  ? videoUploding(data
                                                      .videoUploadStatus
                                                      .toString())
                                                  : data.videoUploadStatus ==
                                                          "Failed"
                                                      ? videoUploding(data
                                                          .videoUploadStatus
                                                          .toString())
                                                      : Container(),
                                        )
                                      ],
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
                      if (myVideoController.isAddingMore.value)
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

  videoUploding(String videoUploadStatus) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: size.width > 500 ? 200 : 90,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 87, 90, 176).withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 30, left: size.width > 500 ? Get.width - 150 : 245),
          child: Text(
            "$videoUploadStatus..",
            style: TextStyle(
                color: kButtonColor,
                fontSize: size.width > 500 ? 18 : 14,
                fontFamily: kFuturaPTMedium,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  showTypeBottomSheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: kAppBottomSheetColor,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 160,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 9),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: kTextsecondarytopColor, fontSize: 16),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 5),
                        child: Text(
                          "--------------------------------------------------",
                          style: TextStyle(
                              color: kButtonSecondaryColor,
                              fontSize: 10,
                              letterSpacing: 3),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: kTextsecondarytopColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildLazyloading() {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
