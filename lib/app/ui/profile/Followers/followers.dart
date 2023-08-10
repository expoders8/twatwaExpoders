import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/provider/dotted_line_provider.dart';
import '../../../models/user_list_model.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<Follower> videos = [
    Follower(
        image: "assets/images/follower.png",
        title: "Rockband Vincent",
        views: "65k followers",
        follow: false),
    Follower(
        image: "assets/images/follower1.png",
        title: "Rockband Vincent",
        views: "65k followers",
        follow: false),
    Follower(
        image: "assets/images/follower2.png",
        title: "Vincent Talent",
        views: "65k followers",
        follow: false),
    Follower(
        image: "assets/images/follower3.png",
        title: "Deepchand Kutwar",
        views: "65k followers",
        follow: true),
    Follower(
        image: "assets/images/follower4.png",
        title: "Vincent Talent",
        views: "65k followers",
        follow: false),
    Follower(
        image: "assets/images/follower5.png",
        title: "Deepchand Kutwar",
        views: "65k followers",
        follow: false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              videos[index].image,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                videos[index].title,
                                style: const TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                videos[index].views,
                                style: const TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (videos[index].follow) {
                          setState(() {
                            setState(() {
                              videos[index].follow = false;
                            });
                          });
                        } else {
                          if (!videos[index].follow) {
                            setState(() {
                              videos[index].follow = true;
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 85,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: videos[index].follow
                                  ? kButtonColor
                                  : kBackGroundColor,
                              border: Border.all(
                                  width: 1,
                                  color: videos[index].follow
                                      ? kButtonColor
                                      : kButtonSecondaryColor),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text(
                              videos[index].follow ? "FOLLOW" : "UNFOLLOW",
                              style: TextStyle(
                                  color: videos[index].follow
                                      ? kWhiteColor
                                      : kButtonSecondaryColor,
                                  fontSize: 11,
                                  fontFamily: kFuturaPTDemi),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width - 25,
                height: 10,
                child: CustomPaint(
                  painter: DottedLinePainter(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
