import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/video_controller.dart';
import '../ui/video_details/video_details.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';

class TrandingHomeView extends StatefulWidget {
  const TrandingHomeView({super.key});

  @override
  State<TrandingHomeView> createState() => _TrandingHomeViewState();
}

class _TrandingHomeViewState extends State<TrandingHomeView> {
  final TrendingVideoController videoController =
      Get.put(TrendingVideoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
              padding: const EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemCount: videoController.videoList[0].data?.length,
              itemBuilder: (context, index) {
                var discoverData = videoController.videoList[0].data!;

                if (discoverData.isNotEmpty) {
                  var data = discoverData[index];
                  int minutes = data.videoDurationInSeconds! ~/ 60;
                  int seconds = data.videoDurationInSeconds! % 60;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoDetailsPage(videoId: data.id.toString()),
                        ),
                      );
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
                                  data.videoThumbnailImagePath.toString(),
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
                    child: Text("No category found"),
                  );
                }
              },
            );
          }
        } else {
          return const Center(
            child: Text("No category found"),
          );
        }
      }
    });
  }
}
