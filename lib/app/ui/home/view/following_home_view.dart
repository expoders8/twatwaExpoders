import 'package:flutter/material.dart';

import '../../../../config/constant/color_constant.dart';
import '../../../models/user_list_model.dart';

class FollowingHomeView extends StatefulWidget {
  const FollowingHomeView({super.key});

  @override
  State<FollowingHomeView> createState() => _FollowingHomeViewState();
}

class _FollowingHomeViewState extends State<FollowingHomeView> {
  @override
  Widget build(BuildContext context) {
    List<Videos> videos = [
      Videos(
        image: "assets/images/following1.png",
        title: "Ed Sheeran - Shape of You",
        views: "681,298 views",
      ),
      Videos(
        image: "assets/images/following2.png",
        title: "Marshmello & Anne-Marie Friends",
        views: "1,854,681,298 views",
      ),
      Videos(
        image: "assets/images/following3.png",
        title: "The Chainsmokers & Coldplay - Something",
        views: "681,298 views",
      )
    ];
    return ListView.builder(
      padding: const EdgeInsets.only(left: 15),
      scrollDirection: Axis.horizontal,
      itemCount: videos.length,
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
                      width: 150,
                      height: 100,
                      child: Image.asset(
                        videos[index].image,
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
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 130,
                      child: Text(
                        videos[index].title,
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
                      videos[index].views,
                      style: const TextStyle(
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
