// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../widgets/numeric_pad.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/constant/font_constant.dart';

class OtpScreen extends StatefulWidget {
  final String? phonenumber;
  const OtpScreen({
    super.key,
    this.phonenumber,
  });

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  String code = "";
  String otpValidateMessage = "";
  int secondsRemaining = 20;
  bool enableResend = false;
  Timer? timer;

  succsesOTP() {
    // SnackbarUtils.showSnackbar("Success", "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: kAuthBackGraundColor,
        body: Stack(
          children: [
            Container(
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
                color: kAuthBackGraundColor,
                child: SafeArea(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Image.asset(
                                    "assets/icons/otpphone.png",
                                    scale: 3,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                secondsRemaining == 0
                                    ? Container()
                                    : Text(
                                        '00:$secondsRemaining  ',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 252, 35, 86),
                                          fontSize: 15,
                                          fontFamily: kFuturaPTBook,
                                        ),
                                      ),
                                const SizedBox(height: 20),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 35),
                                  child: Text(
                                    "ENTER YOUR OTP",
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 26,
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 35),
                                  child: Text(
                                    "Please enter the code we sent your mobile",
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontFamily: kFuturaPTBook,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 35),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    buildCodeNumberBox(code.isNotEmpty
                                        ? code.substring(0, 1)
                                        : ""),
                                    buildCodeNumberBox(code.length > 1
                                        ? code.substring(1, 2)
                                        : ""),
                                    buildCodeNumberBox(code.length > 2
                                        ? code.substring(2, 3)
                                        : ""),
                                    buildCodeNumberBox(code.length > 3
                                        ? code.substring(3, 4)
                                        : ""),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Didn’t receive the OTP?",
                            style: TextStyle(
                              color: kTextSecondaryColor,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "RESEND",
                              style: TextStyle(
                                color: Color.fromARGB(255, 252, 35, 86),
                                fontFamily: kFuturaPTBook,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    NumericPad(
                      onNumberSelected: (value) {
                        setState(() {
                          if (value != -1) {
                            if (code.length < 4) {
                              code = code + value.toString();
                            }
                          } else {
                            code = code.substring(
                                0, code.isNotEmpty ? code.length - 1 : null);
                          }
                        });
                        code.length == 4 ? succsesOTP() : null;
                      },
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 62,
        height: 64,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(179, 73, 63, 84),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(20, 0, 0, 0),
                blurRadius: 8,
                offset: Offset(0, 0),
                spreadRadius: -3,
              )
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: kFuturaPTBook,
                fontWeight: FontWeight.w600,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLoader(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SizedBox(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
