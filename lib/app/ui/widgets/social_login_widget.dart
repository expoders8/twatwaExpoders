// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:opentrend/config/constant/font_constant.dart';

import '../home/tab_page.dart';
import '../../services/auth_service.dart';
import '../../../config/constant/color_constant.dart';
import '../../services/fcm_notification_service.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SocialLoginPage extends StatefulWidget {
  final String checkRowOrColumn;
  const SocialLoginPage({super.key, required this.checkRowOrColumn});

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  String idToken = "", fcmToken = "";
  GoogleSignInAccount? user;
  AuthService authService = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  FCMNotificationServices fCMNotificationServices = FCMNotificationServices();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {});
    _googleSignIn.signInSilently();
    fCMNotificationServices.getDeviceToken().then((value) => fcmToken = value);
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        LoaderX.show(context, 70.0);
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        setState(() {
          idToken = googleSignInAuthentication.idToken.toString();
        });
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;
        var userName = user?.displayName;
        List<String> substrings = userName.toString().split(' ');
        await authService
            .socialLogin(substrings[0], substrings[1], user?.email,
                user?.photoURL, idToken, "Google", fcmToken)
            .then(
          (value) async {
            if (value.success == true) {
              LoaderX.hide();
              Get.offAll(() => const TabPage());
            } else {
              LoaderX.hide();
              SnackbarUtils.showErrorSnackbar(
                  "Failed to Login", value.message.toString());
            }
            return null;
          },
        );
      }
    } catch (error) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Failed to Login", error.toString());
      throw error.toString();
    }
  }

  appleSignin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    Future.delayed(const Duration(milliseconds: 100), () async {
      LoaderX.show(context, 70.0);
      await authService
          .socialLogin(credential.givenName, credential.familyName,
              credential.email, "", credential.identityToken, "Apple", fcmToken)
          .then(
        (value) async {
          if (value.success == true) {
            LoaderX.hide();
            Get.offAll(() => const TabPage());
          } else {
            LoaderX.hide();
            SnackbarUtils.showErrorSnackbar(
                "Failed to Login", value.message.toString());
          }
          return null;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.checkRowOrColumn == "row"
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: Platform.isIOS
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: handleGoogleSignIn,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: kWhiteColor, width: 0.3),
                    ),
                    height: 50,
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        "assets/icons/google.png",
                      ),
                    ),
                  ),
                ),
              ),
              Platform.isIOS
                  ? GestureDetector(
                      onTap: appleSignin,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: kWhiteColor, width: 0.3),
                        ),
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.apple_outlined,
                          size: 30,
                          color: kWhiteColor,
                        ),
                      ),
                    )
                  : Container(),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30.0),
              //       border: Border.all(color: kWhiteColor, width: 0.3),
              //     ),
              //     height: 50,
              //     width: 50,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15),
              //       child: Image.asset(
              //         "assets/icons/facebook.png",
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        : Column(
            children: [
              GestureDetector(
                onTap: handleGoogleSignIn,
                child: Container(
                  width: Get.width > 500 ? 600 : Get.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: kWhiteColor, width: 0.3),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue with Google",
                      style: TextStyle(
                          color: kBackGroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: kFuturaPTBook),
                    ),
                  ),
                ),
              ),
              Platform.isIOS ? const SizedBox(height: 20) : Container(),
              Platform.isIOS
                  ? GestureDetector(
                      onTap: appleSignin,
                      child: Container(
                        width: Get.width > 500 ? 600 : Get.width - 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: kWhiteColor, width: 0.3),
                        ),
                        child: const Center(
                          child: Text(
                            "Continue with Apple",
                            style: TextStyle(
                                color: kBackGroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: kFuturaPTBook),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
  }
}
