import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../profile/Followers/followers.dart';
import '../profile/Following/following.dart';
import '../profile/MyPlaylist/myplaylist.dart';
import '../../../config/constant/color_constant.dart';
import '../OtherUserProfile/OtherUserHome/other_user_home.dart';
import '../OtherUserProfile/OtherUserVideo/other_user_video.dart';

class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({super.key});

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  int tabindex = 0;
  String followButton = "follow";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: Get.height,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxScrolled) {
                    return <Widget>[
                      createSilverAppBar1(),
                    ];
                  },
                  body: Container(
                    color: kBackGroundColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (followButton == "follow") {
                                setState(() {
                                  followButton = "following";
                                });
                              } else {
                                if (followButton == "following") {
                                  setState(() {
                                    followButton = "follow";
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                color: followButton == "follow"
                                    ? kButtonColor
                                    : kButtonSecondaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    followButton == "follow"
                                        ? "24 k Follower"
                                        : "Following",
                                    style: const TextStyle(
                                        fontSize: 13, color: kWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildTabSelection("Home", 90.0, 0),
                              buildTabSelection("Videos", 100.0, 1),
                              buildTabSelection("Playlist", 100.0, 2),
                              buildTabSelection("Followers", 100.0, 3),
                              buildTabSelection("Following", 100.0, 4),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: SizedBox(
                              height: Get.height,
                              child: tabindex == 0
                                  ? const OtherUserHomePage()
                                  : tabindex == 1
                                      ? const OtherUserVideoPage()
                                      : tabindex == 2
                                          ? const MyPlaylistPage()
                                          : tabindex == 3
                                              ? const FollowersPage()
                                              : tabindex == 4
                                                  ? const FollowingPage()
                                                  : Container()),
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

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 310 : 145,
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
                      padding:
                          const EdgeInsets.only(top: 42, left: 20, bottom: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kTextSecondaryColor, width: 0.4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Image.asset(
                                "assets/icons/back.png",
                                scale: 9,
                                color: kWhiteColor,
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
                              child: Image.asset(
                                "assets/images/vincen.png",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "CH Vincent",
                            style: TextStyle(
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
                              children: const [
                                Text(
                                  "45",
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                SizedBox(height: 3),
                                Text(
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
                              children: const [
                                Text(
                                  "75m",
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                SizedBox(height: 3),
                                Text(
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
                              children: const [
                                Text(
                                  "23k",
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                SizedBox(height: 3),
                                Text(
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
                              children: const [
                                Text(
                                  "10k",
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                                SizedBox(height: 3),
                                Text(
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
