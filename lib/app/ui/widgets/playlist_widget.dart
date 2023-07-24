// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';

class PlaylistWidget extends StatefulWidget {
  final bool isLiked;
  final String? storyId;
  late int? likeCount = 0;
  PlaylistWidget(
      {Key? key, required this.isLiked, this.storyId, this.likeCount})
      : super(key: key);

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  bool isLikedState = false;
  get getIsLikedState => isLikedState == true;

  @override
  void initState() {
    isLikedState = widget.isLiked;
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleIsLikedState,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 8),
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
                const SizedBox(width: 5),
                const Text(
                  "105",
                  style: TextStyle(fontSize: 14, color: kButtonSecondaryColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
