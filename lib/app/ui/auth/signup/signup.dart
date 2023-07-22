import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/social_login_widget.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isFormSubmitted = false;
  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
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
                        key: _signUpFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 25),
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
                                      scale: 8.5,
                                    ),
                                  ],
                                ),
                                const Text(
                                  "WELCOME TO TWATWA",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 35,
                                      letterSpacing: 2,
                                      fontFamily: kFuturalRiftSoftBold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  textAlign: TextAlign.center,
                                  "It looks like you have an account with us yet.",
                                  style: TextStyle(color: kTextSecondaryColor),
                                ),
                                const SizedBox(height: 40),
                                CustomTextFormField(
                                  hintText: 'Username',
                                  maxLines: 1,
                                  ctrl: usernameController,
                                  name: "name",
                                  prefixIcon: 'assets/icons/user.png',
                                  formSubmitted: isFormSubmitted,
                                  validationMsg: 'Please enter username',
                                ),
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  hintText: 'Mobile',
                                  maxLines: 1,
                                  ctrl: phoneController,
                                  name: "phoneno",
                                  prefixIcon: 'assets/icons/phone.png',
                                  keyboardType: TextInputType.phone,
                                  formSubmitted: isFormSubmitted,
                                  validationMsg: 'Please enter mobile no',
                                ),
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: Get.width,
                                  child: CupertinoButton(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(25),
                                    onPressed: onSignUpButtonPress,
                                    child: const Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          letterSpacing: 2,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Or",
                                  style: TextStyle(
                                      color: kTextSecondaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 15),
                                const SocialLoginPage(),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Existing User / ",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                              fontSize: 13,
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "By registering, you agree to the ",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: kTextSecondaryColor,
                                            fontFamily: kFuturaPTBook),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          const policyUrl =
                                              "https://opentales.co/privacy";
                                          if (!await launchUrl(
                                              Uri.parse(policyUrl),
                                              webOnlyWindowName: "_blank",
                                              mode: LaunchMode
                                                  .externalApplication)) {
                                            throw Exception(
                                                'Could not launch $policyUrl');
                                          }
                                        },
                                        child: const Text(
                                          "privacy policy",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: kTextSecondaryColor,
                                            fontFamily: kFuturaPTBook,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                kTextSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        " and ",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: kTextSecondaryColor,
                                            fontFamily: kFuturaPTBook),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          const termsUrl =
                                              "https://opentales.co/terms";
                                          if (!await launchUrl(
                                              Uri.parse(termsUrl),
                                              webOnlyWindowName: "_blank",
                                              mode: LaunchMode
                                                  .externalApplication)) {
                                            throw Exception(
                                                'Could not launch $termsUrl');
                                          }
                                        },
                                        child: const Text(
                                          "terms",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: kTextSecondaryColor,
                                            fontFamily: kFuturaPTBook,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                kTextSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        " of service.",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: kTextSecondaryColor,
                                          fontFamily: kFuturaPTBook,
                                          decoration: TextDecoration.underline,
                                          decorationColor: kTextSecondaryColor,
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

  onSignUpButtonPress() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_signUpFormKey.currentState!.validate()) {
        Get.toNamed(Routes.otpScreen);
      }
    });
  }
}
