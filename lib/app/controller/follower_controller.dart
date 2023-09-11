import 'package:get/get.dart';

import '../models/follower_model.dart';
import '../services/follower_service.dart';

class FollowerController extends GetxController {
  var isLoading = true.obs;
  var followerList = <GetFollower>[].obs;
  FollowerService followerService = FollowerService();
  @override
  void onInit() {
    fetchAllfollower();
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
  @override
  void onInit() {
    fetchAllfollowing();
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
