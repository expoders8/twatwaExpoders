import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';
import '../../../../config/constant/color_constant.dart';

class PopularHomeView extends StatefulWidget {
  const PopularHomeView({super.key});

  @override
  State<PopularHomeView> createState() => _PopularHomeViewState();
}

class _PopularHomeViewState extends State<PopularHomeView> {
  // List<Videos> videos = [
  //   Videos(
  //     image: "assets/images/popular1.png",
  //     title: "Shawn Mendes - Treat You Better",
  //     views: "1,854,681,298 views",
  //   ),
  //   Videos(
  //     image: "assets/images/popular2.png",
  //     title: "Marshmello & Anne-Marie Friends",
  //     views: "1,854,681,298 views",
  //   ),
  //   Videos(
  //     image: "assets/images/popular3.png",
  //     title: "The Chainsmokers & Coldplay - Something",
  //     views: "1,854,681,298 views",
  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 15),
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.videoDetailsPage);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // SizedBox(
                    //   width: 150,
                    //   height: 100,
                    //   child: Image.asset(
                    //     videos[index].image,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
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
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      width: 130,
                      child: Text(
                        "videos[index].title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      " videos[index].views",
                      style: TextStyle(
                          color: kTextsecondarybottomColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
