import 'package:get/get.dart';

import '../models/hastage_model.dart';
import '../services/hastag_service.dart';

class GetAllHasTageController extends GetxController {
  var isLoading = true.obs;
  var tagList = <List<HasTagsData>>[].obs;
  HashTagsService hashTagsService = HashTagsService();
  RxString categoryId = "".obs;
  RxList selectTagList = [].obs;

  void fetchAllHastag() async {
    try {
      isLoading(true);
      var data = await hashTagsService.getAllHastag(categoryId.toString());
      tagList.assign(data);
    } finally {
      isLoading(false);
    }
  }
}
