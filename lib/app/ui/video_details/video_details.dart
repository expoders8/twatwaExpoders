import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/constant/font_constant.dart';
import '../widgets/like_widget.dart';
import '../widgets/playlist_widget.dart';
import '../widgets/share_widget.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _MatrimonialListPageState();
}

class _MatrimonialListPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  var tabList = [
    "UP NEXT VIDEOS",
    "ABOUT",
    "COMMENTS",
  ];
  @override
  Widget build(BuildContext context) {
    _tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: Get.width,
            child: Image.asset(
              "assets/images/imagebg.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 210,
                                child: Text(
                                  "We Don’t Talk Anymore feat. Selena Gomezfsdfsdfsdfdfsfsdfsdf",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "12th, July 2019",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 0),
                  child: const Text(
                    "10,678 Views",
                    style: TextStyle(
                        color: kTextsecondarytopColor,
                        fontSize: 13,
                        fontFamily: kFuturaPTDemi),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Row(
              children: [
                LikeWidget(
                  isLiked: false,
                  likeCount: 1,
                  dislikeCount: 1,
                  isdisLiked: false,
                ),
                const SizedBox(width: 10),
                const ShareWidget(title: "", imageUrl: "", text: ""),
                const SizedBox(width: 10),
                PlaylistWidget(isLiked: false, likeCount: 1),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "---------------------------------------------------",
            style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 3,
                color: kButtonSecondaryColor,
                fontSize: 10,
                fontFamily: kFuturaPTBook),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 42,
                      width: 42,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/authBackground.png",
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Shivani Sharma",
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "23k Follwers",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 28),
                  // width: 150,
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(8),
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: () {},
                    child: const Text(
                      '23K FOLLOW',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 1.5, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Container(
                  color: kBackGroundColor,
                  child: TabBar(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    isScrollable: true,
                    controller: _tabController,
                    labelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                    labelColor: kButtonColor,
                    unselectedLabelColor: kWhiteColor,
                    indicatorWeight: 1,
                    indicator: const BoxDecoration(
                        color: kTransparentColor,
                        border: Border(
                            bottom:
                                BorderSide(color: kButtonColor, width: 0.5))),
                    tabs: List.generate(
                      tabList.length,
                      (index) => Column(
                        children: [
                          Tab(text: tabList[index]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                tabList.length,
                (index) => Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
