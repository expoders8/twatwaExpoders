import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../config/constant/constant.dart';
import '../../../config/provider/snackbar_provider.dart';
import '../../routes/app_pages.dart';
import '../../controller/playlist_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';
import '../../services/playlist_service.dart';
import '../home/tab_page.dart';

// ignore: must_be_immutable
class PlaylistWidget extends StatefulWidget {
  final String videoId;

  const PlaylistWidget({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  final PlaylistController playlistController = Get.put(PlaylistController());
  PlaylistService playlistService = PlaylistService();
  bool isChecked = false, isLikedState = false;
  get getIsLikedState => isLikedState == true;
  final selectedIndexes = [];
  final dataArray = [];
  String authToken = "";

  @override
  void initState() {
    getToken();
    if (authToken != "") {
      playlistController.fetchAllPlaylist();
    }
    super.initState();
  }

  getToken() {
    var authTokenValue = box.read('authToken');
    setState(() {
      authToken = authTokenValue ?? "";
    });
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
        return StatefulBuilder(
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
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    playlistController.playList[0].data?.length,
                                itemBuilder: (context, index) {
                                  var playlistData =
                                      playlistController.playList[0].data!;
                                  if (playlistData.isNotEmpty) {
                                    var data = playlistData[index];
                                    widget.videoId == data.id.toString();
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
                                                color: selectedIndexes
                                                        .contains(index)
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
                                          value:
                                              selectedIndexes.contains(index),
                                          onChanged: (bool? value) {
                                            if (selectedIndexes
                                                .contains(index)) {
                                              selectedIndexes.remove(index);
                                              dataArray.removeAt(index);
                                            } else {
                                              Map<String, dynamic>
                                                  playlistData = {
                                                'playlistId': data.id,
                                                'userId': data.userId,
                                                'videoId': widget.videoId,
                                                'isChecked': true,
                                              };
                                              dataArray.add(playlistData);
                                              selectedIndexes.add(index);
                                            }
                                            setState(() {});
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
                        onPressed: addToPlaylistinVideo,
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
      },
    );
  }

  addToPlaylistinVideo() async {
    LoaderX.show(context, 70.0);
    await playlistService.addVideoToPlaylist(dataArray).then(
      (value) async {
        if (value['success'] == true) {
          LoaderX.hide();
          Get.offAll(() => const TabPage(
                selectedTabIndex: 3,
              ));
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(
              "Failed to PlayList", value['message'].toString());
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            authToken == "" ? Container() : playlistbottomsheet();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: kButtonSecondaryColor, width: 1),
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
                getIsLikedState
                    ? SizedBox(
                        width: 18,
                        height: 17,
                        child: Image.asset(
                          "assets/icons/playlist.png",
                          scale: 1.5,
                        ),
                      )
                    : SizedBox(
                        width: 18,
                        height: 17,
                        child: Image.asset(
                          "assets/icons/unplaylist.png",
                          scale: 1.5,
                        ),
                      ),
                // const SizedBox(width: 5),
                // const Text(
                //   "105",
                //   style: TextStyle(fontSize: 14, color: kButtonSecondaryColor),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
