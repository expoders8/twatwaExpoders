import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/constant/constant.dart';
import '../controller/video_detail_controller.dart';
import '../models/video_model.dart';
import '../routes/app_pages.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../services/video_service.dart';
import '../ui/OtherUserProfile/other_user_profile.dart';

class EducationViewPage extends StatefulWidget {
  const EducationViewPage({super.key});

  @override
  State<EducationViewPage> createState() => _EducationViewPageState();
}

class _EducationViewPageState extends State<EducationViewPage> {
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  int skip = 1;
  final int limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  String userId = "";
  late Future<GetAllVideoModel> _future;
  VideoService videoService = VideoService();
  ScrollController _scrollController = ScrollController();
  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = null;
    getRequest.userName = "";
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = "e4a906a6-67c8-4ef4-bce3-975543ead8d3";
    getRequest.thumbnailId = null;
    getRequest.categoryName = "";
    getRequest.playlistId = null;
    getRequest.videoReferenceId = "";
    getRequest.videoEncoderReference = "";
    getRequest.visibleStatus = "";
    getRequest.videoUploadStatus = "";
    getRequest.requestType = "";
    getRequest.hashTag = "";
    getRequest.pageNumber = skip;
    getRequest.pageSize = limit;
    getRequest.searchText = "";
    getRequest.sortBy = "";
    return getRequest;
  }

  getitem() {
    if (mounted) {
      setState(() {
        _isFirstLoadRunning = true;
      });
      _future = videoService.getAllVideo(createRequest());
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
  }

  loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLoadMoreRunning = true;
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              buildLazyloading(),
            ],
          ),
        );
      });
      skip = skip + 1;
      var fetchedPosts = await videoService.getAllVideo(createRequest());

      try {
        if (fetchedPosts.data!.isNotEmpty) {
          setState(() {
            _future.then((value) => value.data!.addAll(fetchedPosts.data!));
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        debugPrint('Something went wrong!');
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future<void> _pullRefresh() async {
    videoService.getAllVideo(createRequest());
  }

  @override
  void initState() {
    getUser();
    getitem();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          loadMore();
        });
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
  void dispose() {
    if (mounted) {
      _scrollController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: _isFirstLoadRunning
          ? SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  buildLazyloading(),
                  buildLazyloading(),
                  buildLazyloading(),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: FutureBuilder<GetAllVideoModel>(
                    future: _future,
                    builder:
                        (context, AsyncSnapshot<GetAllVideoModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          var itemData = snapshot.data!.data;
                          if (itemData!.isEmpty) {
                            return const Center(
                              child: Text(
                                'Video Not Found',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                    fontFamily: kFuturaPTDemi),
                              ),
                            );
                          } else {
                            return RefreshIndicator(
                              onRefresh: _pullRefresh,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                scrollDirection: Axis.vertical,
                                controller: _scrollController,
                                itemCount: itemData.length,
                                itemBuilder: (context, index) {
                                  var discoverData = itemData;

                                  if (discoverData.isNotEmpty) {
                                    var data = discoverData[index];
                                    int minutes =
                                        (data.videoDurationInSeconds! / 60)
                                            .floor();
                                    int seconds =
                                        (data.videoDurationInSeconds! % 60)
                                            .toInt();
                                    var followcheck =
                                        data.numberOfFollowers == 0
                                            ? "Follwer"
                                            : "Follwers";
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.videoDetailsPage);
                                            videoDetailController
                                                .videoId(data.id.toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: Get.width,
                                                  height: 200,
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
                                                                .circular(4)),
                                                    padding:
                                                        const EdgeInsets.all(4),
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 170,
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
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0.0, top: 2),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            data.userName
                                                                .toString(),
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
                                                            height: 5),
                                                        Text(
                                                          "${data.numberOfFollowers} $followcheck",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                kTextsecondarybottomColor,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      userId == data.userId
                                                          ? Container()
                                                          : Navigator.of(
                                                                  context)
                                                              .push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OtherUserProfilePage(
                                                                        userId: data
                                                                            .userId,
                                                                        followcheck:
                                                                            ""),
                                                              ),
                                                            );
                                                    },
                                                    child: SizedBox(
                                                      height: 37,
                                                      width: 37,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          data.userProfileImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            "assets/images/blank_profile.png",
                                                            fit: BoxFit.fill,
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
                                                            return SingleChildScrollView(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              child: Column(
                                                                children: [
                                                                  buildLazyloading(),
                                                                  buildLazyloading(),
                                                                  buildLazyloading(),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
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
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: Text(
                              'video not Found',
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 15,
                                  fontFamily: kFuturaPTDemi),
                            ),
                          );
                        }
                      } else {
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
                      }
                    },
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  SizedBox(
                    height: 80,
                    width: Get.width,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: buildLazyloading(),
                    ),
                  )
              ],
            ),
    );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      height: 200,
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
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
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
