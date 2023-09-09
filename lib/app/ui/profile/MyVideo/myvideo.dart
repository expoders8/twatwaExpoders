import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/video_model.dart';
import '../../../routes/app_pages.dart';
import '../../../../config/constant/constant.dart';
import '../../../controller/video_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../controller/video_detail_controller.dart';
import '../../../services/video_service.dart';

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

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
  int skip = 1;
  final int limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late Future<GetAllVideoModel> _future;
  VideoService videoService = VideoService();
  ScrollController _scrollController = ScrollController();

  createRequest() {
    VideoRequestModel getRequest = VideoRequestModel();
    getRequest.videoId = null;
    getRequest.userId = userId;
    getRequest.userName = "";
    getRequest.videoType = "";
    getRequest.currentUserId = null;
    getRequest.categoryId = null;
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
                children: [buildLazyloading()],
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
                            return ListView.builder(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              itemCount: itemData.length,
                              itemBuilder: (context, index) {
                                var discoverData = itemData;

                                if (discoverData.isNotEmpty) {
                                  var data = discoverData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (data.videoUploadStatus == "Success") {
                                        Get.toNamed(Routes.videoDetailsPage);
                                        videoDetailController
                                            .videoId(data.id.toString());
                                      }
                                    },
                                    child: SizedBox(
                                      height: 90,
                                      child: Stack(
                                        children: [
                                          Card(
                                            color: kCardColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        height: 100,
                                                        width: 100,
                                                        child: Image.network(
                                                          data.videoThumbnailImagePath
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            "assets/Opentrend_light_applogo.jpeg",
                                                            fit: BoxFit.contain,
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
                                                            return SizedBox(
                                                              width: 17,
                                                              height: 17,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      kWhiteColor,
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
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    top: 7),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 135,
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
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  "${data.numberOfViews} views",
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        kTextsecondarybottomColor,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  data.videoUploadStatus ==
                                                          "Uploading"
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
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            11),
                                                                    width: 40,
                                                                    height: 40,
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/icons/eclips-vartical.png",
                                                                    ),
                                                                  ),
                                                                )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: data.videoUploadStatus ==
                                                    "Uploading"
                                                ? videoUploding(data
                                                    .videoUploadStatus
                                                    .toString())
                                                : data.videoUploadStatus ==
                                                        "Processing"
                                                    ? videoUploding(data
                                                        .videoUploadStatus
                                                        .toString())
                                                    : data.videoUploadStatus ==
                                                            "Failed"
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
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  SizedBox(
                      height: 50,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            buildLazyloading(),
                          ],
                        ),
                      ))
              ],
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
          color: const Color.fromARGB(255, 87, 90, 176).withOpacity(0.3),
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

  buildLazyloading() {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
                    padding: const EdgeInsets.only(top: 10),
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
      ),
    );
  }
}
