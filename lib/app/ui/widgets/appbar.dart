import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constant/color_constant.dart';
import '../../routes/app_pages.dart';

typedef StringCallback = void Function(String val);

class AppBarWidget extends StatefulWidget {
  final String title;
  const AppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 20.71,
                width: 30.02,
                child: Image.asset(
                  "assets/icons/dropdown.png",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 23),
                height: 19.96,
                width: 19.96,
                child: Image.asset(
                  "assets/icons/search.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.loginPage);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  height: 42,
                  width: 42,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      "assets/images/authBackground.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
