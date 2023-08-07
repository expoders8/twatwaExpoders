import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/constant/color_constant.dart';

class CommentReplyPage extends StatefulWidget {
  const CommentReplyPage({super.key});

  @override
  State<CommentReplyPage> createState() => _CommentReplyPageState();
}

class _CommentReplyPageState extends State<CommentReplyPage> {
  bool isLikedState = false, isdisLikedState = false, iconshow = false;
  int likeCount = 0;
  int dislikeCount = 0;
  get getIsLikedState => isLikedState == true;
  get getIsdisLikedState => isdisLikedState == true;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    isLikedState = false;
    isdisLikedState = false;
    super.initState();
  }

  Future _toggleIsLikedState() async {
    if (getIsLikedState) {
      setState(() => {isLikedState = false, likeCount = likeCount - 1});
    } else {
      setState(() => {isLikedState = true, likeCount = (likeCount + 1)});
    }
  }

  Future _toggleIsDisLikedState() async {
    setState(() {
      isdisLikedState = false;
    });
    if (getIsdisLikedState) {
      setState(
          () => {isdisLikedState = false, dislikeCount = dislikeCount - 1});
    } else {
      setState(
          () => {isdisLikedState = true, dislikeCount = (dislikeCount + 1)});
    }
  }

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
        title: Row(
          children: [
            SizedBox(
              height: 42,
              width: 42,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/authBackground.png",
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
                        "Jenny Smith",
                        style: TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "23 Replices",
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
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height - 170,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                scrollDirection: Axis.vertical,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Card(
                    color: kCardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/images/authBackground.png",
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Amelia John",
                                          style: TextStyle(
                                            color: kTextsecondarybottomColor,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(left: 140),
                                        child: const Text(
                                          "5 Days Ago",
                                          style: TextStyle(
                                            color: kTextsecondarybottomColor,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 260,
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: const Text(
                                      "Whoever reading this, you’ll be successful Someday^ Just keep on pushing.🤟🤟🤟",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: kTextsecondarytopColor,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: _toggleIsLikedState,
                                        child: Container(
                                          height: 35,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              getIsLikedState
                                                  ? SizedBox(
                                                      width: 15,
                                                      height: 15,
                                                      child: Image.asset(
                                                        "assets/icons/Like.png",
                                                        scale: 1.5,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: 15,
                                                      height: 15,
                                                      child: Image.asset(
                                                        "assets/icons/unLike.png",
                                                        scale: 1.5,
                                                      ),
                                                    ),
                                              likeCount != 0
                                                  ? const SizedBox(width: 5)
                                                  : Container(),
                                              likeCount != 0
                                                  ? Text(
                                                      likeCount.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              kButtonSecondaryColor),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "|",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: kButtonSecondaryColor),
                                      ),
                                      GestureDetector(
                                        onTap: _toggleIsDisLikedState,
                                        child: Container(
                                          height: 35,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              getIsdisLikedState
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0),
                                                      child: SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child: Image.asset(
                                                          "assets/icons/disLike.png",
                                                          scale: 1.5,
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0),
                                                      child: SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child: Image.asset(
                                                          "assets/icons/unDislike.png",
                                                          scale: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                              dislikeCount != 0
                                                  ? const SizedBox(width: 5)
                                                  : Container(),
                                              dislikeCount != 0
                                                  ? Text(
                                                      dislikeCount.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              kButtonSecondaryColor),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "|",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: kButtonSecondaryColor),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 35,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.0, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                                child: Image.asset(
                                                  "assets/icons/Reply.png",
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "23 REPLY",
                                                style: TextStyle(
                                                    fontSize: 12.5,
                                                    color:
                                                        kButtonSecondaryColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 10, 13, 3),
              child: TextFormField(
                style: const TextStyle(color: kWhiteColor),
                decoration: InputDecoration(
                  hintText: "Reply@ Jenny Smith",
                  hintStyle: const TextStyle(color: kWhiteColor),
                  labelStyle: const TextStyle(color: kWhiteColor),
                  contentPadding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
                  fillColor: kCardColor,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(color: kCardColor),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: kCardColor)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(color: kCardColor),
                  ),
                  suffixIcon: iconshow
                      ? InkWell(
                          child: const Icon(
                            Icons.send,
                            size: 30,
                            color: kButtonSecondaryColor,
                          ),
                          onTap: () {
                            commentController.clear();
                          },
                        )
                      : null,
                ),
                controller: commentController,
                onChanged: (value) {
                  if (commentController.text != "") {
                    setState(() {
                      iconshow = true;
                    });
                  } else {
                    setState(() {
                      iconshow = false;
                    });
                  }
                },
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
