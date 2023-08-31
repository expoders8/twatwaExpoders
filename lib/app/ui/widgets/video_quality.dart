import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opentrend/app/routes/app_pages.dart';

import '../../../config/constant/color_constant.dart';

class VideoQualityPage extends StatefulWidget {
  const VideoQualityPage({super.key});

  @override
  State<VideoQualityPage> createState() => _VideoQualityPageState();
}

class _VideoQualityPageState extends State<VideoQualityPage> {
  int selectvideoQualityIndex = 0;
  String qualityname = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: kButtonSecondaryColor,
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: SystemUiOverlay.values);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
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
          "Video Quality",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1.5,
      ),
      body: WillPopScope(
        onWillPop: () {
          _exitFullScreen();
          var backOrintion = {
            "value": "false",
          };
          Get.toNamed(Routes.videoDetailsPage, parameters: backOrintion);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              builscardwidget("1080p", "FHD", 0),
              builscardwidget("720p", "HD", 1),
              builscardwidget("480p", "", 2),
              builscardwidget("360p", "", 3),
              builscardwidget("240p", "", 4),
              builscardwidget("144p", "", 5),
              builscardwidget("Auto", "", 6),
            ],
          ),
        ),
      ),
    );
  }

  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  builscardwidget(String quality, String quality1, int selectCard) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectvideoQualityIndex = selectCard;
          qualityname = quality;
        });
        var backOrintion = {
          "qualityValue": qualityname,
        };
        Get.toNamed(Routes.videoDetailsPage, parameters: backOrintion);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Container(
          width: Get.width,
          height: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
              color: kCardColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: selectvideoQualityIndex == selectCard
                          ? kButtonColor
                          : kCardColor,
                      width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quality,
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    quality1,
                    style: const TextStyle(
                      color: kButtonColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ))),
        ),
      ),
    );
  }
}
