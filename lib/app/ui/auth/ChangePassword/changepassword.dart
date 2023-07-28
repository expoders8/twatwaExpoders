import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/constant/color_constant.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildtitletext("Old password"),
              const CustomTextFormField(
                hintText: 'Old password',
                maxLines: 1,
                // ctrl: passwordController,
                name: "password",
                prefixIcon: 'assets/icons/lock.png',
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter username',
              ),
              buildtitletext("New password"),
              const CustomTextFormField(
                hintText: 'New password',
                maxLines: 1,
                // ctrl: passwordController,
                name: "password",
                prefixIcon: 'assets/icons/lock.png',
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter password',
              ),
              buildtitletext("Confirm password"),
              const CustomTextFormField(
                hintText: 'Confirm password',
                maxLines: 1,
                // ctrl: passwordController,
                name: "password",
                prefixIcon: 'assets/icons/lock.png',
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter email',
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: Get.width,
                child: CupertinoButton(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(25),
                  onPressed: () {},
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildtitletext(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: kButtonSecondaryColor),
      ),
    );
  }
}
