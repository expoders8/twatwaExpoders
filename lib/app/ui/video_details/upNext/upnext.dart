import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opentrend/app/ui/video_details/video_details.dart';

import '../../../controller/video_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_detail_controller.dart';

class UpNextPage extends StatefulWidget {
  final String categoryId;
  final String userId;
  final String videoId;
  const UpNextPage(
      {super.key,
      required this.categoryId,
      required this.userId,
      required this.videoId});

  @override
  State<UpNextPage> createState() => _UpNextPageState();
}

class _UpNextPageState extends State<UpNextPage> {
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  String userId = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upNextVideoController.fetchUpNextVideo(widget.categoryId, widget.userId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (upNextVideoController.isLoading.value) {
              return buildLazyloading();
            } else {
              if (upNextVideoController.videoList.isNotEmpty) {
                if (upNextVideoController.videoList[0].data!.isEmpty) {
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
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                    scrollDirection: Axis.vertical,
                    itemCount: upNextVideoController.videoList[0].data?.length,
                    itemBuilder: (context, index) {
                      var discoverData =
                          upNextVideoController.videoList[0].data!;
                      if (discoverData.isNotEmpty) {
                        var data = discoverData[index];
                        int minutes =
                            (data.videoDurationInSeconds! / 60).floor();
                        int seconds =
                            (data.videoDurationInSeconds! % 60).toInt();
                        return Column(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (widget.videoId != data.id) {
                                  videoDetailController
                                      .videoId(data.id.toString());
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => VideoDetailsPage(
                                          videoId: data.id,
                                          checkUpnext: "upnext"),
                                    ),
                                  );
                                }
                              },
                              child: SizedBox(
                                height: 90,
                                child: Card(
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "$minutes : $seconds",
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
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                        width: 0.7,
                                                        color: widget.videoId ==
                                                                data.id
                                                            ? const Color
                                                                    .fromARGB(
                                                                255,
                                                                244,
                                                                43,
                                                                29)
                                                            : kWhiteColor)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  width: 40,
                                                  height: 40,
                                                  child: Image.asset(
                                                    widget.videoId == data.id
                                                        ? "assets/icons/pause.png"
                                                        : "assets/icons/Play.png",
                                                    color: widget.videoId ==
                                                            data.id
                                                        ? Colors.red
                                                        : kWhiteColor,
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
                            ),
                          ],
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

  buildLazyloading() {
    return Padding(
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
    );
  }
}
