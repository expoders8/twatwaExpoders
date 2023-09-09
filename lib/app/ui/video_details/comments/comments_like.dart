import 'package:flutter/material.dart';

import '../../../../config/constant/color_constant.dart';
import '../../../../config/constant/constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';
import '../../../services/comment_service.dart';
import '../../widgets/no_user_login_dialog.dart';

// ignore: must_be_immutable
class CommnetsLikeWidget extends StatefulWidget {
  final bool isLiked;
  final String? commentsId;
  late int? likeCount = 0;
  CommnetsLikeWidget({
    Key? key,
    required this.isLiked,
    this.commentsId,
    this.likeCount,
  }) : super(key: key);

  @override
  State<CommnetsLikeWidget> createState() => _CommnetsLikeWidgetState();
}

class _CommnetsLikeWidgetState extends State<CommnetsLikeWidget> {
  bool isLikedState = false;
  get getIsLikedState => isLikedState == true;
  CommnetsService commnetsService = CommnetsService();
  String likeeddata = "", dislikedData = "", authToken = "";

  @override
  void initState() {
    getToken();
    isLikedState = widget.isLiked;
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
      setState(() =>
          {isLikedState = false, widget.likeCount = widget.likeCount! - 1});
      await commnetsService.likeComment(widget.commentsId).then(
        (value) {
          if (value["success"] == true) {
            LoaderX.hide();
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(value["message"], "");
          }
        },
      );
    } else {
      setState(() => {
            isLikedState = true,
            widget.likeCount = (widget.likeCount! + 1),
          });
      await commnetsService.likeComment(widget.commentsId).then(
        (value) {
          if (value["success"] == true) {
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
            authToken == "" ? loginConfirmationDialog() : _toggleIsLikedState();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8),
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
                // ignore: unrelated_type_equality_checks
                widget.likeCount != "0"
                    ? const SizedBox(width: 5)
                    : Container(),
                // ignore: unrelated_type_equality_checks
                widget.likeCount != "0"
                    ? Text(
                        widget.likeCount.toString(),
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

  loginConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoUserLoginDialog();
      },
    );
  }
}
