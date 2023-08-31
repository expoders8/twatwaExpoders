import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:opentrend/app/ui/favourite/create_and_edit_playlist.dart';

import '../home/tab_page.dart';
import '../widgets/appbar.dart';
import '../../routes/app_pages.dart';
import '../../services/playlist_service.dart';
import '../../../config/constant/constant.dart';
import '../../controller/playlist_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/video_detail_controller.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';
import '../../../config/provider/dotted_line_provider.dart';
import '../widgets/no_user_login_screen.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final PlaylistController playlistController = Get.put(PlaylistController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());

  PlaylistService playlistService = PlaylistService();
  String userId = "", authToken = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
      if (authToken != "") {
        playlistController.fetchAllPlaylist();
      }
    });

    super.initState();
  }

  Future getUser() async {
    var data = box.read('user');
    var authTokenValue = box.read('authToken');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        authToken = authTokenValue ?? "";
        userId = getUserData['id'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Platform.isAndroid ? 60 : 95),
        child: const Padding(
          padding: EdgeInsets.only(top: 40.0, left: 20, right: 5),
          child: AppBarWidget(
            title: 'Favourite',
          ),
        ),
      ),
      body: authToken != ""
          ? Column(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      if (playlistController.isLoading.value) {
                        return LoaderUtils.showLoader();
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
                            return ListView.builder(
                              padding: const EdgeInsets.only(left: 15),
                              itemCount:
                                  playlistController.playList[0].data?.length,
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
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                Text(
                                                  data.playlistName.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          kTextsecondarytopColor,
                                                      fontSize: 14,
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
                                                    data.privacyType.toString(),
                                                    data.id.toString());
                                              },
                                              icon: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 25, top: 3),
                                                width: 18,
                                                height: 18,
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
                                                    textAlign: TextAlign.center,
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
                                              height: 170,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: data.videos!.length,
                                                itemBuilder: (context, index) {
                                                  var discoverData =
                                                      data.videos;

                                                  if (discoverData!.isEmpty) {
                                                    return const Center(
                                                      child: Text(
                                                        "No Video found",
                                                        style: TextStyle(
                                                            color: kWhiteColor,
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
                                                                    .all(8.0),
                                                            child: Stack(
                                                              children: [
                                                                SizedBox(
                                                                  width: 150,
                                                                  height: 100,
                                                                  child: Image
                                                                      .network(
                                                                    data.videoThumbnailImagePath
                                                                        .toString(),
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Image
                                                                            .asset(
                                                                      "assets/images/tranding1.png",
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
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(4),
                                                                    child: Text(
                                                                      "$minutes : $seconds",
                                                                      style: const TextStyle(
                                                                          color:
                                                                              kWhiteColor,
                                                                          fontSize:
                                                                              12),
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
                                                                    left: 8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    height: 10),
                                                                SizedBox(
                                                                  width: 130,
                                                                  child: Text(
                                                                    data.title
                                                                        .toString(),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        color:
                                                                            kTextsecondarytopColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "${data.numberOfViews.toString()} views",
                                                                  style: const TextStyle(
                                                                      color:
                                                                          kTextsecondarybottomColor,
                                                                      fontSize:
                                                                          12),
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
                    width: 200,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 0.9, color: kButtonColor)),
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
                        child: const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 9),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: kTextsecondarytopColor, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 0),
                        child: SizedBox(
                          width: Get.width - 25,
                          height: 20,
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
                        "Failed to SignUp", value.message.toString());
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
}
