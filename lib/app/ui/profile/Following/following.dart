import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/video_service.dart';
import '../../../services/follower_service.dart';
import '../../../../config/constant/constant.dart';
import '../../../controller/follower_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/dotted_line_provider.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final FollowingController followingController =
      Get.put(FollowingController());
  FollowerService followerService = FollowerService();
  VideoService videoService = VideoService();
  String userId = "";
  @override
  void initState() {
    getUser();
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
      body: Obx(
        () {
          if (followingController.isLoading.value) {
            return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: buildLazyloading());
          } else {
            if (followingController.followerList.isNotEmpty) {
              if (followingController.followerList[0].data!.isEmpty) {
                return Center(
                  child: SizedBox(
                    width: Get.width - 80,
                    child: const Text(
                      "Followers not Found",
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
                  itemCount: followingController.followerList[0].data?.length,
                  itemBuilder: (context, index) {
                    var followerData =
                        followingController.followerList[0].data!;

                    if (followerData.isNotEmpty) {
                      var data = followerData[index];
                      var followcheck = data.numberOfFollowers == 0 ||
                              data.numberOfFollowers == 1
                          ? "Follwer"
                          : "Follwers";
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          data.profilePhoto.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            "assets/images/blank_profile.png",
                                            fit: BoxFit.fill,
                                          ),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data.userName.toString(),
                                            style: const TextStyle(
                                                color: kTextsecondarytopColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${data.numberOfFollowers} $followcheck",
                                            style: const TextStyle(
                                              color: kTextsecondarybottomColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    userUnfollowDialog(
                                        data.followeeId.toString(),
                                        data.profilePhoto.toString(),
                                        data.userName.toString());
                                    // if (data.isMyFollower == true) {
                                    //   setState(() {
                                    //     setState(() {
                                    //       data.isMyFollower = false;
                                    //     });
                                    //   });
                                    // } else {
                                    //   if (data.isMyFollowing == false) {
                                    //     setState(() {
                                    //       data.isMyFollowing = true;
                                    //     });
                                    //   }
                                    // }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 85,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: data.isMyFollower == true
                                              ? kButtonColor
                                              : kBackGroundColor,
                                          border: Border.all(
                                              width: 1,
                                              color: data.isMyFollowing == true
                                                  ? kButtonColor
                                                  : kButtonSecondaryColor),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Center(
                                        child: Text(
                                          data.isMyFollowing == true
                                              ? "Following"
                                              : "UNFOLLOW",
                                          style: TextStyle(
                                              color: data.isMyFollowing == true
                                                  ? kWhiteColor
                                                  : kButtonSecondaryColor,
                                              fontSize: 13,
                                              fontFamily: kFuturaPTDemi),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width - 25,
                            height: 10,
                            child: CustomPaint(
                              painter: DottedLinePainter(),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Followers not Found",
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
                  "Followers not Found",
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
    );
  }

  userUnfollowDialog(
      String followeeId, String profilePhoto, String userName) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: SizedBox(
            height: 90,
            width: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                profilePhoto,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/blank_profile.png",
                  fit: BoxFit.fill,
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
        ),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: Text(
            textAlign: TextAlign.center,
            "If you chnage your mind,you'll \nhave to request to follow \n$userName again."),
        contentPadding: const EdgeInsets.only(left: 0, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              followerService.followAndUnfollow(followeeId).then(
                    (value) => {
                      if (value['success'])
                        {
                          followingController.fetchAllfollowing(),
                          videoService.getMyAnalytics(userId)
                        }
                    },
                  );
            },
            child: const Text(
              'Unfollow',
              style: TextStyle(fontSize: 16, color: kButtonColor),
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

  buildLazyloading() {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: 6,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 10),
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
}
