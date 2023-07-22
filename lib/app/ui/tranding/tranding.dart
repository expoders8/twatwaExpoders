import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/tranding_list_model.dart';
import '../../../config/constant/color_constant.dart';
import '../widgets/appbar.dart';

// ignore: camel_case_types
class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

// ignore: camel_case_types
class _TrendingPageState extends State<TrendingPage> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Platform.isAndroid ? 60 : 95),
        child: const Padding(
          padding: EdgeInsets.only(top: 40.0, left: 20, right: 5),
          child: AppBarWidget(
            title: 'Trending',
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        scrollDirection: Axis.vertical,
        itemCount: tranding.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: 200,
                        child: Image.asset(
                          tranding[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 7,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(135, 0, 0, 0),
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            "12:23",
                            style: TextStyle(color: kWhiteColor, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                tranding[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              tranding[index].views,
                              style: const TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tranding[index].username,
                                  style: const TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  tranding[index].followers,
                                  style: const TextStyle(
                                    color: kTextsecondarybottomColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 37,
                            width: 37,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/authBackground.png",
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
