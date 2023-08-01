import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../widgets/like_widget.dart';
import '../video_details/video_player.dart';
import '../widgets/share_widget.dart';
import '../video_details/about/about.dart';
import '../video_details/upNext/upnext.dart';
import '../video_details/comments/comments.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _MatrimonialListPageState();
}

class _MatrimonialListPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  int tabindex = 0;
  int dishblevalue = 0;
  bool isChecked = false;
  List selectedItemsList = [];
  final List<ListItem> _items = [
    ListItem('Save for later', false),
    ListItem('My Favourite video', false),
    ListItem('Songs', false),
    ListItem('Comedy', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: Get.width,
              child: const VideoPlayerPage(),
            ),
            Expanded(
              child: SizedBox(
                height: Get.height,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxScrolled) {
                    return <Widget>[
                      createSilverAppBar1(),
                    ];
                  },
                  body: Container(
                    color: kBackGroundColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildTabindex("UP NEXT VIDEOS", 0, 120),
                            buildTabindex("ABOUT", 1, 80),
                            buildTabindex("COMMENTS", 2, 100)
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SizedBox(
                              height: Get.height,
                              child: tabindex == 0
                                  ? const UpNextPage()
                                  : tabindex == 1
                                      ? const AboutPage()
                                      : const CommentsPage()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Column(
            //   children: [
            //     Theme(
            //       data: ThemeData(
            //         splashColor: Colors.transparent,
            //         highlightColor: Colors.transparent,
            //       ),
            //       child: Container(
            //         color: kBackGroundColor,
            //         child: TabBar(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 5, vertical: 5),
            //           isScrollable: true,
            //           controller: _tabController,
            //           labelStyle: const TextStyle(
            //               fontSize: 14, fontWeight: FontWeight.w300),
            //           labelColor: kButtonColor,
            //           unselectedLabelColor: kWhiteColor,
            //           indicatorWeight: 1,
            //           indicator: const BoxDecoration(
            //               color: kTransparentColor,
            //               border: Border(
            //                   bottom:
            //                       BorderSide(color: kButtonColor, width: 0.5))),
            //           tabs: List.generate(
            //             tabList.length,
            //             (index) => Column(
            //               children: [
            //                 Tab(
            //                   text: tabList[index],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: List.generate(
            //         tabList.length,
            //         (index) => index == 0
            //             ? const UpNextPage()
            //             : index == 1
            //                 ? const AboutPage()
            //                 : const CommentsPage()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid ? 170 : 145,
      floating: false,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Scaffold(
              body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  SizedBox(height: 10),
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
                      margin: const EdgeInsets.only(right: 20, top: 11),
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
                    GestureDetector(
                      onTap: playlistbottomsheet,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11.0, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: kButtonSecondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF121330),
                            boxShadow: const [
                              BoxShadow(
                                color: kBlack38Color,
                                blurRadius: 5,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                "assets/icons/unplaylist.png",
                                scale: 1.5,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "105",
                              style: TextStyle(
                                  fontSize: 14, color: kButtonSecondaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
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
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.otherUserProfilePage);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const OtherUserProfilePage(),
                            //   ),
                            // );
                          },
                          child: SizedBox(
                            height: 42,
                            width: 42,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/authBackground.png",
                              ),
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.checkOutPaymentPage);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 6, left: 6),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xD212D2D9), width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            // width: 150,
                            child: Row(
                              children: const [
                                Text(
                                  'DONATE',
                                  style: TextStyle(
                                      color: Color(0xD212D2D9),
                                      letterSpacing: 1.5,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 6, left: 6),
                          margin: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                              color: kButtonColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Text(
                            '23K FOLLOW',
                            style: TextStyle(
                                color: kWhiteColor,
                                letterSpacing: 1.5,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
        );
      }),
    );
  }

  buildTabindex(String text, int index, double size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabindex = index;
        });
      },
      child: Container(
        width: size,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: tabindex == index ? kButtonColor : kBackGroundColor,
                  width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Center(
              child: DefaultTextStyle(
            style: TextStyle(
                color: tabindex == index ? kButtonColor : kWhiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w300),
            child: Text(text),
          )),
        ),
      ),
    );
  }

  playlistbottomsheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        backgroundColor: kAppBottomSheetColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(// this is new
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                height: 451,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      height: 60,
                      width: 100,
                      child: Image.asset(
                        "assets/images/imagebg.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Save to",
                      style: TextStyle(
                        color: kTextsecondarytopColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "-------------------------------------------------",
                      style: TextStyle(
                          color: kButtonSecondaryColor,
                          fontSize: 10,
                          letterSpacing: 4,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        itemCount: _items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                dense: true,
                                checkColor: kButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0,
                                      color: isChecked
                                          ? kButtonColor
                                          : kButtonSecondaryColor),
                                ),
                                title: Text(
                                  _items[index].title,
                                  style: const TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 16,
                                      fontFamily: kFuturaPTDemi),
                                ),
                                activeColor: kAppBottomSheetColor,
                                selected: isChecked,
                                value: _items[index].isSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _items[index].isSelected = newValue!;
                                    _items[index].isSelected == true
                                        ? dishblevalue = 1
                                        : dishblevalue = 0;
                                  });
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    const Text(
                      "-------------------------------------------------",
                      style: TextStyle(
                          color: kButtonSecondaryColor,
                          fontSize: 10,
                          letterSpacing: 4,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          var paymentLink = {
                            "headerName": "Create",
                          };
                          Get.toNamed(Routes.createPlaylistPage,
                              parameters: paymentLink);
                        },
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(width: 0.8, color: kButtonColor)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: SizedBox(
                        width: Get.width,
                        child: CupertinoButton(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(25),
                          onPressed: () {},
                          child: const Text(
                            'DONE',
                            style: TextStyle(
                                color: kWhiteColor,
                                letterSpacing: 2,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          });
        });
  }
}

class ListItem {
  final String title;
  bool isSelected;

  ListItem(this.title, this.isSelected);
}
