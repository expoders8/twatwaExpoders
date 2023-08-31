// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:opentrend/config/constant/font_constant.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/provider/snackbar_provider.dart';
// import '../../services/fcm_notification_service.dart';

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
  // AuthService authService = AuthService();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // FCMNotificationServices fCMNotificationServices = FCMNotificationServices();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {});
    _googleSignIn.signInSilently();
    // fCMNotificationServices.getDeviceToken().then((value) => fcmToken = value);
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        setState(() {
          idToken = googleSignInAuthentication.idToken.toString();
        });
        // final AuthCredential authCredential = GoogleAuthProvider.credential(
        //     idToken: googleSignInAuthentication.idToken,
        //     accessToken: googleSignInAuthentication.accessToken);

        // UserCredential result = await auth.signInWithCredential(authCredential);
        // User? user = result.user;
        // var userName = user?.displayName;
        // List<String> substrings = userName.toString().split(' ');
        // await authService
        //     .socialLogin(substrings[0], substrings[1], user?.email,
        //         user?.photoURL, idToken, "Google", fcmToken)
        //     .then(
        //   (value) async {
        //     if (value.success == true) {
        //       Get.offAll(() => const TabPage());
        //       box.write('onBoard', 0);
        //     } else {
        //       SnackbarUtils.showErrorSnackbar(
        //           "Failed to Login", value.message.toString());
        //     }
        //     return null;
        //   },
        // );
      }
    } catch (error) {
      SnackbarUtils.showErrorSnackbar("Failed to Login", error.toString());
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.checkRowOrColumn == "row"
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
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
        : GestureDetector(
            onTap: handleGoogleSignIn,
            child: Container(
              width: Get.width > 500 ? 600 : Get.width - 50,
              height: 50,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: kWhiteColor, width: 0.3),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
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
          );
  }
}
