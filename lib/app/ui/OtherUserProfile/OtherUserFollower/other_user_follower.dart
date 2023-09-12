import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/constant/constant.dart';
import '../../../controller/follower_controller.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/dotted_line_provider.dart';

class OtherUserFollowersPage extends StatefulWidget {
  final String? userId;
  const OtherUserFollowersPage({super.key, this.userId});

  @override
  State<OtherUserFollowersPage> createState() => _OtherUserFollowersPageState();
}

class _OtherUserFollowersPageState extends State<OtherUserFollowersPage> {
  final OtherUserFollowerController otherUserFollowerController =
      Get.put(OtherUserFollowerController());
  String userId = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otherUserFollowerController.selectedOtherUserId(widget.userId);
      otherUserFollowerController.fetchAllOtherfollower();
      getUser();
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
    otherUserFollowerController.selectedOtherUserId(widget.userId);
    return Scaffold(
      body: Obx(
        () {
          if (otherUserFollowerController.isLoading.value) {
            return buildLazyloading();
          } else {
            if (otherUserFollowerController.followerList.isNotEmpty) {
              if (otherUserFollowerController.followerList[0].data!.isEmpty) {
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
                  itemCount:
                      otherUserFollowerController.followerList[0].data?.length,
                  itemBuilder: (context, index) {
                    var followerData =
                        otherUserFollowerController.followerList[0].data!;

                    if (followerData.isNotEmpty) {
                      var data = followerData[index];
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
                                            data.numberOfFollowers.toString(),
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
                                    if (data.isMyFollower == true) {
                                      setState(() {
                                        setState(() {
                                          data.isMyFollower = false;
                                        });
                                      });
                                    } else {
                                      if (data.isMyFollower == false) {
                                        setState(() {
                                          data.isMyFollower = true;
                                        });
                                      }
                                    }
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
                                              color: data.isMyFollower == true
                                                  ? kButtonColor
                                                  : kButtonSecondaryColor),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Center(
                                        child: Text(
                                          data.isMyFollower == true
                                              ? "FOLLOW"
                                              : "UNFOLLOW",
                                          style: TextStyle(
                                              color: data.isMyFollower == true
                                                  ? kWhiteColor
                                                  : kButtonSecondaryColor,
                                              fontSize: 11,
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

  buildLazyloading() {
    return Padding(
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
    );
  }
}
