import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentrend/app/ui/home/home.dart';

import '../../../config/constant/color_constant.dart';
import '../../routes/app_pages.dart';
import '../favourite/favourite.dart';
import '../notification/notification.dart';
import '../tranding/tranding.dart';

class TabPage extends StatefulWidget {
  final String? tabIndexSubscription;
  final int? selectedTabIndex;
  const TabPage(
      {super.key, this.tabIndexSubscription, this.selectedTabIndex = 0});
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonColor,
        child: const Icon(Icons.video_call),
        onPressed: () {
          showTypeBottomSheet();
          // setState(() {
          //   currentScreen = const UploadVideoPage();
          //   currentTab = 2;
          // });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: Platform.isIOS ? 97 : 68,
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF22213C),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Icon(
                        //   Icons.dashboard,
                        //   color: controller.tabIndex.value == 0
                        //       ? Colors.blue
                        //       : Colors.grey,
                        // ),
                        Image.asset(
                          "assets/icons/home.png",
                          scale: 22,
                          color: currentTab == 0
                              ? kWhiteColor
                              : const Color(0xFF797A8E),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 0
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const TrendingPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/tranding.png",
                          scale: 22,
                          color: currentTab == 1
                              ? kWhiteColor
                              : const Color(0xFF797A8E),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ' Tranding',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 1
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    padding: const EdgeInsets.only(left: 12),
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const NotificationPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/notification.png",
                          scale: 22,
                          color: currentTab == 3
                              ? kWhiteColor
                              : const Color(0xFF797A8E),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Notification',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 3
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = const FavouritePage();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/favourite.png",
                          scale: 22,
                          color: currentTab == 4
                              ? kWhiteColor
                              : const Color(0xFF797A8E),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Favourite',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 4
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
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
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(60.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: kTransparentColor,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.pink[600],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(300.0),
                        topRight: Radius.circular(300.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.uploadVideoPage);
                      },
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-20 / 360),
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: const EdgeInsets.only(left: 240, top: 0),
                          child: const RotationTransition(
                            turns: AlwaysStoppedAnimation(-20 / 360),
                            child: Center(
                              child: Text(
                                "Jobs Videos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: const EdgeInsets.only(left: 180, top: 0),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-45 / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "-------------------------",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 3,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 53,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.uploadVideoPage);
                      },
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-68 / 360),
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: const EdgeInsets.only(left: 185, top: 0),
                          child: const Center(
                            child: Text(
                              "Talent Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Container(
                      margin: const EdgeInsets.only(left: 72, top: 0),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(268 / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "---------------------------------",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 3,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 57,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.uploadVideoPage);
                      },
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-120 / 360),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 70, top: 0),
                          child: const Center(
                            child: Text(
                              "Education Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, top: 0),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-140 / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "-----------------------------",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 3,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 19,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.uploadVideoPage);
                      },
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-160 / 360),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 30, top: 0),
                          child: const Center(
                            child: Text(
                              "Premium Shows",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      margin: const EdgeInsets.only(left: 150, top: 0),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
