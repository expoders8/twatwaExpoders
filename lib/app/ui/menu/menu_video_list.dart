import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;

import '../../../config/constant/font_constant.dart';
import '../../controller/comments_controller.dart';
import '../../controller/video_controller.dart';
import '../../controller/video_detail_controller.dart';
import '../../routes/app_pages.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/dotted_line_provider.dart';

class SearchVideoListPage extends StatefulWidget {
  const SearchVideoListPage({super.key});

  @override
  State<SearchVideoListPage> createState() => _SearchVideoListPageState();
}

class _SearchVideoListPageState extends State<SearchVideoListPage> {
  final SearchVideoController searchVideoController =
      Get.put(SearchVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());
  bool islisteing = false;
  String text = "", searchText = "";
  var speechToText = stts.SpeechToText();
  final TextEditingController videolistcontroller = TextEditingController();

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
        actions: [
          IconButton(
            icon: AvatarGlow(
              animate: islisteing,
              repeat: true,
              endRadius: 50,
              glowColor: kWhiteColor,
              duration: const Duration(milliseconds: 1000),
              child: const Image(
                image: AssetImage(
                  "assets/icons/mic.png",
                ),
                width: 15,
              ),
            ),
            onPressed: () async {
              listen();
            },
          ),
        ],
        title: Expanded(
          child: TextField(
            controller: videolistcontroller,
            style: const TextStyle(color: kButtonSecondaryColor),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: kButtonSecondaryColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(17, 14, 0, 17),
              prefixIcon: Image.asset(
                "assets/icons/search.png",
                scale: 24,
                color: kButtonSecondaryColor,
              ),
            ),
            onChanged: (value) => {
              setState(() {
                searchVideoController.searchQuery(value);
                searchVideoController.fetchVideo();
              }),
            },
          ),
        ),
        elevation: 1,
      ),
      body: Obx(
        () {
          if (searchVideoController.isLoading.value) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [buildLazyloading()],
              ),
            );
          } else {
            if (searchVideoController.videoList[0].data != null) {
              if (searchVideoController.videoList[0].data!.isEmpty) {
                return Center(
                  child: SizedBox(
                    width: Get.width - 80,
                    child: const Text(
                      "Video not Found",
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
                  padding: const EdgeInsets.only(top: 20),
                  scrollDirection: Axis.vertical,
                  itemCount: searchVideoController.videoList[0].data!.length,
                  itemBuilder: (context, index) {
                    var discoverData = searchVideoController.videoList[0].data!;

                    if (discoverData.isNotEmpty) {
                      var data = discoverData[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.videoDetailsPage);
                          upNextVideoController
                              .updateString(data.categoryId.toString());
                          commentsController.updateString(data.id.toString());
                          videoDetailController.videoId(data.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 46,
                                    width: 46,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        data.videoThumbnailImagePath.toString(),
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          "assets/images/blank_profile.png",
                                          fit: BoxFit.cover,
                                        ),
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return SizedBox(
                                            width: 17,
                                            height: 17,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: kWhiteColor,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13.0, top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width - 100,
                                              margin: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                data.title.toString(),
                                                style: const TextStyle(
                                                    color:
                                                        kTextsecondarytopColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${data.numberOfViews.toString()} views",
                                              style: const TextStyle(
                                                color:
                                                    kTextsecondarybottomColor,
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
                              const SizedBox(height: 14),
                              SizedBox(
                                width: Get.width - 25,
                                child: CustomPaint(
                                  painter: DottedLinePainter(),
                                ),
                              ),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Video not Found",
                          textAlign: TextAlign.center,
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
                  "Video not Found",
                  textAlign: TextAlign.center,
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
    );
  }

  void listen() async {
    if (!islisteing) {
      bool available = await speechToText.initialize();
      if (available) {
        setState(() {
          islisteing = true;
        });
        speechToText.listen(
          onResult: (result) => setState(
            () {
              text = result.recognizedWords;
              videolistcontroller.text = text;
              searchVideoController.searchQuery(text);
              searchVideoController.fetchVideo();
              if (text != "") {
                setState(() {
                  islisteing = false;
                });
              }
            },
          ),
        );
      }
    } else {
      setState(() {
        islisteing = false;
      });
      speechToText.stop();
    }
  }

  buildLazyloading() {
    return SizedBox(
      height: Get.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: kButtonSecondaryColor,
                  highlightColor: kShimmerEffectSecondary,
                  enabled: true,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: 20,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
}
