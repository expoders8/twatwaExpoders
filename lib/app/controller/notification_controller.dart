import 'package:get/get.dart';
import '../controller/network_controller.dart';

import '../../config/constant/constant.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationController extends GetxController {
  var isLoading = true.obs;
  var notificationList = <GetAllNotification>[].obs;
  NotificationService notificationService = NotificationService();
  final NetworkController networkController = Get.put(NetworkController());
  @override
  void onInit() {
    var token = box.read('authToken') ?? "";
    if (networkController.isConnected.value) {
      if (token != "") {
        fetchAllNotification();
      }
    }
    super.onInit();
  }

  void fetchAllNotification() async {
    try {
      isLoading(true);
      var data = await notificationService.getAllNotification();
      notificationList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
