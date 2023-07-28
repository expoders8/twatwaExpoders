import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../profile/updateprofile.dart';
import '../profile/MyVideo/myvideo.dart';
import '../profile/Analytics/analytics.dart';
import '../profile/Followers/followers.dart';
import '../profile/Following/following.dart';
import '../profile/MyPlaylist/myplaylist.dart';
import '../auth/ChangePassword/changepassword.dart';
import '../../../config/constant/color_constant.dart';
import '../profile/NotificationSetting/notificationsetting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int tabindex = 0;
  String profileScreen = "profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
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
                              if (profileScreen == "profileSettting") {
                                setState(() {
                                  profileScreen = "profile";
                                });
                              } else {
                                if (profileScreen == "profile") {
                                  setState(() {
                                    profileScreen = "profileSettting";
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 1, color: kButtonSecondaryColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  profileScreen == "profile"
                                      ? SizedBox(
                                          height: 13,
                                          width: 13,
                                          child: Image.asset(
                                            "assets/icons/setting.png",
                                            color: kButtonColor,
                                            scale: 1,
                                          ),
                                        )
                                      : Container(),
                                  profileScreen == "profile"
                                      ? const SizedBox(width: 8)
                                      : Container(),
                                  Text(
                                    profileScreen == "profile"
                                        ? "PROFILE"
                                        : "My profile",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: kButtonSecondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        profileScreen == "profile"
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildTabSelection("My Videos", 120.0, 0),
                                    buildTabSelection("My Playlist", 100.0, 1),
                                    buildTabSelection("Analytics", 100.0, 2),
                                    buildTabSelection("Followers", 100.0, 3),
                                    buildTabSelection("Following", 100.0, 4),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildTabSelection("Profile", 100.0, 0),
                                    buildTabSelection("Password", 110.0, 1),
                                    buildTabSelection(
                                        "Notifications", 110.0, 2),
                                    buildTabSelection("Billing", 90.0, 3),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 5),
                        profileScreen == "profile"
                            ? Expanded(
                                child: SizedBox(
                                    height: Get.height,
                                    child: tabindex == 0
                                        ? const MyVideoPage()
                                        : tabindex == 1
                                            ? const MyPlaylistPage()
                                            : tabindex == 2
                                                ? const AnalyticsPage()
                                                : tabindex == 3
                                                    ? const FollowersPage()
                                                    : tabindex == 4
                                                        ? const FollowingPage()
                                                        : Container()),
                              )
                            : Expanded(
                                child: SizedBox(
                                    height: Get.height,
                                    child: tabindex == 0
                                        ? const UpdateProfilePage()
                                        : tabindex == 1
                                            ? const ChangePasswordPage()
                                            : tabindex == 2
                                                ? const NotificationSettingPage()
                                                : tabindex == 3
                                                    ? const FollowersPage()
                                                    : tabindex == 4
                                                        ? const FollowingPage()
                                                        : Container()),
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

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 303 : 145,
      floating: false,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Scaffold(
              body: Stack(
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
                    stops: [0, 0, 0, 1],
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
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 42, left: 20, bottom: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: kWhiteColor, width: 0.6))),
                      child: Row(
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
                          GestureDetector(
                            child: const Padding(
                              padding: EdgeInsets.only(left: 90.0),
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 20,
                                ),
                              ),
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
                                "assets/images/authBackground.png",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Riya Patel",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
