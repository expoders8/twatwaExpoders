import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../controller/video_detail_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/like_widget.dart';
import '../widgets/share_widget.dart';
import '../../services/video_service.dart';
import '../video_details/about/about.dart';
import '../video_details/upNext/upnext.dart';
import '../video_details/comments/comments.dart';
import '../../controller/playlist_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/dotted_line_provider.dart';

class VideoDetailsPage extends StatefulWidget {
  final String? videoId;
  const VideoDetailsPage({super.key, this.videoId});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  int tabindex = 0, dishblevalue = 0, selectvideoQualityIndex = 6;
  String qualityname = "", followtext = "FOLLOW";

  VideoService videoService = VideoService();

  final PlaylistController playlistController = Get.put(PlaylistController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  bool isChecked = false,
      showOverlay = true,
      _isPlaying = false,
      click = false,
      _isFullScreen = false;
  double _sliderValue = 0.0;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var videoId = videoDetailController.videoId();
      videoService.videoView(videoId);
      videoDetailController.fetchStoryDetail();
      var getURL = Get.parameters['value'];
      if (getURL == "false") {
        _exitFullScreen();
      }
      Future.delayed(const Duration(milliseconds: 180), () async {
        showOverlay = false;
        _isPlaying = true;
      });

      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(
          "https://lp-playback.com/hls/4fc8czsen4agp3yz/index.m3u8")
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
    });
  }

  @override
  void dispose() {
    videoDetailController.videoId("");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        videoDetailController.videoId("");
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Obx(() {
        if (videoDetailController.isLoading.value) {
          return Scaffold(body: LoaderUtils.showLoader());
        } else {
          var data = videoDetailController.detailModel;

          var detailData = data!.data;
          String formattedDate = DateFormat('yyyy-MMMM-dd')
              .format(DateTime.parse(detailData!.createdOn.toString()));
          final splittedDate = formattedDate.split("-");
          final splityear = splittedDate[0];
          final splitmonth = splittedDate[1];
          final splitday = splittedDate[2];
          return Scaffold(
            backgroundColor: kBackGroundColor,
            body: GestureDetector(
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
                            createSilverAppBar1(
                              detailData.title.toString(),
                              detailData.userName,
                              detailData.numberOfViews,
                              detailData.numberOfLikes,
                              detailData.numberOfDislikes,
                              splitday,
                              splitmonth,
                              splityear,
                              detailData.id,
                              detailData.isLiked,
                              detailData.isDisliked,
                            ),
                          ];
                        },
                        body: Container(
                          color: kBackGroundColor,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
          );
        }
      }),
    );
  }

  SliverAppBar createSilverAppBar1(String title, username, numberOfViews,
      islikeValue, isdislikeValue, day, month, year, id, isLiked, isDisliked) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackGroundColor,
      expandedHeight: Platform.isAndroid
          ?
          // _isFullScreen
          //     ? 200
          //     :
          170
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
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 210,
                                    child: Text(
                                      title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: kTextsecondarytopColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${day}th, $month $year",
                                    style: const TextStyle(
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
                      child: Text(
                        "$numberOfViews Views",
                        style: const TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 13,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Row(
                  children: [
                    LikeWidget(
                      videoId: id,
                      isLiked: isLiked,
                      likeCount: islikeValue,
                      dislikeCount: isdislikeValue,
                      isdisLiked: isDisliked,
                    ),
                    const SizedBox(width: 10),
                    const ShareWidget(title: "", imageUrl: "", text: ""),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
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
              const SizedBox(height: 15),
              SizedBox(
                width: Get.width - 25,
                height: 1,
                child: CustomPaint(
                  painter: DottedLinePainter(),
                ),
              ),
              const SizedBox(height: 15),
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
                        GestureDetector(
                          onTap: () {
                            if (followtext == "FOLLOW") {
                              setState(() {
                                followtext = "UNFOLLOW";
                              });
                            } else {
                              if (followtext == "UNFOLLOW") {
                                setState(() {
                                  followtext = "FOLLOW";
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 6, left: 6),
                            margin: const EdgeInsets.only(right: 24),
                            decoration: BoxDecoration(
                                color: followtext == "FOLLOW"
                                    ? kButtonColor
                                    : kBackGroundColor,
                                border: Border.all(
                                    width: 1,
                                    color: followtext == "FOLLOW"
                                        ? kButtonColor
                                        : kButtonSecondaryColor),
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              followtext,
                              style: const TextStyle(
                                  color: kWhiteColor,
                                  letterSpacing: 1.5,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        // Container(
                        //     width: 85,
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //         color: videos[index].follow
                        //             ? kButtonColor
                        //             : kBackGroundColor,
                        //         border: Border.all(
                        //             width: 1,
                        //             color: videos[index].follow
                        //                 ? kButtonColor
                        //                 : kButtonSecondaryColor),
                        //         borderRadius: BorderRadius.circular(25)),
                        //     child: Center(
                        //       child: Text(
                        //         videos[index].follow ? "FOLLOW" : "UNFOLLOW",
                        //         style: TextStyle(
                        //             color: videos[index].follow
                        //                 ? kWhiteColor
                        //                 : kButtonSecondaryColor,
                        //             fontSize: 11,
                        //             fontFamily: kFuturaPTDemi),
                        //       ),
                        //     ),
                        //   ),
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
                    Expanded(
                      child: Obx(
                        () {
                          if (playlistController.isLoading.value) {
                            return LoaderUtils.showLoader();
                          } else {
                            if (playlistController.playList.isNotEmpty) {
                              if (playlistController
                                  .playList[0].data!.isEmpty) {
                                return Center(
                                  child: SizedBox(
                                    width: Get.width - 80,
                                    child: const Text(
                                      "Playlist not Found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 15,
                                          fontFamily: kFuturaPTDemi),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  padding: const EdgeInsets.only(left: 15),
                                  scrollDirection: Axis.vertical,
                                  itemCount: playlistController
                                      .playList[0].data?.length,
                                  itemBuilder: (context, index) {
                                    var playlistData =
                                        playlistController.playList[0].data!;

                                    if (playlistData.isNotEmpty) {
                                      var data = playlistData[index];
                                      return Column(
                                        children: <Widget>[
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            dense: true,
                                            checkColor: kButtonColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            side: MaterialStateBorderSide
                                                .resolveWith(
                                              (states) => BorderSide(
                                                  width: 1.0,
                                                  color: isChecked
                                                      ? kButtonColor
                                                      : kButtonSecondaryColor),
                                            ),
                                            title: Text(
                                              data.playlistName.toString(),
                                              style: const TextStyle(
                                                  color: kTextsecondarytopColor,
                                                  fontSize: 16,
                                                  fontFamily: kFuturaPTDemi),
                                            ),
                                            activeColor: kAppBottomSheetColor,
                                            selected: isChecked,
                                            value: true,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   _items[index].isSelected =
                                              //       newValue!;
                                              //   _items[index].isSelected == true
                                              //       ? dishblevalue = 1
                                              //       : dishblevalue = 0;
                                              // });
                                            },
                                          )
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          "No Playlist found",
                                          style: TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 15,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            } else {
                              return const Center(
                                child: Text(
                                  "No Playlist found",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTDemi),
                                ),
                              );
                            }
                          }
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
                                            side: BorderSide(
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
                        padding: const EdgeInsets.all(13),
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
