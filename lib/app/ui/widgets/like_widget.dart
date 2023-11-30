import 'package:flutter/material.dart';
import 'package:opentrend/app/ui/widgets/no_user_login_dialog.dart';

import '../../services/like_service.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';

typedef StringCallback = void Function(String val);

// ignore: must_be_immutable
class LikeWidget extends StatefulWidget {
  final bool isLiked;
  final bool isdisLiked;
  final String? videoId;
  late int? likeCount = 0;
  late int? dislikeCount = 0;
  LikeWidget({
    Key? key,
    required this.isLiked,
    this.videoId,
    this.likeCount,
    this.dislikeCount,
    required this.isdisLiked,
  }) : super(key: key);

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
    if (isLikedState) {
      setState(() =>
          {isLikedState = false, widget.likeCount = widget.likeCount! - 1});
      await likeStoryService.videoLike(widget.videoId).then((value) {
        if (value["success"] == true) {
          LoaderX.hide();
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(value["message"], "");
        }
      });
    } else {
      setState(() {
        isLikedState = true;
        widget.likeCount = (widget.likeCount! + 1);
      });
      if (isdisLikedState) {
        setState(() => {
              isdisLikedState = false,
              widget.dislikeCount = widget.dislikeCount! - 1,
            });
        await likeStoryService.videoDisLike(widget.videoId).then((value) {
          if (value["success"] == true) {
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        });
      }
      await likeStoryService.videoLike(widget.videoId).then((value) {
        if (value["success"] == true) {
          LoaderX.hide();
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(value["message"], "");
        }
      });
    }
  }

  Future _toggleIsDisLikedState() async {
    if (isdisLikedState) {
      setState(() => {
            isdisLikedState = false,
            widget.dislikeCount = widget.dislikeCount! - 1
          });
      await likeStoryService.videoDisLike(widget.videoId).then((value) {
        if (value["success"] == true) {
          LoaderX.hide();
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(value["message"], "");
        }
      });
    } else {
      setState(
        () => {
          isdisLikedState = true,
          widget.dislikeCount = (widget.dislikeCount! + 1)
        },
      );
      if (isLikedState) {
        setState(
          () => {
            isLikedState = false,
            widget.likeCount = widget.likeCount! - 1,
          },
        );
        await likeStoryService.videoLike(widget.videoId).then((value) {
          if (value["success"] == true) {
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        });
      }
      await likeStoryService.videoDisLike(widget.videoId).then((value) {
        if (value["success"] == true) {
          LoaderX.hide();
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(value["message"], "");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            authToken == "" ? loginConfirmationDialog() : _toggleIsLikedState();
          },
          child: Container(
            // height: 35,0
            padding: EdgeInsets.symmetric(
                horizontal: size.width > 500 ? 28 : 20.0,
                vertical: size.width > 500 ? 10 : 8),
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
                isLikedState
                    ? SizedBox(
                        width: size.width > 500 ? 23 : 18,
                        height: size.width > 500 ? 22 : 17,
                        child: Image.asset(
                          "assets/icons/Like.png",
                          scale: 1.5,
                        ),
                      )
                    : SizedBox(
                        width: size.width > 500 ? 23 : 18,
                        height: size.width > 500 ? 22 : 17,
                        child: Image.asset(
                          "assets/icons/unLike.png",
                          scale: 1.5,
                        ),
                      ),
                widget.likeCount != 0 ? const SizedBox(width: 5) : Container(),
                widget.likeCount != 0
                    ? Text(
                        widget.likeCount.toString(),
                        style: TextStyle(
                            fontSize: size.width > 500 ? 19 : 16,
                            color: kButtonSecondaryColor),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            authToken == ""
                ? loginConfirmationDialog()
                : _toggleIsDisLikedState();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width > 500 ? 28 : 20.0,
                vertical: size.width > 500 ? 10 : 8),
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
                isdisLikedState
                    ? SizedBox(
                        width: size.width > 500 ? 23 : 18,
                        height: size.width > 500 ? 22 : 17,
                        child: Image.asset(
                          "assets/icons/disLike.png",
                          scale: 1.5,
                        ),
                      )
                    : SizedBox(
                        width: size.width > 500 ? 23 : 18,
                        height: size.width > 500 ? 22 : 17,
                        child: Image.asset(
                          "assets/icons/unDislike.png",
                          scale: 1.5,
                        ),
                      ),
                widget.dislikeCount != 0
                    ? const SizedBox(width: 5)
                    : Container(),
                widget.dislikeCount != 0
                    ? Text(
                        widget.dislikeCount.toString(),
                        style: TextStyle(
                            fontSize: size.width > 500 ? 20 : 16,
                            color: kButtonSecondaryColor),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }

  loginConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoUserLoginDialog();
      },
    );
  }
}
