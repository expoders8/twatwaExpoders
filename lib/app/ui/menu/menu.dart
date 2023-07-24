import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twatwa/app/routes/app_pages.dart';

import '../../../config/constant/color_constant.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double scrollPosition = 400.0;
  int selectIndex = 3;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              "assets/icons/back.png",
              scale: 9,
            ),
          ),
        ),
        title: const Text(
          "Menu",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = 1;
                  });
                  Get.toNamed(Routes.menuVideoListPage);
                },
                child: Column(
                  children: [
                    Container(
                      height: selectIndex == 1 ? 130 : 60,
                      width: selectIndex == 1 ? 130 : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                const Color(0xFFCD5B5B).withOpacity(0.5),
                                BlendMode.srcOver),
                            image: const AssetImage(
                              "assets/icons/menu1.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Image.asset(
                        "assets/icons/searchDescover.png",
                        scale: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Discover",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: selectIndex == 1 ? 20 : 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = 2;
                  });
                  Get.toNamed(Routes.menuVideoListPage);
                },
                child: Column(
                  children: [
                    Container(
                      height: selectIndex == 2 ? 130 : 80,
                      width: selectIndex == 2 ? 130 : 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                const Color(0xFFDC4AC6).withOpacity(0.5),
                                BlendMode.srcOver),
                            image: const AssetImage(
                              "assets/icons/menu2.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Image.asset(
                          "assets/icons/premiumShows.png",
                          scale: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Premium Shows",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: selectIndex == 2 ? 20 : 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = 3;
                  });
                  Get.toNamed(Routes.menuVideoListPage);
                },
                child: Column(
                  children: [
                    Container(
                      height: selectIndex == 3 ? 130 : 80,
                      width: selectIndex == 3 ? 130 : 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                const Color(0xFFD86C08).withOpacity(0.5),
                                BlendMode.srcOver),
                            image: const AssetImage(
                              "assets/icons/menu3.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Image.asset(
                          "assets/icons/education.png",
                          scale: 19,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Education Videos",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: selectIndex == 3 ? 20 : 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = 4;
                  });
                  Get.toNamed(Routes.menuVideoListPage);
                },
                child: Column(
                  children: [
                    Container(
                      height: selectIndex == 4 ? 130 : 80,
                      width: selectIndex == 4 ? 130 : 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kBackGroundColor,
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              const Color(0xFF46AFE3).withOpacity(0.5),
                              BlendMode.srcOver),
                          image: const AssetImage(
                            "assets/icons/menu4.png",
                          ),
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/talent.png",
                        scale: 15,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Talent Videos",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: selectIndex == 4 ? 20 : 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = 5;
                  });
                  Get.toNamed(Routes.menuVideoListPage);
                },
                child: Column(
                  children: [
                    Container(
                      height: selectIndex == 5 ? 130 : 60,
                      width: selectIndex == 5 ? 130 : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                const Color(0xFF5E33E0).withOpacity(0.5),
                                BlendMode.srcOver),
                            image: const AssetImage(
                              "assets/icons/menu5.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Image.asset(
                          "assets/icons/jobs.png",
                          scale: 19,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Jobs Videos",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: selectIndex == 5 ? 20 : 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
