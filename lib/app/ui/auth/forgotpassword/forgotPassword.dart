import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/custom_textfield.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isFormSubmitted = false;
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/authBackground.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: kAuthBackGraundColor,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _forgotPasswordFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Image.asset(
                                  "assets/icons/twatwa.png",
                                  scale: 1.5,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "FORGOT YOUR \nPASSWORD?",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 35,
                                      letterSpacing: 2,
                                      fontFamily: kFuturalRiftSoftBold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  textAlign: TextAlign.center,
                                  "Please enter your email is so we can send the \n password reset link.",
                                  style: TextStyle(color: kTextSecondaryColor),
                                ),
                                const SizedBox(height: 40),
                                CustomTextFormField(
                                  hintText: 'Email',
                                  maxLines: 1,
                                  ctrl: emailController,
                                  name: "email",
                                  prefixIcon: 'assets/icons/email.png',
                                  formSubmitted: isFormSubmitted,
                                  validationMsg: 'Please enter email',
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width: Get.width,
                                  child: CupertinoButton(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(25),
                                    onPressed: onForgotPasswordButtonPress,
                                    child: const Text(
                                      'REQUEST RESET LINK',
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          letterSpacing: 1.3,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Back to / ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: kTextSecondaryColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.loginPage);
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
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

  onForgotPasswordButtonPress() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_forgotPasswordFormKey.currentState!.validate()) {
        Get.toNamed(Routes.loginPage);
      }
    });
  }
}
