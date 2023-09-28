import 'dart:convert';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../widgets/like_widget.dart';
import '../../routes/app_pages.dart';
import '../widgets/share_widget.dart';
import '../widgets/playlist_widget.dart';
import '../../view/tranding_home_view.dart';
import '../../view/descovery_home_view.dart';
import '../../view/following_home_view.dart';
import '../widgets/no_user_login_dialog.dart';
import '../../controller/video_controller.dart';
import '../../../config/constant/constant.dart';
import '../../view/category_video_home_view.dart';
import '../../controller/comments_controller.dart';
import '../OtherUserProfile/other_user_profile.dart';
import '../../controller/other_user_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/video_detail_controller.dart';
import '../../controller/getall_video_landing_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VideoOfTheDayController videoOfTheDayController =
      Get.put(VideoOfTheDayController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final OtherUserVideoController otherUserVideoController =
      Get.put(OtherUserVideoController());
  final OtherUserPlaylistController otherUserPlaylistController =
      Get.put(OtherUserPlaylistController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());
  final GetAllVideoLandingController videoController =
      Get.put(GetAllVideoLandingController());

  String authToken = "", userImage = "", likeValue = "", userId = "";
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    var token = box.read('authToken');

    if (data != null) {
      setState(() {
        authToken = token ?? "";
        userImage = getUserData['profilePhoto'] ?? "";
        userId = getUserData['id'] ?? "";
      });
    }
  }

  Future<void> _pullRefresh() async {
    videoOfTheDayController.fetchVideoOfTheDay();
    videoController.fetchAllLandingVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (videoOfTheDayController.isLoading.value) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.menuPage);
                      },
                      child: Row(
                        children: [
                          const Text(
                            "Discover",
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: 20.71,
                            width: 30.02,
                            child: Image.asset(
                              "assets/icons/dropdown.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.menuVideoListPage);
                          },
                          icon: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              "assets/icons/search.png",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            authToken == ""
                                ? Get.toNamed(Routes.loginPage)
                                : Get.toNamed(Routes.profilePage);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            height: 42,
                            width: 42,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: authToken == ""
                                  ? Image.asset(
                                      "assets/images/blank_profile.png",
                                      scale: 9,
                                    )
                                  : Image.network(
                                      userImage.toString(),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        "assets/images/blank_profile.png",
                                        fit: BoxFit.fill,
                                      ),
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                            child: CircularProgressIndicator(
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
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    buildLazyloading(),
                  ],
                ),
              )
            ],
          ),
        );
      } else {
        return RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              if (videoOfTheDayController.videoList.toList().isEmpty) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 310),
                    width: Get.width - 80,
                    child: const Text(
                      "Videos not Found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 15,
                          fontFamily: kFuturaPTDemi),
                    ),
                  ),
                );
              } else {
                var videoOfTheDayData = videoOfTheDayController.videoList[0];

                var followcheck = videoOfTheDayData.numberOfFollowers == 0
                    ? "Follwer"
                    : "Follwers";
                return Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          foregroundDecoration: const BoxDecoration(
                            color: kWhiteColor,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF121330),
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xFF121330)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0, 0, 1],
                            ),
                          ),
                          child: SizedBox(
                            height: 400,
                            width: Get.height,
                            child: Image.network(
                              videoOfTheDayData.videoThumbnailImagePath
                                  .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 400,
                            width: Get.height,
                            color: const Color(0xFF121330).withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.menuPage);
                                  },
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Discover",
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        height: 20.71,
                                        width: 30.02,
                                        child: Image.asset(
                                          "assets/icons/dropdown.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.menuVideoListPage);
                                      },
                                      icon: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/icons/search.png",
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        authToken == ""
                                            ? Get.toNamed(Routes.loginPage)
                                            : Get.toNamed(Routes.profilePage);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        height: 42,
                                        width: 42,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: authToken == ""
                                              ? Image.asset(
                                                  "assets/images/blank_profile.png",
                                                  scale: 9,
                                                )
                                              : Image.network(
                                                  userImage.toString(),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    "assets/images/blank_profile.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return SizedBox(
                                                      width: 20,
                                                      height: 20,
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
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 150),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Video of the day",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  videoOfTheDayData.title.toString(),
                                  style: const TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 22),
                                            width: 270,
                                            child: Text(
                                              videoOfTheDayData.description
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (videoOfTheDayData
                                                            .userId !=
                                                        userId) {
                                                      if (authToken == "") {
                                                        loginConfirmationDialog();
                                                      } else {
                                                        otherUserVideoController
                                                            .updateString(
                                                                videoOfTheDayData
                                                                    .userId
                                                                    .toString());
                                                        otherUserPlaylistController
                                                            .updateString(
                                                                videoOfTheDayData
                                                                    .userId
                                                                    .toString());
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                OtherUserProfilePage(
                                                              userId:
                                                                  videoOfTheDayData
                                                                      .userId
                                                                      .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    height: 42,
                                                    width: 42,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        videoOfTheDayData
                                                            .userProfileImage
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
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            videoOfTheDayData
                                                                .userName
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color:
                                                                    kTextsecondarytopColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                            "${videoOfTheDayData.numberOfFollowers} $followcheck",
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20, top: 9),
                                              child: Text(
                                                "${videoOfTheDayData.numberOfViews} Views",
                                                style: const TextStyle(
                                                    color:
                                                        kTextsecondarytopColor,
                                                    fontSize: 13,
                                                    fontFamily: kFuturaPTDemi),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: -20,
                                    top: -80,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.videoDetailsPage);
                                        videoDetailController.videoId(
                                            videoOfTheDayData.id.toString());
                                        upNextVideoController.updateString(
                                            videoOfTheDayData.categoryId
                                                .toString());
                                        commentsController.updateString(
                                            videoOfTheDayData.id.toString());
                                      },
                                      child: AvatarGlow(
                                        glowColor: kWhiteColor,
                                        endRadius: 90.0,
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        repeat: true,
                                        showTwoGlows: true,
                                        repeatPauseDuration:
                                            const Duration(milliseconds: 100),
                                        child: Material(
                                          // Replace this child with your own
                                          elevation: 8.0,
                                          shape: const CircleBorder(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 0.7,
                                                    color: kButtonColor)),
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              width: 45,
                                              height: 45,
                                              child: Image.asset(
                                                "assets/icons/Play.png",
                                                scale: 9,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 19),
                                child: Row(
                                  children: [
                                    LikeWidget(
                                      videoId: videoOfTheDayData.id,
                                      isLiked: videoOfTheDayData.isLiked!,
                                      likeCount:
                                          videoOfTheDayData.numberOfLikes,
                                      dislikeCount:
                                          videoOfTheDayData.numberOfDislikes,
                                      isdisLiked: videoOfTheDayData.isDisliked!,
                                      callbackDate: (val) {
                                        if (mounted) {
                                          setState(() {
                                            likeValue = val.toString();
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    ShareWidget(
                                        title:
                                            videoOfTheDayData.title.toString(),
                                        imageUrl: videoOfTheDayData
                                            .videoThumbnailImagePath
                                            .toString(),
                                        text: videoOfTheDayData.description
                                            .toString()),
                                    const SizedBox(width: 10),
                                    PlaylistWidget(
                                      videoId: videoOfTheDayData.id.toString(),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 19),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "assets/icons/searchDescover.png",
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          "DESCOVER",
                                          style: TextStyle(
                                              color: kTextsecondarytopColor,
                                              fontSize: 13,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    height: 180,
                                    child: DescoverHomeView(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 19),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "assets/icons/selectranding.png",
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          "Trending",
                                          style: TextStyle(
                                              color: kTextsecondarytopColor,
                                              fontSize: 13,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    height: 180,
                                    child: TrandingHomeView(),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 19),
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
                                        const Text(
                                          "Following",
                                          style: TextStyle(
                                              color: kTextsecondarytopColor,
                                              fontSize: 13,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    height: 180,
                                    child: FollowingHomeView(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const CategoryVideoHomeView(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ),
        );
      }
    }));
  }

  loginConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoUserLoginDialog();
      },
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
            SingleChildScrollView(
              child: Shimmer.fromColors(
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          buildcardEffect(),
                          buildcardEffect(),
                          buildcardEffect(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          buildcardEffect(),
                          buildcardEffect(),
                          buildcardEffect(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildcardEffect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            height: 70,
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

  buildcard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
            color: const Color(0xFF21203C),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: const TextStyle(
              color: kTextSecondaryColor,
              fontSize: 15,
              fontFamily: kFuturaPTDemi),
        ),
      ),
    );
  }
}
