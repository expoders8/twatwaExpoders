import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../routes/app_pages.dart';
import '../controller/video_detail_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../controller/getall_video_landing_controller.dart';

class TrandingHomeView extends StatefulWidget {
  const TrandingHomeView({super.key});

  @override
  State<TrandingHomeView> createState() => _TrandingHomeViewState();
}

class _TrandingHomeViewState extends State<TrandingHomeView> {
  final GetAllVideoLandingController videoController =
      Get.put(GetAllVideoLandingController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
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
          if (videoController.videoList[0].data!.trendingVideo!.isEmpty) {
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
              padding: const EdgeInsets.only(left: 15, right: 5),
              scrollDirection: Axis.horizontal,
              itemCount:
                  videoController.videoList[0].data!.trendingVideo!.length,
              itemBuilder: (context, index) {
                var discoverData =
                    videoController.videoList[0].data!.trendingVideo!;

                if (discoverData.isNotEmpty) {
                  var data = discoverData[index];
                  int minutes = (data['videoDurationInSeconds']! / 60).floor();
                  int seconds = (data['videoDurationInSeconds']! % 60).toInt();
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.videoDetailsPage);
                      videoDetailController.videoId(data['id']);
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
                                  data['videoThumbnailImagePath'].toString(),
                                  errorBuilder: (context, error, stackTrace) =>
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
                                      color: const Color.fromARGB(135, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(4)),
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 130,
                                child: Text(
                                  data['title'].toString(),
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
                                "${data['numberOfViews']} views",
                                style: const TextStyle(
                                    color: kTextsecondarybottomColor,
                                    fontSize: 12),
                              ),
                            ],
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
