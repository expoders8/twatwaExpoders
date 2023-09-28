import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../controller/video_controller.dart';
import '../controller/playlist_controller.dart';
import '../controller/getall_video_landing_controller.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;
  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    final VideoOfTheDayController videoOfTheDayController =
        Get.put(VideoOfTheDayController());
    final GetAllVideoLandingController videoController =
        Get.put(GetAllVideoLandingController());
    if (connectivityResult == ConnectivityResult.none) {
      Get.toNamed(Routes.noInternetScreen);
      isConnected.value = false;
    } else {
      videoOfTheDayController.fetchVideoOfTheDay();
      videoController.fetchAllLandingVideos();
      isConnected.value = true;
      Get.back();
    }
  }

  void checkInitialConnectivity() async {
    final VideoOfTheDayController videoOfTheDayController =
        Get.put(VideoOfTheDayController());
    final GetAllVideoLandingController videoController =
        Get.put(GetAllVideoLandingController());
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.toNamed(Routes.noInternetScreen);
      isConnected.value = false;
    } else {
      isConnected.value = true;
      videoOfTheDayController.fetchVideoOfTheDay();
      videoController.fetchAllLandingVideos();
      Get.back();
    }
  }
}

class ApiController extends GetxController {
  var connectivityStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((result) {
      connectivityStatus.value = result;
    });
  }

  bool shouldMakeApiCall() {
    final connectivity = connectivityStatus.value;
    return connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi;
  }
}
