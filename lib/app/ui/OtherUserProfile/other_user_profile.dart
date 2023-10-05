import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controller/other_user_controller.dart';
import '../../services/follower_service.dart';
import '../../services/video_service.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/snackbar_provider.dart';
import '../OtherUserProfile/OtherUserVideo/other_user_video.dart';
import '../OtherUserProfile/OtherUserPlaylist/other_user_playlist.dart';
import '../OtherUserProfile/OtherUserFollower/other_user_follower.dart';
import '../OtherUserProfile/OtherUserFollowing/other_user_following.dart';

class OtherUserProfilePage extends StatefulWidget {
  final String? userId;
  final String? followcheck;
  const OtherUserProfilePage({super.key, this.userId, this.followcheck});

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  int tabindex = 0,
      usertotalViews = 0,
      usertotalVideos = 0,
      usertotalFollowings = 0,
      usertotalFollowers = 0;
  String followButton = "follow",
      userImage = "",
      userName = "",
      followtext = "FOLLOW";
  bool firsttime = true;
  VideoService videoService = VideoService();
  FollowerService followerService = FollowerService();
  final OtherUserVideoController otherUserVideoController =
      Get.put(OtherUserVideoController());
  final OtherUserPlaylistController otherUserPlaylistController =
      Get.put(OtherUserPlaylistController());
  @override
  void initState() {
    callApi();
    otherUserVideoController.updateString(widget.userId.toString());
    otherUserPlaylistController.updateString(widget.userId.toString());
    setState(() {
      if (firsttime) {
        var xx = widget.followcheck.toString() == "UNFOLLOW"
            ? "Following"
            : "Follow";
        followtext = xx;
      }
    });
    super.initState();
  }

  callApi() async {
    await videoService.getMyAnalytics(widget.userId.toString()).then(
          (value) => {
            if (value['success'])
              {
                setState(() {
                  userImage = value['data']['userProfileImage'];
                  userName = value['data']['userName'];
                  usertotalViews = value['data']['totalViews'];
                  usertotalVideos = value['data']['totalVideos'];
                  usertotalFollowers = value['data']['totalFollowers'];
                  usertotalFollowings = value['data']['totalFollowings'];
                })
              }
            else
              {
                SnackbarUtils.showErrorSnackbar(
                    "Failed to Analytics", value['message'].toString())
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createSilverAppBar1(),
          ];
        },
        body: Scaffold(
          body: DefaultTabController(
            length: 5,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // if (followButton == "follow") {
                      //   setState(() {
                      //     followButton = "following";
                      //   });
                      // } else {
                      //   if (followButton == "following") {
                      //     setState(() {
                      //       followButton = "follow";
                      //     });
                      //   }
                      // }
                      followerService
                          .followAndUnfollow(widget.userId.toString())
                          .then((value) => {
                                if (value['success'])
                                  {
                                    if (followtext == "Follow")
                                      {
                                        setState(() {
                                          firsttime = false;
                                          followtext = "Following";
                                        })
                                      }
                                    else
                                      {
                                        if (followtext == "Following")
                                          {
                                            setState(() {
                                              firsttime = false;
                                              followtext = "Follow";
                                            })
                                          }
                                      }
                                  }
                              });
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: followtext == "Follow"
                            ? kButtonColor
                            : kBackGroundColor,
                        border: Border.all(width: 1, color: kButtonColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            followtext,
                            style: const TextStyle(
                                fontSize: 13, color: kWhiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  unselectedLabelColor: kButtonSecondaryColor,
                  labelColor: kButtonColor,
                  isScrollable: true,
                  indicatorColor: kButtonColor,
                  dividerColor: kAmberColor,
                  tabs: [
                    Tab(text: 'My Videos'),
                    Tab(text: 'My Playlist'),
                    Tab(text: 'Followers'),
                    Tab(text: 'Following'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OtherUserVideoPage(
                          userId: widget.userId,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: OtherUserPlaylistPage(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OtherUserFollowersPage(
                          userId: widget.userId,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OtherUserFollowingPage(
                          userId: widget.userId,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 320 : 300,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Scaffold(
              body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF121330),
                          Colors.transparent,
                          Colors.transparent,
                          Color(0xFF121330)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0, 0.5, 1.7],
                      ),
                    ),
                    child: SizedBox(
                      height: 400,
                      width: Get.height,
                      child: Image.asset(
                        "assets/images/cityImage.jpg",
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
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Platform.isIOS ? 35 : 28, left: 20, bottom: 0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kTextSecondaryColor, width: 0.4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SizedBox(
                              height: 16,
                              width: 26,
                              child: Image.asset(
                                "assets/icons/back_white.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: const Text(
                                "User Profile",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "        ",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16, top: 50),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                userImage.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  "assets/images/blank_profile.png",
                                  fit: BoxFit.cover,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
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
                          const SizedBox(height: 10),
                          Text(
                            userName,
                            style: const TextStyle(
                              color: kWhiteColor,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  usertotalVideos.toString(),
                                  style: const TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  "Videos",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kButtonSecondaryColor),
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/icons/line_vertical.png",
                            color: kButtonSecondaryColor,
                            scale: 1.2,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  usertotalViews.toString(),
                                  style: const TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  "Views",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kButtonSecondaryColor),
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/icons/line_vertical.png",
                            color: kButtonSecondaryColor,
                            scale: 1.2,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  usertotalFollowers.toString(),
                                  style: const TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kButtonSecondaryColor),
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/icons/line_vertical.png",
                            color: kButtonSecondaryColor,
                            scale: 1.2,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  usertotalFollowings.toString(),
                                  style: const TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kButtonSecondaryColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        );
      }),
    );
  }

  buildTabSelection(String title, double size, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabindex = index;
        });
      },
      child: Container(
        width: size,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: tabindex == index ? kButtonColor : kBackGroundColor,
                  width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Center(
            child: Text(title,
                style: TextStyle(
                  color:
                      tabindex == index ? kButtonColor : kButtonSecondaryColor,
                  fontSize: 14,
                )),
          ),
        ),
      ),
    );
  }
}
