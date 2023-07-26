import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twatwa/app/routes/app_pages.dart';

import '../../../config/constant/color_constant.dart';
import '../../models/tranding_list_model.dart';

class MenuVideoListPage extends StatefulWidget {
  const MenuVideoListPage({super.key});

  @override
  State<MenuVideoListPage> createState() => _MenuVideoListPageState();
}

class _MenuVideoListPageState extends State<MenuVideoListPage> {
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
        shadowColor: kButtonSecondaryColor,
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
        title: TextField(
          style: const TextStyle(color: kWhiteColor),
          decoration: InputDecoration(
              hintText: 'Educational',
              hintStyle: const TextStyle(color: kWhiteColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(17, 17, 0, 17),
              prefixIcon: Image.asset(
                "assets/icons/search.png",
                scale: 24,
                color: kButtonSecondaryColor,
              ),
              suffixIcon: IconButton(
                splashColor: kTransparentColor,
                highlightColor: kTransparentColor,
                icon: Image.asset(
                  "assets/icons/mic.png",
                  scale: 1.4,
                ),
                onPressed: () {},
              )),
        ),
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.videoDetailsPage);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  margin: const EdgeInsets.only(right: 0),
                                  child: const Text(
                                    "Marshmello & Anne-Marie Friends",
                                    style: TextStyle(
                                        color: kTextsecondarytopColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "1,854,681,298 views",
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
                  const Text(
                    "------------------------------------------------",
                    style: TextStyle(
                      color: kTextsecondarybottomColor,
                      letterSpacing: 3,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
