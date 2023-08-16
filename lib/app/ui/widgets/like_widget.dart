// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';

class LikeWidget extends StatefulWidget {
  final bool isLiked;
  final bool isdisLiked;
  final String? storyId;
  late int? likeCount = 0;
  late int? dislikeCount = 0;
  LikeWidget(
      {Key? key,
      required this.isLiked,
      this.storyId,
      this.likeCount,
      this.dislikeCount,
      required this.isdisLiked})
      : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLikedState = false;
  bool isdisLikedState = false;
  get getIsLikedState => isLikedState == true;
  get getIsdisLikedState => isdisLikedState == true;

  @override
  void initState() {
    isLikedState = widget.isLiked;
    isdisLikedState = widget.isdisLiked;
    super.initState();
  }

  Future _toggleIsLikedState() async {
    if (getIsLikedState) {
      setState(() =>
          {isLikedState = false, widget.likeCount = widget.likeCount! - 1});
    } else {
      setState(() =>
          {isLikedState = true, widget.likeCount = (widget.likeCount! + 1)});
    }
  }

  Future _toggleIsDisLikedState() async {
    setState(() {
      isdisLikedState = false;
    });
    if (getIsdisLikedState) {
      setState(() => {
            isdisLikedState = false,
            widget.dislikeCount = widget.dislikeCount! - 1
          });
    } else {
      setState(() => {
            isdisLikedState = true,
            widget.dislikeCount = (widget.dislikeCount! + 1)
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleIsLikedState,
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
                        widget.likeCount.toString(),
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
          onTap: _toggleIsDisLikedState,
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
                        widget.dislikeCount.toString(),
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
