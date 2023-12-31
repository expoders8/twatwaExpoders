import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../home/tab_page.dart';
import '../widgets/appbar.dart';
import '../../routes/app_pages.dart';
import '../../services/playlist_service.dart';
import '../widgets/no_user_login_screen.dart';
import '../../../config/constant/constant.dart';
import '../../controller/video_controller.dart';
import '../../controller/comments_controller.dart';
import '../../controller/playlist_controller.dart';
import '../favourite/create_and_edit_playlist.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/video_detail_controller.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';
import '../../../config/provider/dotted_line_provider.dart';
import '../../../config/animation/translate_up_animation.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final PlaylistController playlistController = Get.put(PlaylistController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  final UpNextVideoController upNextVideoController =
      Get.put(UpNextVideoController());
  final CommentsController commentsController = Get.put(CommentsController());

  PlaylistService playlistService = PlaylistService();
  String userId = "", authToken = "";
  bool isLoading = true;
  @override
  void initState() {
    var authTokenValue = box.read('authToken');
    setState(() {
      authToken = authTokenValue ?? "";
      if (authToken == "") {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
      }
    });
    getUser();
    super.initState();
  }

  Future getUser() async {
    var data = box.read('user');
    if (data != null) {
      var getUserData = jsonDecode(data);
      if (getUserData != null) {
        setState(() {
          userId = getUserData['id'] ?? "";
        });
      }
    }
  }

  Future<void> _pullRefresh() async {
    if (authToken != "") {
      playlistController.fetchAllPlaylist();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Platform.isAndroid ? 60 : 60),
        child: const AppBarWidget(
          title: 'Favourite',
        ),
      ),
      body: authToken != ""
          ? Column(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      if (playlistController.isLoading.value) {
                        return Column(
                          children: [
                            buildLazyloading(),
                            const SizedBox(height: 5),
                            buildLazyloading(),
                          ],
                        );
                      } else {
                        if (playlistController.playList.isNotEmpty) {
                          if (playlistController.playList[0].data!.isEmpty) {
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
                            return TranslateUpAnimation(
                              child: RefreshIndicator(
                                onRefresh: _pullRefresh,
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(left: 15),
                                  itemCount: playlistController
                                      .playList[0].data?.length,
                                  itemBuilder: (context, index) {
                                    var playlistData =
                                        playlistController.playList[0].data!;

                                    if (playlistData.isNotEmpty) {
                                      var data = playlistData[index];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width > 500
                                                          ? 26
                                                          : 20,
                                                      height: size.width > 500
                                                          ? 26
                                                          : 20,
                                                      child: Image.asset(
                                                        "assets/icons/following.png",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: size.width > 500
                                                            ? 10
                                                            : 5),
                                                    Text(
                                                      data.playlistName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              kTextsecondarytopColor,
                                                          fontSize:
                                                              size.width > 500
                                                                  ? 22
                                                                  : 14,
                                                          fontFamily:
                                                              kFuturaPTDemi),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showTypeBottomSheet(
                                                        data.id.toString(),
                                                        data.playlistName
                                                            .toString(),
                                                        data.privacyType
                                                            .toString(),
                                                        data.id.toString());
                                                  },
                                                  icon: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 25, top: 3),
                                                    width: size.width > 500
                                                        ? 24
                                                        : 18,
                                                    height: size.width > 500
                                                        ? 24
                                                        : 18,
                                                    child: Image.asset(
                                                      "assets/icons/dots.png",
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          data.videos!.isEmpty
                                              ? Center(
                                                  child: SizedBox(
                                                    width: Get.width - 80,
                                                    height: 130,
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 50.0, right: 15),
                                                      child: Text(
                                                        "Video not Found",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: kWhiteColor,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                kFuturaPTDemi),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: size.width > 500
                                                      ? 300
                                                      : 170,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        data.videos!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var discoverData =
                                                          data.videos;

                                                      if (discoverData!
                                                          .isEmpty) {
                                                        return const Center(
                                                          child: Text(
                                                            "No Video found",
                                                            style: TextStyle(
                                                                color:
                                                                    kWhiteColor,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    kFuturaPTDemi),
                                                          ),
                                                        );
                                                      } else {
                                                        var data =
                                                            discoverData[index];
                                                        int minutes =
                                                            (data.videoDurationInSeconds! /
                                                                    60)
                                                                .floor();
                                                        int seconds =
                                                            (data.videoDurationInSeconds! %
                                                                    60)
                                                                .toInt();
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(Routes
                                                                .videoDetailsPage);
                                                            upNextVideoController
                                                                .updateString(data
                                                                    .categoryId
                                                                    .toString());
                                                            commentsController
                                                                .updateString(data
                                                                    .id
                                                                    .toString());
                                                            videoDetailController
                                                                .videoId(data.id
                                                                    .toString());
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: size.width >
                                                                              500
                                                                          ? 250
                                                                          : 150,
                                                                      height: size.width >
                                                                              500
                                                                          ? 200
                                                                          : 100,
                                                                      child: Image
                                                                          .network(
                                                                        data.videoThumbnailImagePath
                                                                            .toString(),
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Image.asset(
                                                                          "assets/Opentrend_light_applogo.jpeg",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right: 10,
                                                                      top: 7,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color: const Color.fromARGB(
                                                                                135,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            borderRadius:
                                                                                BorderRadius.circular(4)),
                                                                        padding: EdgeInsets.all(size.width >
                                                                                500
                                                                            ? 10
                                                                            : 4),
                                                                        child:
                                                                            Text(
                                                                          "$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}",
                                                                          style: TextStyle(
                                                                              color: kWhiteColor,
                                                                              fontSize: size.width > 500 ? 16 : 12),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    SizedBox(
                                                                      width:
                                                                          130,
                                                                      child:
                                                                          Text(
                                                                        data.title
                                                                            .toString(),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                kTextsecondarytopColor,
                                                                            fontSize: size.width > 500
                                                                                ? 18
                                                                                : 14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "${data.numberOfViews.toString()} views",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextsecondarybottomColor,
                                                                          fontSize: size.width > 500
                                                                              ? 16
                                                                              : 12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          "No Video found",
                                          style: TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 15,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
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
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateAndEditPlaylistPage(
                          hadertitle: "Create",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width > 500 ? 300 : 200,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: size.width > 500 ? 1.5 : 0.9,
                            color: kButtonColor)),
                    child: Center(
                      child: Text(
                        "Create playlist",
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: size.width > 500 ? 26 : 16,
                            fontFamily: kFuturaPTDemi),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            )
          : isLoading
              ? SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      buildLazyloading(),
                      const SizedBox(height: 5),
                      buildLazyloading(),
                      const SizedBox(height: 5),
                      buildLazyloading(),
                    ],
                  ),
                )
              : const NoUserLoginScreen(),
    );
  }

  showTypeBottomSheet(
      String id, String name, String privacy, String playlistId) {
    int selectvalue = privacy == "Public"
        ? 0
        : privacy == "Friends"
            ? 1
            : privacy == "Only me"
                ? 2
                : 0;

    FocusScope.of(context).requestFocus(FocusNode());
    Size size = MediaQuery.of(context).size;
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
                          // var paymentLink = {
                          //   "headerName": "Edit",
                          // };
                          // Get.toNamed(Routes.createPlaylistPage,
                          //     parameters: paymentLink);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateAndEditPlaylistPage(
                                  hadertitle: "Edit",
                                  playlistid: id,
                                  playlistName: name,
                                  playlistPrivacy: selectvalue),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 9),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: kTextsecondarytopColor,
                                fontSize: size.width > 500 ? 18 : 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 0),
                        child: SizedBox(
                          width: Get.width - 25,
                          height: size.width > 500 ? 22 : 20,
                          child: CustomPaint(
                            painter: DottedLinePainter(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          removeConfirmationDialog(playlistId);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 12),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: kTextsecondarytopColor, fontSize: 16),
                          ),
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

  removeConfirmationDialog(String playlistId) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert !"),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: const Text("Delete Playlist?"),
        contentPadding: const EdgeInsets.only(left: 25, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              LoaderX.show(context, 70.0);
              await playlistService.removePlaylist(playlistId, userId).then(
                (value) async {
                  if (value['success'] == true) {
                    LoaderX.hide();
                    Get.offAll(() => const TabPage(
                          selectedTabIndex: 3,
                        ));
                    SnackbarUtils.showSnackbar(
                        "playlist successfully deleted", "");
                  } else {
                    LoaderX.hide();
                    SnackbarUtils.showErrorSnackbar(
                        "Failed to SignUp", value['message'].toString());
                  }
                  return null;
                },
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  buildLazyloading() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: kButtonSecondaryColor,
              highlightColor: kShimmerEffectSecondary,
              enabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width - 150,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150.0,
                          height: 100.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 150.0,
                          height: 100.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width - 100,
                      height: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width - 130,
                      height: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
