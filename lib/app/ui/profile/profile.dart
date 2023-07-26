import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twatwa/app/ui/profile/MyVideo/myvideo.dart';

import '../../../config/constant/color_constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int tabindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  stops: [0, 0.5, 0.1, 1],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 42, left: 20, bottom: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: kWhiteColor, width: 0.1))),
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "45",
                                style:
                                    TextStyle(fontSize: 17, color: kWhiteColor),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Videos",
                                style: TextStyle(
                                    fontSize: 14, color: kButtonSecondaryColor),
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "75m",
                                style:
                                    TextStyle(fontSize: 17, color: kWhiteColor),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Views",
                                style: TextStyle(
                                    fontSize: 14, color: kButtonSecondaryColor),
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "23k",
                                style:
                                    TextStyle(fontSize: 17, color: kWhiteColor),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 14, color: kButtonSecondaryColor),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "10k",
                                style:
                                    TextStyle(fontSize: 17, color: kWhiteColor),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Following",
                                style: TextStyle(
                                    fontSize: 14, color: kButtonSecondaryColor),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(width: 1, color: kButtonSecondaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(
                              "assets/icons/setting.png",
                              color: kButtonColor,
                              scale: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "PROFILE",
                            style: TextStyle(
                                fontSize: 13, color: kButtonSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabindex = 0;
                            });
                          },
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: tabindex == 0
                                          ? kButtonColor
                                          : kBackGroundColor,
                                      width: 1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Center(
                                child: Text("My VIDEOS",
                                    style: TextStyle(
                                        color: tabindex == 0
                                            ? kButtonColor
                                            : kButtonSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabindex = 1;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: tabindex == 1
                                          ? kButtonColor
                                          : kBackGroundColor,
                                      width: 1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Center(
                                child: Text("My Playlist",
                                    style: TextStyle(
                                        color: tabindex == 1
                                            ? kButtonColor
                                            : kButtonSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabindex = 2;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: tabindex == 2
                                          ? kButtonColor
                                          : kBackGroundColor,
                                      width: 1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Center(
                                child: Text("analytics",
                                    style: TextStyle(
                                        color: tabindex == 2
                                            ? kButtonColor
                                            : kButtonSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabindex = 3;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: tabindex == 3
                                          ? kButtonColor
                                          : kBackGroundColor,
                                      width: 1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Center(
                                child: Text("Followers",
                                    style: TextStyle(
                                        color: tabindex == 3
                                            ? kButtonColor
                                            : kButtonSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                      height: Get.height / 2.2, child: const MyVideoPage()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
