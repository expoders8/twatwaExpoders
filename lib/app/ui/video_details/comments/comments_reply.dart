import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/constant/constant.dart';
import '../../../../config/provider/snackbar_provider.dart';
import '../comments/comments_like.dart';
import '../../../services/comment_service.dart';
import '../../../controller/comments_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';

class CommentReplyPage extends StatefulWidget {
  final String? videoId;
  final String? commentId;
  final String? commentImage;
  final String? userName;
  final String? totalComment;
  const CommentReplyPage(
      {super.key,
      this.videoId,
      this.commentId,
      this.commentImage,
      this.userName,
      this.totalComment});

  @override
  State<CommentReplyPage> createState() => _CommentReplyPageState();
}

class _CommentReplyPageState extends State<CommentReplyPage> {
  final ReplayCommentsController replayCommentsController =
      Get.put(ReplayCommentsController());
  final CommentsController commentsController = Get.put(CommentsController());
  CommnetsService commnetsService = CommnetsService();
  bool isLikedState = false, iconshow = false;
  String userId = "";
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
      replayCommentsController.fetchReply(
          widget.videoId.toString(), userId, widget.commentId.toString());
    });

    super.initState();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userId = getUserData['id'] ?? "";
      });
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
            commentsController.fetchComments(widget.videoId.toString(), userId);
            FocusScope.of(context).requestFocus(FocusNode());
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
                child: Image.network(
                  widget.commentImage.toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/blank_profile.png",
                    fit: BoxFit.contain,
                  ),
                  loadingBuilder: (BuildContext context, Widget child,
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
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName.toString(),
                        style: const TextStyle(
                            color: kTextsecondarytopColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${widget.totalComment} Replices",
                        style: const TextStyle(
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
      body: WillPopScope(
        onWillPop: () {
          commentsController.fetchComments(widget.videoId.toString(), userId);
          FocusScope.of(context).requestFocus(FocusNode());
          Get.back();
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height - 170,
                  child: Obx(
                    () {
                      if (replayCommentsController.isLoading.value) {
                        return buildLazyloading();
                      } else {
                        if (replayCommentsController.commentList.isNotEmpty) {
                          if (replayCommentsController
                              .commentList[0].data!.isEmpty) {
                            return Center(
                              child: SizedBox(
                                width: Get.width - 80,
                                child: const Text(
                                  "Comments not Found",
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
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                              scrollDirection: Axis.vertical,
                              itemCount: replayCommentsController
                                  .commentList[0].data?.length,
                              itemBuilder: (context, index) {
                                var discoverData = replayCommentsController
                                    .commentList[0].data!;
                                if (discoverData.isNotEmpty) {
                                  var data = discoverData[index];
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(
                                              data.createdOn.toString()));
                                  String formattedTime = DateFormat('HH:mm:ss')
                                      .format(DateTime.parse(
                                          data.createdOn.toString()));
                                  final splittedDate = formattedDate.split("-");
                                  final splittedTime = formattedTime.split(":");
                                  final date1 = DateTime(
                                    int.parse(splittedDate[0]),
                                    int.parse(splittedDate[1]),
                                    int.parse(splittedDate[2]),
                                    int.parse(splittedTime[0]),
                                    int.parse(splittedTime[1]),
                                    int.parse(splittedTime[2]),
                                  );
                                  final date2 = DateTime.now();
                                  final difference =
                                      date2.difference(date1).inDays;
                                  final differenceHour =
                                      date2.difference(date1).inHours;
                                  final differenceMinute =
                                      date2.difference(date1).inMinutes;
                                  return Card(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    data.commentUserProfilePhoto
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      "assets/images/blank_profile.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return SizedBox(
                                                        width: 17,
                                                        height: 17,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
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
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 6),
                                                        child: Text(
                                                          data.commentUserName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                kTextsecondarybottomColor,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 140, top: 6),
                                                        child: Text(
                                                          difference >= 1
                                                              ? "${difference.toString()} Days ago"
                                                              : differenceHour >=
                                                                      1
                                                                  ? "${differenceHour.toString()} Hours ago"
                                                                  : "${differenceMinute.toString()} Minits ago",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                kTextsecondarybottomColor,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    width: 250,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      data.comment.toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              kTextsecondarytopColor,
                                                          fontSize: 12.5,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CommnetsLikeWidget(
                                                        isLiked: data.isLiked,
                                                        likeCount: data
                                                            .totalCommentLikes,
                                                        commentsId: data.id,
                                                      ),
                                                      const SizedBox(
                                                          width: 167),
                                                      IconButton(
                                                        onPressed: () {
                                                          showTypeBottomSheet(
                                                              data.id
                                                                  .toString());
                                                        },
                                                        icon: SizedBox(
                                                          width: 16,
                                                          height: 16,
                                                          child: Image.asset(
                                                            "assets/icons/dots.png",
                                                          ),
                                                        ),
                                                      )
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
                                } else {
                                  return const Center(
                                    child: Text("No Comments found"),
                                  );
                                }
                              },
                            );
                          }
                        } else {
                          return const Center(
                            child: Text("No Comments found"),
                          );
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 10, 13, 3),
                  child: TextFormField(
                    style: const TextStyle(color: kWhiteColor),
                    decoration: InputDecoration(
                      hintText: "Reply@ ${widget.userName}",
                      hintStyle: const TextStyle(color: kButtonSecondaryColor),
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
                                commentSend();
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
        ),
      ),
    );
  }

  buildLazyloading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 0),
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
                  itemCount: 6,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
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
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
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
          ],
        ),
      ),
    );
  }

  commentSend() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // LoaderX.show(context, 70.0);
    await commnetsService
        .addComment(userId, widget.videoId, commentController.text,
            widget.commentId, "reply")
        .then(
          (value) => {
            if (value['success'])
              {
                LoaderX.hide(),
                commentController.clear(),
                replayCommentsController.fetchReply(widget.videoId.toString(),
                    userId, widget.commentId.toString()),
                commentsController.fetchComments(
                    widget.videoId.toString(), userId)
              },
          },
        );
  }

  showTypeBottomSheet(String commentId) {
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
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          removeConfirmationDialog(commentId);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.delete,
                                color: kTextsecondarytopColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 16),
                              ),
                            ],
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

  removeConfirmationDialog(String commentId) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete comment"),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: const Text("Delete your comment \npermanently?"),
        contentPadding: const EdgeInsets.only(left: 25, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              LoaderX.show(context, 70.0);
              await commnetsService.removeComment(commentId).then(
                (value) async {
                  if (value['success'] == true) {
                    LoaderX.hide();
                    replayCommentsController.fetchReply(
                        widget.videoId.toString(),
                        userId,
                        widget.commentId.toString());
                    SnackbarUtils.showSnackbar(
                        "Comment Successfully Deleted", "");
                  } else {
                    LoaderX.hide();
                    SnackbarUtils.showErrorSnackbar(
                        "Failed to Comment", value['message'].toString());
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
