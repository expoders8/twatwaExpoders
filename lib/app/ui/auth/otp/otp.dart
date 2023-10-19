import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';
import '../../home/tab_page.dart';
import '../../widgets/numeric_pad.dart';
import '../../../services/auth_service.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';

class OtpScreen extends StatefulWidget {
  final String phonenumber;
  const OtpScreen({
    super.key,
    required this.phonenumber,
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
  bool screentimevalue = true;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  otpVerification(code) async {
    LoaderX.show(context, 70.0);
    await authService.otpVerification(widget.phonenumber, code).then(
      (value) async {
        if (value["success"]) {
          LoaderX.hide();
          Get.offAll(() => const TabPage());
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(
              "Failed to send Otp", value["message"].toString());
        }
        return null;
      },
    );
  }

  sendOtp() async {
    setState(() {
      screentimevalue = false;
    });
    await authService.otpSend(widget.phonenumber).then(
      (value) async {
        if (value["success"]) {
          LoaderX.hide();
          code.isNotEmpty ? code = "" : null;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(phonenumber: widget.phonenumber)),
          );
          SnackbarUtils.showSnackbar("Otp send succesfully", "");
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(
              "Failed to send Otp", value["message"].toString());
        }
        return null;
      },
    );
  }

  // screenCountTime() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (_) {
  //     if (secondsRemaining != 0) {
  //       setState(() {
  //         secondsRemaining--;
  //         screentimevalue = false;
  //       });
  //     } else {
  //       setState(() {
  //         screentimevalue = true;
  //         enableResend = true;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.toNamed(Routes.signUpPage);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121330).withOpacity(0.7),
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
                color: const Color(0xFF121330).withOpacity(0.7),
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
                          secondsRemaining == 0
                              ? GestureDetector(
                                  onTap: sendOtp,
                                  child: const Text(
                                    "RESEND",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 252, 35, 86),
                                      fontFamily: kFuturaPTBook,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "RESEND",
                                  style: TextStyle(
                                    color: kTextSecondaryColor,
                                    fontFamily: kFuturaPTBook,
                                    fontSize: 15,
                                  ),
                                ),
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
                        code.length == 4 ? otpVerification(code) : null;
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
