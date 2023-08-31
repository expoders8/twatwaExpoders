import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/color_constant.dart';

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
  String authToken = "", userImage = "";
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    var token = box.read('authToken');
    if (data != null) {
      setState(() {
        authToken = token ?? "";
        userImage = getUserData['profilePhoto'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              widget.title == "Favourite"
                  ? Container()
                  : Get.toNamed(Routes.menuPage);
            },
            child: Row(
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
                  authToken == ""
                      ? Get.toNamed(Routes.loginPage)
                      : Get.toNamed(Routes.profilePage);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  height: 42,
                  width: 42,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: authToken == ""
                        ? Image.asset(
                            "assets/images/blank_profile.png",
                          )
                        : Image.network(
                            userImage.toString(),
                            fit: BoxFit.cover,
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
