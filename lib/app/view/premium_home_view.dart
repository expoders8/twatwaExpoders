import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';
import '../../config/constant/font_constant.dart';
import '../../config/provider/loader_provider.dart';
import '../controller/video_detail_controller.dart';
import '../../../../config/constant/color_constant.dart';
import '../controller/getall_video_landing_controller.dart';

class PremiumHomeView extends StatefulWidget {
  const PremiumHomeView({super.key});

  @override
  State<PremiumHomeView> createState() => _PremiumHomeViewState();
}

class _PremiumHomeViewState extends State<PremiumHomeView> {
  final GetAllVideoLandingController videoController =
      Get.put(GetAllVideoLandingController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      videoController.fetchAllLandingVideos();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (videoController.isLoading.value) {
        return LoaderUtils.showLoader();
      } else {
        if (videoController.videoList.isNotEmpty) {
          if (videoController.videoList[0].data!.categories!.isEmpty) {
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
              height: 240,
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
                    height: 240,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var discoverData1 = data.videoList;
                        return SizedBox(
                          height: 240,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: discoverData1!.length,
                            itemBuilder: (context, index) {
                              // if (discoverData.isNotEmpty) {
                              var educationData = discoverData1[index];
                              int minutes =
                                  (data.videoDurationInSeconds! / 60).floor();
                              int seconds =
                                  (data.videoDurationInSeconds! % 60).toInt();
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.videoDetailsPage);
                                  videoDetailController.videoId(
                                      educationData.videoId.toString());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 100,
                                            child: Image.network(
                                              educationData
                                                  .videoThumbnailImagePath
                                                  .toString(),
                                              errorBuilder: (context, error,
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
                                                  color: const Color.fromARGB(
                                                      135, 0, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              padding: const EdgeInsets.all(4),
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 130,
                                            child: Text(
                                              educationData.title.toString(),
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
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: Text("No category found",
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 15,
                    fontFamily: kFuturaPTDemi)),
          );
        }
      }
    });
  }
}
