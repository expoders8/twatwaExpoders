import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:twatwa/app/routes/app_pages.dart';

import '../widgets/appbar.dart';
import '../../view/my_all_time_favourite_view.dart';
import '../../view/myfavourite_favourite_view.dart';
import '../../view/best_english_favourite_view.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

// ignore: camel_case_types
class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Platform.isAndroid ? 60 : 95),
        child: const Padding(
          padding: EdgeInsets.only(top: 40.0, left: 20, right: 5),
          child: AppBarWidget(
            title: 'Favourite',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      GestureDetector(
                        onTap: () {
                          showTypeBottomSheet();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 25, top: 3),
                          width: 15,
                          height: 15,
                          child: Image.asset(
                            "assets/icons/dots.png",
                          ),
                        ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      GestureDetector(
                        onTap: () {
                          showTypeBottomSheet();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 25, top: 3),
                          width: 15,
                          height: 15,
                          child: Image.asset(
                            "assets/icons/dots.png",
                          ),
                        ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      GestureDetector(
                        onTap: () {
                          showTypeBottomSheet();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 25, top: 3),
                          width: 15,
                          height: 15,
                          child: Image.asset(
                            "assets/icons/dots.png",
                          ),
                        ),
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
            GestureDetector(
              onTap: () {
                var paymentLink = {
                  "headerName": "Create",
                };
                Get.toNamed(Routes.createPlaylistPage, parameters: paymentLink);
              },
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 0.7, color: kButtonColor)),
                child: const Center(
                  child: Text(
                    "Create playlist",
                    style: TextStyle(
                        color: kTextsecondarytopColor,
                        fontSize: 16,
                        fontFamily: kFuturaPTDemi),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  showTypeBottomSheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: kAppBottomSheetColor,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 160,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var paymentLink = {
                            "headerName": "Edit",
                          };
                          Get.toNamed(Routes.createPlaylistPage,
                              parameters: paymentLink);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 9),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: kTextsecondarytopColor, fontSize: 16),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 5),
                        child: Text(
                          "--------------------------------------------------",
                          style: TextStyle(
                              color: kTextsecondarytopColor,
                              fontSize: 13,
                              letterSpacing: 3),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: kTextsecondarytopColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
