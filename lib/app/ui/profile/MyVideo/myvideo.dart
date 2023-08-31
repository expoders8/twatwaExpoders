import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/constant/color_constant.dart';
import '../../../../config/constant/constant.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../controller/video_controller.dart';
import '../../../controller/video_detail_controller.dart';
import '../../../routes/app_pages.dart';

class MyVideoPage extends StatefulWidget {
  const MyVideoPage({super.key});

  @override
  State<MyVideoPage> createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  final MyVideoController myVideoController = Get.put(MyVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  String userId = "";
  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
      myVideoController.fetchMyVideo("", "");
      // _startTimer();
    });

    super.initState();
  }

  // void _startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     myVideoController.fetchMyVideo();
  //   });
  // }

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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Center(
        child: Obx(
          () {
            if (myVideoController.isLoading.value) {
              return LoaderUtils.showLoader();
            } else {
              if (myVideoController.videoList.isNotEmpty) {
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
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    scrollDirection: Axis.vertical,
                    itemCount: myVideoController.videoList[0].data?.length,
                    itemBuilder: (context, index) {
                      var discoverData = myVideoController.videoList[0].data!;

                      if (discoverData.isNotEmpty) {
                        var data = discoverData[index];
                        return GestureDetector(
                          onTap: () {
                            if (data.videoUploadStatus == "Uploaded") {
                              Get.toNamed(Routes.videoDetailsPage);
                              videoDetailController.videoId(data.id.toString());
                            }
                          },
                          child: SizedBox(
                            height: 90,
                            child: Stack(
                              children: [
                                Card(
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
                                                      BorderRadius.circular(4)),
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                data.videoThumbnailImagePath
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  "assets/Opentrend_light_applogo.jpeg",
                                                  fit: BoxFit.contain,
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
                                            Row(
                                              children: [
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
                                          ],
                                        ),
                                        data.videoUploadStatus == "Uploading"
                                            ? Container()
                                            : data.videoUploadStatus ==
                                                    "Processing"
                                                ? Container()
                                                : data.videoUploadStatus ==
                                                        "Failed"
                                                    ? Container()
                                                    : GestureDetector(
                                                        onTap:
                                                            showTypeBottomSheet,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(11),
                                                          width: 40,
                                                          height: 40,
                                                          child: Image.asset(
                                                            "assets/icons/eclips-vartical.png",
                                                          ),
                                                        ),
                                                      )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: data.videoUploadStatus == "Uploading"
                                      ? videoUploding(
                                          data.videoUploadStatus.toString())
                                      : data.videoUploadStatus == "Processing"
                                          ? videoUploding(
                                              data.videoUploadStatus.toString())
                                          : data.videoUploadStatus == "Failed"
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
                          child: Text("No Video found"),
                        );
                      }
                    },
                  );
                }
              } else {
                return const Center(
                  child: Text("No Video found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  videoUploding(String videoUploadStatus) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 90,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white.withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 245),
          child: Text(
            "$videoUploadStatus..",
            style: const TextStyle(
                color: kButtonColor,
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
}
