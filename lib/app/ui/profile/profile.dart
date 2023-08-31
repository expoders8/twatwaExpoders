import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:opentrend/app/ui/home/tab_page.dart';

import '../../controller/video_controller.dart';
import '../../services/video_service.dart';
import '../profile/updateprofile.dart';
import '../profile/MyVideo/myvideo.dart';
import '../profile/Analytics/analytics.dart';
import '../profile/Followers/followers.dart';
import '../profile/Following/following.dart';
import '../profile/MyPlaylist/myplaylist.dart';
import '../../../config/constant/constant.dart';
import '../auth/ChangePassword/changepassword.dart';
import '../../../config/constant/color_constant.dart';
import '../profile/NotificationSetting/notificationsetting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MyVideoController myVideoController = Get.put(MyVideoController());
  int tabindex = 0,
      usertotalViews = 0,
      usertotalVideos = 0,
      usertotalFollowings = 0,
      usertotalFollowers = 0;
  String profileScreen = "profile";
  String userName = "", userEmail = "", userImage = "", userId = '';
  final _googleSignIn = GoogleSignIn();
  VideoService videoService = VideoService();

  @override
  void initState() {
    super.initState();
    getUser();
    callApi();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userName = getUserData['userName'] ?? "";
        userEmail = getUserData['email'] ?? "";
        userImage = getUserData['profilePhoto'] ?? "";
        userId = getUserData['id'] ?? "";
      });
    }
  }

  callApi() async {
    await videoService.getMyAnalytics(userId).then(
          (value) => {
            if (value['success'])
              {
                setState(() {
                  usertotalViews = value['data']['totalViews'] ?? 0;
                  usertotalVideos = value['data']['totalVideos'] ?? 0;
                  usertotalFollowers = value['data']['totalFollowers'] ?? 0;
                  usertotalFollowings = value['data']['totalFollowings'] ?? 0;
                })
              }
            else
              {}
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: WillPopScope(
        onWillPop: () {
          Get.offAll(() => const TabPage());
          return Future.value(false);
        },
        child: GestureDetector(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
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
                                          width: 1,
                                          color: kButtonSecondaryColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: logoutConfirmationDialog,
                                  child: Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1,
                                          color: kButtonSecondaryColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.logout_outlined,
                                          color: kButtonSecondaryColor,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: kButtonSecondaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                      buildTabSelection(
                                          "My Playlist", 100.0, 1),
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
      ),
    );
  }

  logoutConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert !"),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: const Text("Are you sure want to logout?"),
        contentPadding: const EdgeInsets.only(left: 25, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              _googleSignIn.disconnect();
              Navigator.of(context).pop();
              box.remove('user');
              box.remove('authToken');
              Get.offAll(() => const TabPage());
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 310 : 300,
      floating: false,
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
                      color: const Color(0xFF121330).withOpacity(0.3),
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
                              Get.offAll(() => const TabPage());
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
                                "My Profile",
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
                            "$userName  ",
                            style: const TextStyle(
                              color: kWhiteColor,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
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
