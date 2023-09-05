import 'package:flutter/material.dart';

import '../auth/login/login.dart';
import '../widgets/social_login_widget.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/constant/font_constant.dart';

class NoUserLoginScreen extends StatefulWidget {
  const NoUserLoginScreen({Key? key}) : super(key: key);

  @override
  State<NoUserLoginScreen> createState() => _NoUserLoginScreenState();
}

class _NoUserLoginScreenState extends State<NoUserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/Opentrend_light_applogo.jpeg",
              height: 100,
              width: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: size.width - 50,
            child: const Text(
              "The page you're trying to access has restricted access.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kWhiteColor,
                  height: 1.5,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: kFuturaPTDemi),
            ),
          ),
          const SizedBox(height: 40),
          const SocialLoginPage(
            checkRowOrColumn: 'column',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width > 500 ? 600 : size.width - 50,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kWhiteColor,
                shadowColor: const Color.fromARGB(100, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text(
                "Continue with Email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: kFuturaPTBook),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
