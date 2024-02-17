import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../home/tab_page.dart';
import '../profile/profile.dart';
import '../../../config/constant/color_constant.dart';

class VideoUploadedPage extends StatefulWidget {
  const VideoUploadedPage({super.key});

  @override
  State<VideoUploadedPage> createState() => _VideoUploadedPageState();
}

class _VideoUploadedPageState extends State<VideoUploadedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: kButtonSecondaryColor,
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(() => const TabPage());
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
          "Published",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.offAll(() => const TabPage());
          return Future.value(false);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  "assets/images/success.png",
                  scale: 1.8,
                ),
                const SizedBox(height: 40),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations you are live now.🤟",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 280,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(
                          color: kTextsecondarybottomColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: Get.width,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: () {
                      Get.offAll(() => const ProfilePage());
                    },
                    child: const Text(
                      'Go To MyVideos',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
