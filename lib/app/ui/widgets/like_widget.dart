import 'package:flutter/material.dart';

import '../../../config/constant/constant.dart';
import '../../services/like_service.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';

typedef StringCallback = void Function(String val);

// ignore: must_be_immutable
class LikeWidget extends StatefulWidget {
  final StringCallback callbackDate;
  final bool isLiked;
  final bool isdisLiked;
  final String? videoId;
  late int? likeCount = 0;
  late int? dislikeCount;
  LikeWidget(
      {Key? key,
      required this.isLiked,
      this.videoId,
      this.likeCount,
      this.dislikeCount,
      required this.isdisLiked,
      required this.callbackDate})
      : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLikedState = false;
  bool isdisLikedState = false;
  get getIsLikedState => isLikedState == true;
  get getIsdisLikedState => isdisLikedState == true;
  LikeStoryService likeStoryService = LikeStoryService();
  String likeeddata = "", dislikedData = "", authToken = "";

  @override
  void initState() {
    getToken();
    isLikedState = widget.isLiked;
    isdisLikedState = widget.isdisLiked;
    super.initState();
  }

  getToken() {
    var authTokenValue = box.read('authToken');
    setState(() {
      authToken = authTokenValue ?? "";
    });
  }

  Future _toggleIsLikedState() async {
    if (getIsLikedState) {
      setState(() => {
            isLikedState = false,
          });
      await likeStoryService.videoLike(widget.videoId).then(
        (value) {
          if (value["success"] == true) {
            setState(() {
              likeeddata = value['data'].toString();
            });
            widget.callbackDate(value["data"].toString());
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        },
      );
    } else {
      setState(() => {
            isdisLikedState = false,
            isLikedState = true,
          });
      if (!isdisLikedState) {
        await likeStoryService.videoDisLike(widget.videoId).then(
          (value) {
            if (value["success"] == true) {
              setState(() {
                dislikedData = value['data'].toString();
              });
              LoaderX.hide();
            } else {
              LoaderX.hide();
              SnackbarUtils.showErrorSnackbar(value["message"], "");
            }
          },
        );
      }
      await likeStoryService.videoLike(widget.videoId).then(
        (value) {
          if (value["success"] == true) {
            setState(() {
              likeeddata = value['data'].toString();
            });
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        },
      );
    }
  }

  Future _toggleIsDisLikedState() async {
    if (getIsdisLikedState) {
      setState(() => {
            isdisLikedState = false,
          });
      await likeStoryService.videoDisLike(widget.videoId).then(
        (value) {
          if (value["success"] == true) {
            setState(() {
              dislikedData = value['data'].toString();
            });
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        },
      );
    } else {
      setState(() => {
            isLikedState = false,
            isdisLikedState = true,
          });
      if (!isLikedState) {
        await likeStoryService.videoLike(widget.videoId).then(
          (value) {
            if (value["success"] == true) {
              setState(() {
                likeeddata = value['data'].toString();
              });
              LoaderX.hide();
            } else {
              LoaderX.hide();
              SnackbarUtils.showErrorSnackbar(value["message"], "");
            }
          },
        );
      }
      await likeStoryService.videoDisLike(widget.videoId).then(
        (value) {
          if (value["success"] == true) {
            setState(() {
              dislikedData = value['data'].toString();
            });
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            authToken == "" ? Container() : _toggleIsLikedState();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8),
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
                          "assets/icons/Like.png",
                          scale: 1.5,
                        ),
                      )
                    : SizedBox(
                        width: 18,
                        height: 17,
                        child: Image.asset(
                          "assets/icons/unLike.png",
                          scale: 1.5,
                        ),
                      ),
                widget.likeCount != "0"
                    ? const SizedBox(width: 5)
                    : Container(),
                widget.likeCount != "0"
                    ? Text(
                        likeeddata == ""
                            ? widget.likeCount.toString()
                            : likeeddata,
                        style: const TextStyle(
                            fontSize: 16, color: kButtonSecondaryColor),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            authToken == "" ? Container() : _toggleIsDisLikedState();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8),
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
                getIsdisLikedState
                    ? SizedBox(
                        width: 18,
                        height: 17,
                        child: Image.asset(
                          "assets/icons/disLike.png",
                          scale: 1.5,
                        ),
                      )
                    : SizedBox(
                        width: 18,
                        height: 17,
                        child: Image.asset(
                          "assets/icons/unDislike.png",
                          scale: 1.5,
                        ),
                      ),
                widget.dislikeCount != "0"
                    ? const SizedBox(width: 5)
                    : Container(),
                widget.dislikeCount != "0"
                    ? Text(
                        dislikedData == ""
                            ? widget.dislikeCount.toString()
                            : dislikedData,
                        style: const TextStyle(
                            fontSize: 16, color: kButtonSecondaryColor),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
