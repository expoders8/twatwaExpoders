import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constant/color_constant.dart';
import '../../routes/app_pages.dart';

class NoUserLoginDialog extends StatelessWidget {
  const NoUserLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Already a member?"),
      elevation: 5,
      titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
      content: const Text("Sign in to continue"),
      contentPadding: const EdgeInsets.only(left: 25, top: 10),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            Get.toNamed(Routes.loginPage);
          },
          child: const Text(
            'Sign in',
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
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
    );
  }
}
