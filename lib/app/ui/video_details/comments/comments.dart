import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../comments/comments_reply.dart';
import '../../../services/comment_service.dart';
import '../../widgets/no_user_login_dialog.dart';
import '../../../../config/constant/constant.dart';
import '../../../controller/comments_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../video_details/comments/comments_like.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';

class CommentsPage extends StatefulWidget {
  final String videoId;
  const CommentsPage({super.key, required this.videoId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final CommentsController commentsController = Get.put(CommentsController());
  CommnetsService commnetsService = CommnetsService();
  bool iconshow = false;
  String userId = "", authToken = "";
  TextEditingController commentController = TextEditingController();

  Future getUser() async {
    var data = box.read('user');
    var authTokenValue = box.read('authToken');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userId = getUserData['id'] ?? "";
        authToken = authTokenValue ?? "";
      });
    }
  }

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            authToken != ""
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(13, 5, 13, 0),
                    child: TextFormField(
                      style: const TextStyle(color: kWhiteColor),
                      decoration: InputDecoration(
                        hintText: "Enter your comment",
                        hintStyle:
                            const TextStyle(color: kButtonSecondaryColor),
                        labelStyle: const TextStyle(color: kWhiteColor),
                        contentPadding:
                            const EdgeInsets.fromLTRB(17, 17, 17, 17),
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
                  )
                : Container(),
            Expanded(
              child: Scaffold(
                backgroundColor: kBackGroundColor,
                body: Obx(
                  () {
                    if (commentsController.isLoading.value) {
                      return SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            buildLazyloading(),
                          ],
                        ),
                      );
                    } else {
                      if (commentsController.commentList[0].data != null) {
                        if (commentsController.commentList[0].data!.isEmpty) {
                          return Center(
                            child: SizedBox(
                              width: Get.width - 80,
                              child: const Text(
                                "Video not Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                    fontFamily: kFuturaPTDemi),
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 10),
                                  scrollDirection: Axis.vertical,
                                  itemCount: commentsController
                                      .commentList[0].data!.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0 &&
                                        commentsController.isAddingMore.value) {
                                      return SingleChildScrollView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            buildLazyloading(),
                                            buildLazyloading(),
                                            buildLazyloading(),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var discoverData = commentsController
                                          .commentList[0].data!;

                                      if (discoverData.isNotEmpty) {
                                        var data = discoverData[index];
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(
                                                    data.createdOn.toString()));
                                        String formattedTime =
                                            DateFormat('HH:mm:ss').format(
                                                DateTime.parse(
                                                    data.createdOn.toString()));
                                        final splittedDate =
                                            formattedDate.split("-");
                                        final splittedTime =
                                            formattedTime.split(":");
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                                          loadingBuilder:
                                                              (BuildContext
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
                                                                  color:
                                                                      kWhiteColor,
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
                                                          CrossAxisAlignment
                                                              .start,
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
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 140,
                                                                      top: 6),
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
                                                        const SizedBox(
                                                            height: 10),
                                                        Container(
                                                          width: 250,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            data.comment
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color:
                                                                    kTextsecondarytopColor,
                                                                fontSize: 12.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            CommnetsLikeWidget(
                                                              isLiked:
                                                                  data.isLiked,
                                                              likeCount: data
                                                                  .totalCommentLikes,
                                                              commentsId:
                                                                  data.id,
                                                            ),
                                                            const Text(
                                                              "|",
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color:
                                                                      kButtonSecondaryColor),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                authToken != ""
                                                                    ? Navigator.of(
                                                                            context)
                                                                        .push(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CommentReplyPage(
                                                                            videoId:
                                                                                widget.videoId,
                                                                            commentId:
                                                                                data.id.toString(),
                                                                            commentImage:
                                                                                data.commentUserProfilePhoto,
                                                                            userName:
                                                                                data.commentUserName,
                                                                            totalComment:
                                                                                data.totalCommentReplies.toString(),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : loginConfirmationDialog();
                                                              },
                                                              child: Container(
                                                                height: 35,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        19.0,
                                                                    vertical:
                                                                        8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 16,
                                                                      height:
                                                                          16,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/icons/Reply.png",
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Text(
                                                                      "${data.totalCommentReplies} REPLY",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              kButtonSecondaryColor),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 58),
                                                            IconButton(
                                                              onPressed: () {
                                                                authToken != ""
                                                                    ? showTypeBottomSheet(data
                                                                        .id
                                                                        .toString())
                                                                    : loginConfirmationDialog();
                                                              },
                                                              icon: SizedBox(
                                                                width: 16,
                                                                height: 16,
                                                                child:
                                                                    Image.asset(
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
                                          child: Text(
                                            "Video not Found",
                                            textAlign: TextAlign.center,
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
                              if (commentsController.isAddingMore.value)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: kShimmerEffectSecondary,
                                  ),
                                )
                            ],
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                            "Video not Found",
                            textAlign: TextAlign.center,
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
            ),
          ],
        ),
      ),
    );
  }

  commentSend() async {
    FocusScope.of(context).requestFocus(FocusNode());
    LoaderX.show(context, 70.0);
    await commnetsService
        .addComment(userId, widget.videoId, commentController.text, "", "")
        .then(
          (value) => {
            if (value['success'])
              {
                LoaderX.hide(),
                commentController.clear(),
                commentsController.fetchComment()
              },
          },
        );
  }

  buildLazyloading() {
    return SizedBox(
      height: 400,
      child: Padding(
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
      ),
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
                    // commnetsService.getAllComments(createRequest());
                    commentsController.fetchComment();
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

  loginConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoUserLoginDialog();
      },
    );
  }
}
