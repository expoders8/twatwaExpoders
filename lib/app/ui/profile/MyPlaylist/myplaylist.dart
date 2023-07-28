import 'package:flutter/material.dart';

import '../../../view/my_all_time_favourite_view.dart';
import '../../../view/myfavourite_favourite_view.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../view/best_english_favourite_view.dart';
import '../../../../config/constant/color_constant.dart';

class MyPlaylistPage extends StatefulWidget {
  const MyPlaylistPage({super.key});

  @override
  State<MyPlaylistPage> createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
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
                          "assets/icons/following.png",
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Best English songs",
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 14,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  height: 180,
                  child: BestEnglishSongFavouiteView(),
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
                          "assets/icons/following.png",
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "My favourite",
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 14,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 180,
                  child: MyFavouriteView(),
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
                          "assets/icons/following.png",
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "My all time best",
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 14,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 180,
                  child: MyAllTimeFavouriteView(),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
