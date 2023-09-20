import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/other_user_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/like_widget.dart';
import '../widgets/share_widget.dart';
import '../widgets/playlist_widget.dart';
import '../../services/video_service.dart';
import '../video_details/about/about.dart';
import '../video_details/video_player.dart';
import '../video_details/upNext/upnext.dart';
import '../../services/follower_service.dart';
import '../widgets/no_user_login_dialog.dart';
import '../../../config/constant/constant.dart';
import '../video_details/comments/comments.dart';
import '../OtherUserProfile/other_user_profile.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/video_detail_controller.dart';
import '../../../config/provider/dotted_line_provider.dart';

class VideoDetailsPage extends StatefulWidget {
  final String? videoId;
  final String? checkUpnext;
  const VideoDetailsPage({super.key, this.videoId, this.checkUpnext});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final OtherUserVideoController otherUserVideoController =
      Get.put(OtherUserVideoController());
  final OtherUserPlaylistController otherUserPlaylistController =
      Get.put(OtherUserPlaylistController());

  FollowerService followerService = FollowerService();
  int tabindex = 0, dishblevalue = 0, selectvideoQualityIndex = 6;
  String qualityname = "",
      followtext = "FOLLOW",
      likeValue = "",
      url = "",
      currntuserId = "",
      authToken = "";

  VideoService videoService = VideoService();

  bool isChecked = false, showOverlay = true, click = false, onetime = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // var videoId = videoDetailController.videoId();
      // videoService.videoView(videoId);
      box.remove('videobuttonStates');
      getUser();
      videoDetailController.fetchStoryDetail(
          widget.videoId.toString(), currntuserId);
    });
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    var authTokenValue = box.read('authToken');
    if (data != null) {
      setState(() {
        currntuserId = getUserData['id'] ?? "";
        authToken = authTokenValue ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        videoDetailController.videoId("");
        Navigator.of(context).pop();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return Future.value(false);
      },
      child: Obx(() {
        if (videoDetailController.isLoading.value) {
          return Scaffold(
              body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                buildLazyloading(),
              ],
            ),
          ));
        } else {
          var data = videoDetailController.detailModel;
          var detailData = data!.data;
          if (onetime) {
            followtext = detailData!.hasFollowers! ? "UNFOLLOW" : "FOLLOW";
          }
          String formattedDate = DateFormat('yyyy-MMMM-dd')
              .format(DateTime.parse(detailData!.createdOn.toString()));
          final splittedDate = formattedDate.split("-");
          final splityear = splittedDate[0];
          final splitmonth = splittedDate[1];
          final splitday = splittedDate[2];
          return Scaffold(
            backgroundColor: kBackGroundColor,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: [
                  VideoPlayerScreen(
                    videoid: detailData.id.toString(),
                    videoUrl: detailData.videoStreamingUrl.toString(),
                    videoQualityDatas: detailData.qualityJson.toString(),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Get.height,
                      child: NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxScrolled) {
                          return <Widget>[
                            createSilverAppBar1(
                              detailData.title.toString(),
                              detailData.userName,
                              detailData.numberOfViews,
                              detailData.numberOfLikes,
                              detailData.numberOfDislikes,
                              splitday,
                              splitmonth,
                              splityear,
                              detailData.id,
                              detailData.isLiked,
                              detailData.isDisliked,
                              detailData.userProfileImage ?? "",
                              detailData.numberOfFollowers,
                              detailData.userId,
                            ),
                          ];
                        },
                        body: Container(
                          color: kBackGroundColor,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  buildTabindex("UP NEXT VIDEOS", 0, 110),
                                  buildTabindex("ABOUT", 1, 90),
                                  buildTabindex("COMMENTS", 2, 90)
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: SizedBox(
                                  height: Get.height,
                                  child: tabindex == 0
                                      ? UpNextPage(
                                          categoryId:
                                              detailData.categoryId.toString(),
                                          userId: detailData.userId.toString(),
                                          videoId: detailData.id.toString())
                                      : tabindex == 1
                                          ? AboutPage(
                                              description:
                                                  detailData.description)
                                          : CommentsPage(
                                              videoId: detailData.id.toString(),
                                            ),
                                ),
                              ),
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
      }),
    );
  }

  SliverAppBar createSilverAppBar1(
    String title,
    username,
    numberOfViews,
    islikeValue,
    isdislikeValue,
    day,
    month,
    year,
    id,
    isLiked,
    isDisliked,
    userImage,
    numberOfFollwers,
    userId,
  ) {
    var followcheck = numberOfFollwers == 0 ? "Follwer" : "Follwers";
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 170 : 145,
      floating: false,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Scaffold(
              body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 210,
                                    child: Text(
                                      title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: kTextsecondarytopColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${day}th, $month $year",
                                    style: const TextStyle(
                                      color: kTextsecondarybottomColor,
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
                      margin: const EdgeInsets.only(right: 20, top: 11),
                      child: Text(
                        "$numberOfViews Views",
                        style: const TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 13,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Row(
                  children: [
                    LikeWidget(
                      videoId: id,
                      isLiked: isLiked,
                      likeCount: islikeValue,
                      dislikeCount: isdislikeValue,
                      isdisLiked: isDisliked,
                      callbackDate: (val) {
                        if (mounted) {
                          setState(() {
                            likeValue = val.toString();
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    const ShareWidget(title: "", imageUrl: "", text: ""),
                    const SizedBox(width: 10),
                    PlaylistWidget(
                      videoId: id,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: Get.width - 25,
                height: 1,
                child: CustomPaint(
                  painter: DottedLinePainter(),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (authToken != "") {
                              if (currntuserId == userId) {
                                Container();
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OtherUserProfilePage(
                                        userId: userId,
                                        followcheck: followtext),
                                  ),
                                );
                                otherUserVideoController.updateString(userId);
                                otherUserPlaylistController
                                    .updateString(userId);
                              }
                            } else {
                              loginConfirmationDialog();
                            }
                          },
                          child: SizedBox(
                            height: 42,
                            width: 42,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                userImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
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
                                    width: 17,
                                    height: 17,
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
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    username,
                                    style: const TextStyle(
                                        color: kTextsecondarytopColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "$numberOfFollwers $followcheck",
                                    style: const TextStyle(
                                      color: kTextsecondarybottomColor,
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
                    currntuserId == userId
                        ? Container()
                        : authToken != ""
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      authToken != ""
                                          ? Get.toNamed(
                                              Routes.checkOutPaymentPage)
                                          : loginConfirmationDialog();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 6,
                                          left: 6),
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xD212D2D9),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      // width: 150,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'DONATE',
                                            style: TextStyle(
                                                color: Color(0xD212D2D9),
                                                letterSpacing: 1.5,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (authToken != "") {
                                        followerService
                                            .followAndUnfollow(userId)
                                            .then((value) => {
                                                  if (value['success'])
                                                    {
                                                      if (followtext ==
                                                          "FOLLOW")
                                                        {
                                                          setState(() {
                                                            onetime = false;
                                                            followtext =
                                                                "UNFOLLOW";
                                                          })
                                                        }
                                                      else
                                                        {
                                                          if (followtext ==
                                                              "UNFOLLOW")
                                                            {
                                                              setState(() {
                                                                onetime = false;
                                                                followtext =
                                                                    "FOLLOW";
                                                              })
                                                            }
                                                        }
                                                    }
                                                });
                                      } else {
                                        loginConfirmationDialog();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 6,
                                          left: 6),
                                      margin: const EdgeInsets.only(right: 24),
                                      decoration: BoxDecoration(
                                          color: followtext == "FOLLOW"
                                              ? kButtonColor
                                              : kBackGroundColor,
                                          border: Border.all(
                                              width: 1,
                                              color: followtext == "FOLLOW"
                                                  ? kButtonColor
                                                  : kButtonSecondaryColor),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Text(
                                        followtext,
                                        style: const TextStyle(
                                            color: kWhiteColor,
                                            letterSpacing: 1.5,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                  ],
                ),
              ),
            ],
          )),
        );
      }),
    );
  }

  buildTabindex(String text, int index, double size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabindex = index;
        });
      },
      child: Container(
        width: size,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: tabindex == index ? kButtonColor : kBackGroundColor,
                width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Center(
              child: DefaultTextStyle(
            style: TextStyle(
                color: tabindex == index ? kButtonColor : kWhiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w300),
            child: Text(text),
          )),
        ),
      ),
    );
  }

  loginConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoUserLoginDialog();
      },
    );
  }
}

buildLazyloading() {
  return SizedBox(
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
              const SizedBox(height: 20),
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
                          width: 155,
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 155,
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
                          width: 155,
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 155,
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 70,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 70,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 40,
                      width: 75,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 40,
                      width: 75,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 10.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 10.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              buildLazyloadingbottom()
            ],
          ),
        ),
      ],
    ),
  );
}

buildLazyloadingbottom() {
  return SizedBox(
    height: 400,
    child: Padding(
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
                  physics: const NeverScrollableScrollPhysics(),
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
