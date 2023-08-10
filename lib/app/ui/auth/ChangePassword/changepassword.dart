import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opentrend/app/ui/profile/profile.dart';

import '../../../../config/constant/constant.dart';
import '../../../services/auth_service.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String userId = "";
  AuthService authService = AuthService();
  final _changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var data = box.read('user');
    var temp = jsonDecode(data);
    if (temp != null) {
      setState(() {
        userId = temp['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Form(
            key: _changePasswordFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildtitletext("Old password"),
                TextFormField(
                  style: const TextStyle(color: kWhiteColor),
                  controller: currentPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Current password";
                    }
                    return null;
                  },
                  decoration: inputOfTextField("Current Password"),
                  maxLines: 1,
                ),
                buildtitletext("New password"),
                TextFormField(
                  style: const TextStyle(color: kWhiteColor),
                  controller: newPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter New password";
                    }
                    return null;
                  },
                  decoration: inputOfTextField("New Password"),
                  maxLines: 1,
                ),
                buildtitletext("Confirm password"),
                TextFormField(
                  style: const TextStyle(color: kWhiteColor),
                  controller: confirmPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Confirm password";
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  decoration: inputOfTextField("Confirm Password"),
                  maxLines: 1,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: Get.width,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: onChangeButtonPress,
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
      ),
    );
  }

  onChangeButtonPress() {
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_changePasswordFormKey.currentState!.validate()) {
        LoaderX.show(context, 70.0);
        FocusScope.of(context).requestFocus(FocusNode());
        await authService
            .changePassowrd(userId, currentPasswordController.text,
                newPasswordController.text, confirmPasswordController.text)
            .then((value) {
          return value.success == true
              ? successfullyChangePassword()
              : changePasswordFailed(value);
        });
      }
    });
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

  successfullyChangePassword() async {
    confirmPasswordController.clear();
    currentPasswordController.clear();
    newPasswordController.clear();
    LoaderX.hide();

    // box.remove('user');
    SnackbarUtils.showSnackbar(
        "Password change successfully", "Password Change, Please login again.");

    Get.offAll(() => const ProfilePage());
  }

  changePasswordFailed(value) {
    LoaderX.hide();
    SnackbarUtils.showErrorSnackbar(
        "Failed to change Password", value.message.toString());
  }

  InputDecoration inputOfTextField(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xB3493F54),
      contentPadding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
      hintStyle: const TextStyle(color: kGreyColor),
      labelStyle: const TextStyle(color: kBlackColor),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(
            color: hintText == "Confirm Password"
                ? newPasswordController.text != confirmPasswordController.text
                    ? kRedColor
                    : const Color(0xB3493F54)
                : const Color(0xB3493F54)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(
            color: hintText == "Confirm Password"
                ? newPasswordController.text != confirmPasswordController.text
                    ? kRedColor
                    : const Color(0xB3493F54)
                : const Color(0xB3493F54),
            width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(
            color: hintText == "Confirm Password"
                ? newPasswordController.text != confirmPasswordController.text
                    ? kRedColor
                    : const Color(0xB3493F54)
                : const Color(0xB3493F54)),
      ),
    );
  }
}
