import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_list_pick/country_list_pick.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../services/fcm_notification_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/social_login_widget.dart';
import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';
import '../../../../config/provider/loader_provider.dart';
import '../../../../config/provider/snackbar_provider.dart';
import '../otp/otp.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isFormSubmitted = false;
  final _signUpFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String selectedCountrydialCode = '+91';
  String fcmToken = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FCMNotificationServices fCMNotificationServices = FCMNotificationServices();

  @override
  void initState() {
    super.initState();
    fCMNotificationServices.getDeviceToken().then((value) => fcmToken = value);
  }

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
                    color: const Color(0xFF121330).withOpacity(0.7),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _signUpFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 35),
                                Image.asset(
                                  "assets/Opentrend_light_applogo.jpeg",
                                  scale: 4.3,
                                ),
                                const SizedBox(height: 25),
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
                                const SizedBox(height: 10),
                                const Text(
                                  "WELCOME TO OPENTREND",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 33,
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
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: CustomTextFormField(
                                          hintText: 'FirstName',
                                          maxLines: 1,
                                          ctrl: firstnameController,
                                          name: "firstName",
                                          prefixIcon: 'assets/icons/user.png',
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Please enter First Name',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: CustomTextFormField(
                                          hintText: 'Last Name',
                                          maxLines: 1,
                                          ctrl: lastnameController,
                                          name: "lastName",
                                          // prefixIcon: 'assets/icons/user.png',
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Please enter Last Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  hintText: 'Username',
                                  maxLines: 1,
                                  ctrl: usernameController,
                                  name: "username",
                                  prefixIcon: 'assets/icons/user.png',
                                  formSubmitted: isFormSubmitted,
                                  validationMsg: 'Please enter username',
                                ),
                                const SizedBox(height: 15),
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          width: 100,
                                          height: 53,
                                          decoration: BoxDecoration(
                                              color: const Color(0xB3493F54),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: CountryListPick(
                                            // appBar: AppBar(
                                            //   title:
                                            //       Text('Select your country'),
                                            // ),
                                            appBar: AppBar(
                                              backgroundColor: kBackGroundColor,
                                              centerTitle: true,
                                              leading: GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                },
                                                child: Image.asset(
                                                  "assets/icons/back.png",
                                                  scale: 9,
                                                ),
                                              ),
                                              title: const Text(
                                                "Select your country",
                                                style: TextStyle(
                                                    color: kWhiteColor,
                                                    fontSize: 19),
                                              ),
                                              elevation: 1,
                                            ),
                                            theme: CountryTheme(
                                              isShowFlag: true,
                                              isShowTitle: false,
                                              isShowCode: true,
                                              isDownIcon: false,
                                              showEnglishName: true,
                                            ),
                                            initialSelection: 'IN',
                                            onChanged: (CountryCode? code) {
                                              setState(() {
                                                selectedCountrydialCode =
                                                    code!.dialCode.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: CustomTextFormField(
                                          hintText: 'Mobile',
                                          maxLines: 1,
                                          ctrl: phoneController,
                                          name: "phoneno",
                                          prefixIcon: 'assets/icons/phone.png',
                                          keyboardType: TextInputType.number,
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Please enter mobile no',
                                        ),
                                      ),
                                    ],
                                  ),
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
                                const SocialLoginPage(
                                  checkRowOrColumn: 'row',
                                ),
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
    var phoneNumber = "$selectedCountrydialCode${phoneController.text}";
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_signUpFormKey.currentState!.validate()) {
        LoaderX.show(context, 70.0);
        await authService
            .signUp(
                firstnameController.text,
                lastnameController.text,
                emailController.text,
                passwordController.text,
                usernameController.text,
                phoneNumber,
                fcmToken)
            .then(
          (value) async {
            if (value.success == true) {
              await authService
                  .verifyEmail(value.data!.emailVerificationToken.toString())
                  .then((data) {
                if (data["success"]) {
                  LoaderX.hide();
                } else {
                  LoaderX.hide();
                  SnackbarUtils.showErrorSnackbar(
                      "Failed to SignUp", value.message.toString());
                }
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OtpScreen(
                      phonenumber: value.data!.userPhone.toString(),
                      selectScreenNavigation: "SignUp"),
                ),
              );
              LoaderX.hide();
            } else {
              LoaderX.hide();
              SnackbarUtils.showErrorSnackbar(
                  "Failed to SignUp", value.message.toString());
            }
            return null;
          },
        );
      }
    });
  }
}
