import 'package:get/get.dart';

import '../models/follower_model.dart';
import '../services/follower_service.dart';
import '../controller/network_controller.dart';

class FollowerController extends GetxController {
  var isLoading = true.obs;
  var followerList = <GetFollower>[].obs;
  FollowerService followerService = FollowerService();
  final NetworkController networkController = Get.put(NetworkController());
  @override
  void onInit() {
    if (networkController.isConnected.value) {
      fetchAllfollower();
    }
    super.onInit();
  }

  void fetchAllfollower() async {
    try {
      isLoading(true);
      var data = await followerService.getAllFollower();
      followerList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}

class FollowingController extends GetxController {
  var isLoading = true.obs;
  var followerList = <GetFollower>[].obs;
  FollowerService followerService = FollowerService();
  final NetworkController networkController = Get.put(NetworkController());

  @override
  void onInit() {
    if (networkController.isConnected.value) {
      fetchAllfollowing();
    }
    super.onInit();
  }

  void fetchAllfollowing() async {
    try {
      isLoading(true);
      var data = await followerService.getAllFollowing();
      followerList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}

class OtherUserFollowerController extends GetxController {
  var isLoading = true.obs;
  var followerList = <GetFollower>[].obs;
  FollowerService followerService = FollowerService();
  RxString selectedOtherUserId = RxString("");

  void fetchAllOtherfollower() async {
    try {
      isLoading(true);
      var data = await followerService.getAllOtherUserFollower(
          selectedOtherUserId.toString(), "");
      followerList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}

class OtherUserFollowingController extends GetxController {
  var isLoading = true.obs;
  var followerList = <GetFollower>[].obs;
  FollowerService followerService = FollowerService();
  RxString selectedOtherUserId = RxString("");

  void fetchAllOtherfollowing() async {
    try {
      isLoading(true);
      var data = await followerService.getAllOtherUserFollower(
          selectedOtherUserId.toString(), "following");
      followerList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
