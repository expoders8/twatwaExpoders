import 'package:Twatwa/config/constant/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/twatwa.png"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hello",
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        // Image.asset("assets/icons/hand.png"),
                      ],
                    ),
                    const Text(
                      "WELCOME TO TWATWA",
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      textAlign: TextAlign.center,
                      "It looks like you have an account with us yet. \n Please complete your information.",
                      style: TextStyle(color: kTextSecondaryColor),
                    ),
                    const SizedBox(height: 80),
                    const CustomTextFormField(
                      hintText: 'Email',
                      maxLines: 1,
                      // ctrl: emailController,
                      name: "email",
                      prefixIcon: 'assets/icons/email.png',
                      // formSubmitted: isFormSubmitted,
                      validationMsg: 'Please enter email',
                    ),
                    const SizedBox(height: 15),
                    const CustomTextFormField(
                      hintText: 'Password',
                      maxLines: 1,
                      // ctrl: passwordController,
                      name: "password",
                      prefixIcon: 'assets/icons/lock.png',
                      // formSubmitted: isFormSubmitted,
                      validationMsg: 'Please enter password',
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgotten Password?",
                            style: TextStyle(
                              fontSize: 14,
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
                        onPressed: () {},
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: kWhiteColor,
                              letterSpacing: 2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Or",
                      style:
                          TextStyle(color: kTextSecondaryColor, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                color: kTextSecondaryColor, width: 0.5),
                          ),
                          height: 60,
                          width: 60,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/google.png",
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: kWhiteColor, width: 0.5),
                          ),
                          height: 60,
                          width: 60,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(6.5),
                              child: Image.asset(
                                "assets/icons/facebook.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New User | ",
                            style: TextStyle(
                              fontSize: 14,
                              color: kTextSecondaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 16,
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
    );
  }
}
