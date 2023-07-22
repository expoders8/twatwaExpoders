import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twatwa/app/ui/favourite/favourite.dart';
import 'package:twatwa/app/ui/home/home.dart';
import 'package:twatwa/app/ui/tranding/tranding.dart';
import 'package:twatwa/app/ui/notification/notification.dart';

import '../../../config/constant/color_constant.dart';
import '../uploadvideo/upload_video.dart';

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
          // showTypeBottomSheet();
          setState(() {
            currentScreen = const UploadVideoPage();
            currentTab = 2;
          });
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

  // showTypeBottomSheet() {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   return showModalBottomSheet<dynamic>(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(60.0),
  //         topRight: Radius.circular(60.0),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //     backgroundColor: kTransparentColor,
  //     context: context,
  //     builder: (context) {
  //       return Wrap(
  //         children: [
  //           Theme(
  //             data: ThemeData(
  //               splashColor: Colors.transparent,
  //               highlightColor: Colors.transparent,
  //             ),
  //             child: Container(
  //                 height: 200,
  //                 width: Get.width,
  //                 decoration: const BoxDecoration(
  //                   color: kButtonColor,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(300.0),
  //                     topRight: Radius.circular(300.0),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.only(left: 100, top: 10),
  //                       child: RotationTransition(
  //                         turns: new AlwaysStoppedAnimation(-140 / 360),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: const [
  //                             Text(
  //                               "Lorem ipsum",
  //                               style: TextStyle(color: kGreenColor),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 60),
  //                     Container(
  //                       margin: EdgeInsets.only(left: 30),
  //                       child: RotationTransition(
  //                         turns: new AlwaysStoppedAnimation(-160 / 360),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: const [
  //                             Text(
  //                               "----------------",
  //                               style: TextStyle(
  //                                   color: kWhiteColor, letterSpacing: 3),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 60),
  //                     Container(
  //                       margin: EdgeInsets.only(left: 30),
  //                       child: RotationTransition(
  //                         turns: new AlwaysStoppedAnimation(-180 / 360),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: const [
  //                             Text(
  //                               "Lorem ipsum",
  //                               style: TextStyle(color: kWhiteColor),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
