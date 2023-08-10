import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/provider/dotted_line_provider.dart';
import '../../models/tranding_list_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Tranding> tranding = [
    Tranding(
      image: "assets/images/imagebg.png",
      title: "Shawn Mendes - Treat You Better",
      views: "1,854,681,298 views",
      followers: "23k Followers",
      username: "shivani Sharma",
      userimage: "assets/images/tranding1.png",
    ),
    Tranding(
      image: "assets/images/imagebg1.png",
      title: "Marshmello & Anne-Marie Friends",
      views: "1,854,681,298 views",
      followers: "23k Followers",
      username: "shivani Sharma",
      userimage: "assets/images/tranding1.png",
    ),
    Tranding(
      image: "assets/images/imagebg2.png",
      title: "The Chainsmokers & Coldplay - Something",
      views: "1,854,681,298 views",
      followers: "23k Followers",
      username: "shivani Sharma",
      userimage: "assets/images/tranding1.png",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        // leading: Image.asset(
        //   "assets/icons/back.png",
        //   scale: 7,
        // ),
        title: const Text(
          "Notification",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 33),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Shivani Sharma",
                                      style: TextStyle(
                                          color: kTextsecondarytopColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " Check New video",
                                      style: TextStyle(
                                        color: kTextsecondarybottomColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
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
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: const Text(
                        "23m",
                        style: TextStyle(
                          color: kTextsecondarybottomColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width - 25,
                  height: 15,
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
