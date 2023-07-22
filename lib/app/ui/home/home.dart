import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../widgets/like_widget.dart';
import '../widgets/share_widget.dart';
import '../widgets/playlist_widget.dart';
import '../home/view/jobs_home_view.dart';
import '../home/view/talent_home_view.dart';
import '../home/view/premium_home_view.dart';
import '../home/view/popular_home_view.dart';
import '../home/view/tranding_home_view.dart';
import '../home/view/descovery_home_view.dart';
import '../home/view/education_home_view.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/constant/font_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
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
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/authBackground.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 42, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Discover",
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              height: 20.71,
                              width: 30.02,
                              child: Image.asset(
                                "assets/icons/dropdown.png",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 23),
                              height: 19.96,
                              width: 19.96,
                              child: Image.asset(
                                "assets/icons/search.png",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.loginPage);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                height: 42,
                                width: 42,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    "assets/images/authBackground.png",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Video of the day",
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "We Don’t Talk",
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 22),
                            width: 280,
                            child: const Text(
                              "Charlie Puth - We Don’t Talk Anymore feat.Selena Gomez Official Video",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 37),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 42,
                              width: 42,
                              child: Image.asset(
                                "assets/icons/Play.png",
                                scale: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                              margin: const EdgeInsets.only(right: 20, top: 9),
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
                      const SizedBox(height: 15),
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
                            const ShareWidget(
                                title: "", imageUrl: "", text: ""),
                            const SizedBox(width: 10),
                            PlaylistWidget(isLiked: false, likeCount: 1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "assets/icons/searchDescover.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "DESCOVER",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 13,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: DescoverHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "assets/icons/selectranding.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Trending",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 13,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: TrandingHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "assets/icons/following.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: DescoverHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "assets/icons/talent.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Talent Videos",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: TalentHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "assets/icons/jobs.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Jobs Videos",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: JobsHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "assets/icons/education.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Education Videos",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 13,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: EducationHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "assets/icons/premiumShows.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Premium Shows",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: PremiumHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: Image.asset(
                                    "assets/icons/hashtags.png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "POPULAR HASHTAGS",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 180,
                            child: PopularHomeView(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
