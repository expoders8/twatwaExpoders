import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/comments_controller.dart';
import '../../../controller/video_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/playlist_service.dart';
import '../../../controller/playlist_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_detail_controller.dart';

class MyPlaylistPage extends StatefulWidget {
  final String? userId;
  final String? checkText;
  const MyPlaylistPage({super.key, this.userId, this.checkText});

  @override
  State<MyPlaylistPage> createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  final PlaylistController playlistController = Get.put(PlaylistController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());
  PlaylistService playlistService = PlaylistService();

  Future<void> _pullRefresh() async {
    playlistController.fetchAllPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Obx(
                () {
                  if (playlistController.isLoading.value) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          buildLazyloading(),
                          buildLazyloading(),
                        ],
                      ),
                    );
                  } else {
                    if (playlistController.playList.isNotEmpty) {
                      if (playlistController.playList[0].data!.isEmpty) {
                        return Center(
                          child: SizedBox(
                            width: Get.width - 80,
                            child: const Text(
                              "Playlist not Found",
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
                          itemCount:
                              playlistController.playList[0].data?.length,
                          itemBuilder: (context, index) {
                            var playlistData =
                                playlistController.playList[0].data!;

                            if (playlistData.isNotEmpty) {
                              var data = playlistData[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6, top: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "assets/icons/following.png",
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          data.playlistName.toString(),
                                          style: const TextStyle(
                                              color: kTextsecondarytopColor,
                                              fontSize: 14,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  data.videos!.isEmpty
                                      ? Center(
                                          child: SizedBox(
                                            width: Get.width - 80,
                                            height: 130,
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 50.0, right: 15),
                                              child: Text(
                                                "Video not Found",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: kWhiteColor,
                                                    fontSize: 15,
                                                    fontFamily: kFuturaPTDemi),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 170,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.videos!.length,
                                            itemBuilder: (context, index) {
                                              var discoverData = data.videos;

                                              if (data.videos == []) {
                                                return const Center(
                                                  child: Text(
                                                    "No Video found",
                                                    style: TextStyle(
                                                        color: kWhiteColor,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            kFuturaPTDemi),
                                                  ),
                                                );
                                              } else {
                                                var data = discoverData![index];
                                                int minutes =
                                                    (data.videoDurationInSeconds! /
                                                            60)
                                                        .floor();
                                                int seconds =
                                                    (data.videoDurationInSeconds! %
                                                            60)
                                                        .toInt();
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(Routes
                                                        .videoDetailsPage);
                                                    upNextVideoController
                                                        .updateString(data
                                                            .categoryId
                                                            .toString());
                                                    commentsController
                                                        .updateString(
                                                            data.id.toString());
                                                    videoDetailController
                                                        .videoId(
                                                            data.id.toString());
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Stack(
                                                          children: [
                                                            SizedBox(
                                                              width: 150,
                                                              height: 100,
                                                              child:
                                                                  Image.network(
                                                                data.videoThumbnailImagePath
                                                                    .toString(),
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  "assets/Opentrend_light_applogo.jpeg",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 10,
                                                              top: 7,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        135,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                child: Text(
                                                                  "$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}",
                                                                  style: const TextStyle(
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 10),
                                                            SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                data.title
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color:
                                                                        kTextsecondarytopColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
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
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        )
                                ],
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
                          "No Playlist found",
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
        ],
      ),
    );
  }

  buildLazyloading() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                      width: Get.width - 150,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150.0,
                          height: 100.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 150.0,
                          height: 100.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width - 100,
                      height: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width - 130,
                      height: 15.0,
                      color: Colors.white,
                    ),
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
