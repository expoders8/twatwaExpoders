import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opentrend/app/ui/home/home.dart';

import '../../controller/network_controller.dart';
import '../tranding/tranding.dart';
import '../../routes/app_pages.dart';
import '../favourite/favourite.dart';
import '../notification/notification.dart';
import '../../services/category_service.dart';
import '../../../config/constant/constant.dart';
import '../../controller/hastage_controller.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/dotted_line_provider.dart';

class TabPage extends StatefulWidget {
  final String? tabIndexSubscription;
  final int? selectedTabIndex;
  final String? selectedVideoType;
  const TabPage(
      {super.key,
      this.tabIndexSubscription,
      this.selectedTabIndex = 0,
      this.selectedVideoType});
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final GetAllHasTageController getAllHasTageController =
      Get.put(GetAllHasTageController());
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  List<dynamic> getAllCategory = [];
  CategoryService categoryService = CategoryService();
  final networkController = NetworkController();

  @override
  void initState() {
    callApi();

    super.initState();
  }

  callApi() async {
    if (networkController.isConnected.value) {
      categoryService.getAllCategory();
    }
    if (widget.selectedTabIndex == 3) {
      setState(() {
        currentScreen = const FavouritePage();
        currentTab = 3;
      });
    }
    if (widget.selectedTabIndex == 1) {
      setState(() {
        currentScreen = TrendingPage(type: widget.selectedVideoType);
        currentTab = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        backgroundColor: kButtonColor,
        child: const Icon(
          Icons.video_call,
          color: kWhiteColor,
        ),
        onPressed: () {
          showTypeBottomSheet();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(top: Platform.isIOS ? 12 : 0),
        height: Platform.isIOS ? 90 : 68,
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF22213C),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: size.width > 500
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: size.width > 500 ? 300 : 170,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: size.width > 500
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
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
                            scale: size.width > 500 ? 19 : 22,
                            color: currentTab == 0
                                ? kWhiteColor
                                : const Color.fromRGBO(121, 122, 142, 1),
                          ),
                          SizedBox(height: size.width > 500 ? 10 : 6),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: size.width > 500 ? 14 : 12,
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
                            scale: size.width > 500 ? 19 : 22,
                            color: currentTab == 1
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                          SizedBox(height: size.width > 500 ? 10 : 6),
                          Text(
                            ' Tranding',
                            style: TextStyle(
                              fontSize: size.width > 500 ? 14 : 12,
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
              ),
              SizedBox(
                width: size.width > 500 ? 300 : 190,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: size.width > 500
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      padding: const EdgeInsets.only(left: 12),
                      minWidth: 50,
                      onPressed: () {
                        setState(() {
                          currentScreen = const NotificationPage();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/icons/notification.png",
                            scale: size.width > 500 ? 19 : 22,
                            color: currentTab == 2
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                          SizedBox(height: size.width > 500 ? 10 : 6),
                          Text(
                            'Notification',
                            style: TextStyle(
                              fontSize: size.width > 500 ? 14 : 12,
                              color: currentTab == 2
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
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/icons/favourite.png",
                            scale: size.width > 500 ? 19 : 22,
                            color: currentTab == 3
                                ? kWhiteColor
                                : const Color(0xFF797A8E),
                          ),
                          SizedBox(height: size.width > 500 ? 10 : 6),
                          Text(
                            'Favourite',
                            style: TextStyle(
                              fontSize: size.width > 500 ? 14 : 12,
                              color: currentTab == 3
                                  ? kWhiteColor
                                  : const Color(0xFF797A8E),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showTypeBottomSheet() {
    var data = box.read('category');
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
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-25 / 360),
                      child: CupertinoButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.uploadVideoPage);
                          getAllHasTageController.categoryId(data[2]["id"]);
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: const EdgeInsets.only(left: 220, top: 0),
                          child: const Center(
                            child: Text(
                              "Jobs Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
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
                          children: [
                            SizedBox(
                              width: Get.width - 190,
                              height: 15,
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 53,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-68 / 360),
                      child: CupertinoButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.uploadVideoPage);
                          getAllHasTageController.categoryId(data[3]["id"]);
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          margin: const EdgeInsets.only(left: 150, top: 0),
                          child: const Center(
                            child: Text(
                              "Talent Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
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
                      margin: const EdgeInsets.only(left: 90, top: 0),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(268 / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: Get.width - 160,
                              height: 25,
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 50,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-120 / 360),
                      child: CupertinoButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.uploadVideoPage);
                          getAllHasTageController.categoryId(data[0]["id"]);
                        },
                        child: const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Education Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, top: 0),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-145 / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: Get.width - 154,
                              height: 25,
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 0,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-160 / 360),
                      child: CupertinoButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.uploadVideoPage);
                          getAllHasTageController.categoryId(data[1]["id"]);
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 30, top: 0),
                          child: const Center(
                            child: Text(
                              "Premium Shows",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
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
