import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';
import '../../../services/playlist_service.dart';
import '../../../../config/constant/constant.dart';
import '../../../controller/playlist_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../controller/video_detail_controller.dart';

class MyPlaylistPage extends StatefulWidget {
  const MyPlaylistPage({super.key});

  @override
  State<MyPlaylistPage> createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  final PlaylistController playlistController = Get.put(PlaylistController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  PlaylistService playlistService = PlaylistService();
  String userId = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playlistController.fetchAllPlaylist();
      getUser();
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
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (playlistController.isLoading.value) {
                  return LoaderUtils.showLoader();
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
                        itemCount: playlistController.playList[0].data?.length,
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
                                SizedBox(
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
                                                fontFamily: kFuturaPTDemi),
                                          ),
                                        );
                                      } else {
                                        var data = discoverData![index];
                                        int minutes =
                                            data.videoDurationInSeconds! ~/ 60;
                                        int seconds =
                                            data.videoDurationInSeconds! % 60;
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.videoDetailsPage);
                                            videoDetailController
                                                .videoId(data.id.toString());
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      height: 100,
                                                      child: Image.network(
                                                        data.videoThumbnailImagePath
                                                            .toString(),
                                                        errorBuilder: (context,
                                                                error,
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
                                                            color: const Color
                                                                    .fromARGB(
                                                                135, 0, 0, 0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        child: Text(
                                                          "$minutes : $seconds",
                                                          style: const TextStyle(
                                                              color:
                                                                  kWhiteColor,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                        data.title.toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color:
                                                                kTextsecondarytopColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
        ],
      ),
    );
  }
}
