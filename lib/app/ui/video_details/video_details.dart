import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../routes/app_pages.dart';
import '../widgets/like_widget.dart';
import '../widgets/share_widget.dart';
import '../video_details/about/about.dart';
import '../video_details/upNext/upnext.dart';
import '../video_details/comments/comments.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  int tabindex = 0, dishblevalue = 0, selectvideoQualityIndex = 6;
  String qualityname = "";
  bool isChecked = false,
      showOverlay = true,
      _isPlaying = false,
      click = false,
      _isFullScreen = false;
  double _sliderValue = 0.0;
  late VideoPlayerController _controller;
  final List<ListItem> _items = [
    ListItem('Save for later', false),
    ListItem('My Favourite video', false),
    ListItem('Songs', false),
    ListItem('Comedy', false),
  ];
  @override
  void initState() {
    super.initState();
    var getURL = Get.parameters['value'];
    var getQualityValue = Get.parameters['qualityValue'];
    if (getURL == "false") {
      _exitFullScreen();
    }
    Future.delayed(const Duration(milliseconds: 180), () async {
      showOverlay = false;
      _isPlaying = true;
    });

    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(
        "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _sliderValue = _controller.value.position.inMilliseconds.toDouble();
        });
      }
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: WillPopScope(
        onWillPop: () {
          _exitFullScreen();
          Get.back();
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              // SizedBox(
              //   height: 250,
              //   width: Get.width,
              //   child: VideoPlayerPage(
              //       videoUrl:
              //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
              // ),
              SizedBox(height: _isFullScreen ? 0 : 30),
              SizedBox(
                width: Get.width,
                height: _isFullScreen ? Get.height : 240,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _controller.value.isInitialized
                        ? VideoPlayer(_controller)
                        : const Center(
                            child: Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: CircularProgressIndicator(
                              color: Colors.white60,
                              backgroundColor: kButtonSecondaryColor,
                              strokeWidth: 2,
                            ),
                          )),
                    _buildControls()
                  ],
                ),
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
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid
          ? _isFullScreen
              ? 200
              : 170
          : 145,
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

  videoQualitySelectBottomsheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: kAppBottomSheetColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(// this is new
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: SizedBox(
                height: Get.height - 50,
                width: _isFullScreen ? Get.width - 380 : Get.width,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 25, left: 20, bottom: 15),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kTextSecondaryColor, width: 0.4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Image.asset(
                                "assets/icons/back.png",
                                scale: 9,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: const Text(
                                "Video Quality",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "        ",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height - 125,
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 0;
                                    qualityname = "1080p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 0
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "1080p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "FHD",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 1;
                                    qualityname = "720p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 1
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "720p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "HD",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 2;
                                    qualityname = "480p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 2
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "480p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 3;
                                    qualityname = "360p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 3
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "360p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 4;
                                    qualityname = "240p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 4
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "240p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 5;
                                    qualityname = "144p";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 5
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "144p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 6;
                                    qualityname = "Auto";
                                  });
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Container(
                                    width: _isFullScreen
                                        ? Get.width - 300
                                        : Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                      color: kCardColor,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color:
                                                  selectvideoQualityIndex == 6
                                                      ? kButtonColor
                                                      : kCardColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Auto",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _buildControls() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showOverlay = !showOverlay;
        });
      },
      child: AnimatedOpacity(
        opacity: showOverlay ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          color: Colors.black.withOpacity(0.7),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _isFullScreen ? 50 : 10,
                    vertical: _isFullScreen ? 10 : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        _exitFullScreen();
                      },
                      child: SizedBox(
                        height: 16,
                        width: 26,
                        child: Image.asset(
                          "assets/icons/back_white.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        videoQualitySelectBottomsheet();
                      },
                      child: Container(
                        padding: EdgeInsets.all(13),
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/icons/setting.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _isFullScreen ? 60 : 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      "assets/icons/previousNext.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: _isFullScreen ? 60 : 33),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isPlaying ? _controller.pause() : _controller.play();
                        _isPlaying = !_isPlaying;
                      });
                      Future.delayed(const Duration(milliseconds: 2000),
                          () async {
                        showOverlay = !showOverlay;
                      });
                    },
                    icon: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        _isPlaying
                            ? "assets/icons/vdeoPause.png"
                            : "assets/icons/Play.png",
                        scale: 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: _isFullScreen ? 60 : 30),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      "assets/icons/nextVideo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: _isFullScreen ? 100 : 40),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: _isFullScreen ? 30 : 10),
                color: Colors.black.withOpacity(0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: kButtonColor,
                        inactiveColor: kButtonSecondaryColor,
                        value: _sliderValue,
                        min: 0.0,
                        max: _controller.value.duration.inMilliseconds
                            .toDouble(),
                        onChanged: _onSliderChange,
                      ),
                    ),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: _isFullScreen ? 25 : 5),
                    IconButton(
                      onPressed: () {
                        _toggleFullScreen();
                        Future.delayed(const Duration(milliseconds: 500),
                            () async {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        });
                      },
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          _isFullScreen
                              ? "assets/icons/fullscreen.png"
                              : "assets/icons/smallscreen.png",
                          color: kWhiteColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _onSliderChange(double value) {
    setState(() {
      _sliderValue = value;
      _controller.seekTo(Duration(milliseconds: value.toInt()));
    });
    Future.delayed(const Duration(milliseconds: 5000), () async {
      setState(() {
        showOverlay = !showOverlay;
      });
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen ? _exitFullScreen() : _enterFullScreen();
      _isFullScreen = !_isFullScreen;
    });
  }

  void _enterFullScreen() {
    setState(() {
      _controller.play();
      _isFullScreen = false;
      _isPlaying = true;
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      _controller.play();
      _isFullScreen = false;
      _isPlaying = true;
    });
  }

  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class ListItem {
  final String title;
  bool isSelected;

  ListItem(this.title, this.isSelected);
}
