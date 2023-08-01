import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/social_login_widget.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFormSubmitted = false;
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                        key: _loginFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                Image.asset(
                                  "assets/icons/twatwa.png",
                                  scale: 1.5,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Hello",
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Image.asset(
                                      "assets/icons/hand.png",
                                      scale: 7,
                                    ),
                                  ],
                                ),
                                const Text(
                                  "WELCOME TO OPENTREND",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 35,
                                      letterSpacing: 2,
                                      fontFamily: kFuturalRiftSoftBold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  textAlign: TextAlign.center,
                                  "It looks like you have an account with us yet. \n Please complete your information.",
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
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  hintText: 'Password',
                                  maxLines: 1,
                                  ctrl: passwordController,
                                  name: "password",
                                  prefixIcon: 'assets/icons/lock.png',
                                  formSubmitted: isFormSubmitted,
                                  validationMsg: 'Please enter password',
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.forgotPasswordPage);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Forgotten Password?",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: kTextsecondaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                SizedBox(
                                  width: Get.width,
                                  child: CupertinoButton(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(25),
                                    onPressed: onLoginButtonPress,
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          letterSpacing: 2,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 28),
                                const Text(
                                  "Or",
                                  style: TextStyle(
                                      color: kTextSecondaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 15),
                                const SocialLoginPage(),
                                const SizedBox(height: 30),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "New User / ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: kTextSecondaryColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.signUpPage);
                                        },
                                        child: const Text(
                                          "Signup",
                                          style: TextStyle(
                                              fontSize: 13,
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

  onLoginButtonPress() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_loginFormKey.currentState!.validate()) {
        Get.toNamed(Routes.tabPage);
      }
    });
  }
}
