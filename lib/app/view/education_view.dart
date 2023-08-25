import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';
import '../controller/video_controller.dart';
import '../controller/video_detail_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';

// ignore: camel_case_types
class EducationViewPage extends StatefulWidget {
  const EducationViewPage({super.key});

  @override
  State<EducationViewPage> createState() => _EducationViewPageState();
}

// ignore: camel_case_types
class _EducationViewPageState extends State<EducationViewPage> {
  final EducationVideoController videoController =
      Get.put(EducationVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Center(
        child: Obx(
          () {
            if (videoController.isLoading.value) {
              return LoaderUtils.showLoader();
            } else {
              if (videoController.videoList.isNotEmpty) {
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
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    scrollDirection: Axis.vertical,
                    itemCount: videoController.videoList[0].data?.length,
                    itemBuilder: (context, index) {
                      var discoverData = videoController.videoList[0].data!;

                      if (discoverData.isNotEmpty) {
                        var data = discoverData[index];
                        int minutes = data.videoDurationInSeconds! ~/ 60;
                        int seconds = data.videoDurationInSeconds! % 60;
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.videoDetailsPage);
                            videoDetailController.videoId(data.id.toString());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      height: 200,
                                      child: Image.network(
                                        data.videoThumbnailImagePath.toString(),
                                        errorBuilder:
                                            (context, error, stackTrace) =>
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
                                            color: const Color.fromARGB(
                                                135, 0, 0, 0),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          "$minutes : $seconds",
                                          style: const TextStyle(
                                              color: kWhiteColor, fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 170,
                                            child: Text(
                                              data.title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: kTextsecondarytopColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "${data.numberOfViews.toString()} views",
                                            style: const TextStyle(
                                                color:
                                                    kTextsecondarybottomColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0, top: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  data.userName.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          kTextsecondarytopColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "7 Followers",
                                                style: TextStyle(
                                                  color:
                                                      kTextsecondarybottomColor,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          height: 37,
                                          width: 37,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/authBackground.png",
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
}
