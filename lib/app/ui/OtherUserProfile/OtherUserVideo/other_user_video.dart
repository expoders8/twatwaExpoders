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

class OtherUserVideoPage extends StatefulWidget {
  final String? userId;
  const OtherUserVideoPage({super.key, this.userId});

  @override
  State<OtherUserVideoPage> createState() => _OtherUserVideoPageState();
}

class _OtherUserVideoPageState extends State<OtherUserVideoPage> {
  final MyVideoController myVideoController = Get.put(MyVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  String userId = "";
  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
      myVideoController.fetchMyVideo(widget.userId.toString(), "otherUser");
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Get.toNamed(Routes.videoDetailsPage);
                            videoDetailController.videoId(data.id.toString());
                          },
                          child: SizedBox(
                            height: 90,
                            child: Card(
                              color: kCardColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 5),
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
                                            errorBuilder:
                                                (context, error, stackTrace) =>
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                      margin: const EdgeInsets.only(
                                          right: 5, top: 9),
                                      child: Text(
                                        data.videoDurationInSeconds.toString(),
                                        style: const TextStyle(
                                            color: kButtonSecondaryColor,
                                            fontSize: 11,
                                            fontFamily: kFuturaPTDemi),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                width: 0.7,
                                                color: kWhiteColor)),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          width: 34,
                                          height: 34,
                                          child: Image.asset(
                                            "assets/icons/Play.png",
                                            scale: 9,
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
                            "No Video found",
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
                    "No Video found",
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
      // body: ListView.builder(
      //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      //   scrollDirection: Axis.vertical,
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     return SizedBox(
      //         height: 90,
      //         child: Card(
      //           color: kCardColor,
      //           child: Padding(
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Container(
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(4)),
      //                       height: 100,
      //                       width: 100,
      //                       child: Image.asset(
      //                         "assets/images/imagebg.png",
      //                       ),
      //                     ),
      //                     Row(
      //                       children: [
      //                         Padding(
      //                           padding:
      //                               const EdgeInsets.only(left: 8.0, top: 7),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: const [
      //                               SizedBox(
      //                                 width: 135,
      //                                 child: Text(
      //                                   "We Don’t Talk Anymore feat. Selena Gomez",
      //                                   maxLines: 2,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   style: TextStyle(
      //                                       color: kTextsecondarytopColor,
      //                                       fontSize: 13,
      //                                       fontWeight: FontWeight.w500),
      //                                 ),
      //                               ),
      //                               SizedBox(height: 10),
      //                               Text(
      //                                 "681,298 views",
      //                                 style: TextStyle(
      //                                   color: kTextsecondarybottomColor,
      //                                   fontSize: 11,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 Container(
      //                   margin: const EdgeInsets.only(right: 5, top: 9),
      //                   child: const Text(
      //                     "3:43",
      //                     style: TextStyle(
      //                         color: kButtonSecondaryColor,
      //                         fontSize: 11,
      //                         fontFamily: kFuturaPTDemi),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 5.0),
      //                   child: Container(
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(30),
      //                         border:
      //                             Border.all(width: 0.7, color: kWhiteColor)),
      //                     child: Container(
      //                       padding: const EdgeInsets.all(12),
      //                       width: 34,
      //                       height: 34,
      //                       child: Image.asset(
      //                         "assets/icons/Play.png",
      //                         scale: 9,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ));
      //   },
      // ),
    );
  }
}
