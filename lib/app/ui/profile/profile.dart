import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:opentrend/app/ui/home/tab_page.dart';

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
  int tabindex = 0,
      usertotalViews = 0,
      usertotalVideos = 0,
      usertotalFollowings = 0,
      userAmount = 0,
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
                  userAmount = value['data']['userAmount'] ?? 0;
                })
              }
            else
              {}
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: profileScreen == "profile" ? 5 : 4, // Number of tabs
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createSilverAppBar1(),
          ];
        },
        body: Scaffold(
          body: DefaultTabController(
            initialIndex: 0,
            length: profileScreen == "profile" ? 5 : 4,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
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
                                  fontSize: 13, color: kButtonSecondaryColor),
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
                              width: 1, color: kButtonSecondaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.logout_outlined,
                              color: kButtonSecondaryColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 13, color: kButtonSecondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                profileScreen == "profile"
                    ? const TabBar(
                        unselectedLabelColor: kButtonSecondaryColor,
                        labelColor: kButtonColor,
                        isScrollable: true,
                        indicatorColor: kButtonColor,
                        dividerColor: kAmberColor,
                        tabs: [
                          Tab(text: 'My Videos'),
                          Tab(text: 'My Playlist'),
                          Tab(text: 'Analytics'),
                          Tab(text: 'Followers'),
                          Tab(text: 'Following'),
                        ],
                      )
                    : const TabBar(
                        unselectedLabelColor: kButtonSecondaryColor,
                        labelColor: kButtonColor,
                        isScrollable: true,
                        indicatorColor: kButtonColor,
                        dividerColor: kAmberColor,
                        tabs: [
                          Tab(text: 'Profile'),
                          Tab(text: 'Password'),
                          Tab(text: 'Notifications'),
                          Tab(text: 'Billing'),
                        ],
                      ),
                Expanded(
                  child: profileScreen == "profile"
                      ? TabBarView(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: MyVideoPage(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: MyPlaylistPage(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: AnalyticsPage(amount: userAmount),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: FollowersPage(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: FollowingPage(),
                            ),
                          ],
                        )
                      : const TabBarView(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: UpdateProfilePage(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: ChangePasswordPage(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: NotificationSettingPage(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: FollowersPage(),
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
                              Get.offAll(() => const TabPage());
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
                                "My Profile",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "         ",
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
                            margin: EdgeInsets.only(
                                right: 16, top: Platform.isIOS ? 60 : 50),
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
                      padding: EdgeInsets.only(top: Platform.isIOS ? 26 : 21.0),
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
