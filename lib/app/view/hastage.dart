import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controller/hastage_controller.dart';
import '../../../config/constant/color_constant.dart';

class HasTageView extends StatefulWidget {
  const HasTageView({super.key});

  @override
  State<HasTageView> createState() => _HasTageViewState();
}

class _HasTageViewState extends State<HasTageView> {
  final GetAllHasTageController getAllHasTageController =
      Get.put(GetAllHasTageController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllHasTageController.fetchAllHastag();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> selectedCategory =
    //     getAllHasTageController.selectedCatForNewStoryIdList.toList();
    return Obx(() {
      if (getAllHasTageController.isLoading.value) {
        return Container(
          height: 45,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            color: kWhiteColor,
            border: Border.all(
              color: kButtonSecondaryColor,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 14, left: 10),
            child: Text(
              "Select Hashtags",
              style: TextStyle(fontSize: 14, color: kWhiteColor),
            ),
          ),
        );
      } else {
        if (getAllHasTageController.tagList.isNotEmpty) {
          var data = getAllHasTageController.tagList[0];
          return MultiSelectDialogField(
            items: data
                .map(
                  (category) =>
                      MultiSelectItem(category.id, category.name.toString()),
                )
                .toList(),
            searchable: true,
            backgroundColor: kWhiteColor,
            checkColor: kButtonColor,
            chipDisplay: MultiSelectChipDisplay(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: kButtonColor, width: 0.6),
                borderRadius: BorderRadius.circular(20.0),
              ),
              icon: const Icon(
                Icons.check,
                color: kButtonColor,
                size: 18,
              ),
              chipColor: kBackGroundColor,
              height: 60,
              textStyle: const TextStyle(color: kButtonSecondaryColor),
            ),
            onConfirm: (values) {
              getAllHasTageController.selectTagList(values);
              // setState(() {
              //   hastage = values;
              // });
            },
            title: const Text("Hashtags"),
            listType: MultiSelectListType.CHIP,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(
                color: kButtonSecondaryColor,
              ),
            ),
            buttonIcon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: kWhiteColor,
            ),
            buttonText: const Text(
              "Select Hashtags",
              style: TextStyle(fontSize: 14, color: kWhiteColor),
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No Tag found",
              style: TextStyle(color: kWhiteColor),
            ),
          );
        }
      }
    });
  }
}
