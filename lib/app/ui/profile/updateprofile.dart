import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home/tab_page.dart';
import '../profile/profile.dart';
import '../widgets/custom_textfield.dart';
import '../../services/user_service.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';
import '../../../config/provider/snackbar_provider.dart';
import '../../../config/provider/imagepicker_provider.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? imageFile;
  bool isFormSubmitted = false;
  String firstName = "",
      lastName = "",
      userId = "",
      userEmail = "",
      userImage = "",
      userName = "",
      userPhone = "";
  final updateUserFormKey = GlobalKey<FormState>();
  UserService userService = UserService();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userId = getUserData['id'] ?? "";
        firstName = getUserData['firstName'] ?? "";
        lastName = getUserData['lastName'] ?? "";
        userEmail = getUserData['userEmail'] ?? "";
        userImage = getUserData['profilePhoto'] ?? "";
        userName = getUserData['userName'] ?? "";
      });
    }
    isExistingUser();
  }

  isExistingUser() {
    emailController.text = userEmail;
    usernameController.text = userName;
    firstnameController.text = firstName;
    lastnameController.text = lastName;
    phoneController.text = userPhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Form(
            key: updateUserFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageFile == null
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                userImage.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  "assets/images/blank_profile.png",
                                  fit: BoxFit.cover,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upload Photo",
                          style: TextStyle(fontSize: 14, color: kWhiteColor),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Image size should be between \n100 Kb to 300 Kb",
                          style: TextStyle(
                              fontSize: 12, color: kButtonSecondaryColor),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: kButtonSecondaryColor, width: 1),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Text(
                                "UPLOAD PHOTO",
                                style: TextStyle(
                                    fontSize: 14, color: kButtonSecondaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                buildtitletext("FirstName"),
                CustomTextFormField(
                  hintText: 'FirstName',
                  maxLines: 1,
                  ctrl: firstnameController,
                  name: "firstname",
                  prefixIcon: 'assets/icons/user.png',
                  formSubmitted: isFormSubmitted,
                  validationMsg: 'Please enter First Name',
                ),
                buildtitletext("LastName"),
                CustomTextFormField(
                  hintText: 'LastName',
                  maxLines: 1,
                  ctrl: lastnameController,
                  name: "lastname",
                  prefixIcon: 'assets/icons/user.png',
                  formSubmitted: isFormSubmitted,
                  validationMsg: 'Please enter Last Name',
                ),
                buildtitletext("UserName"),
                CustomTextFormField(
                  hintText: 'Username',
                  maxLines: 1,
                  ctrl: usernameController,
                  name: "username",
                  prefixIcon: 'assets/icons/user.png',
                  formSubmitted: isFormSubmitted,
                  validationMsg: 'Please enter username',
                ),
                // buildtitletext("CONTACT"),
                // CustomTextFormField(
                //   hintText: 'Mobile',
                //   maxLines: 1,
                //   ctrl: phoneController,
                //   name: "phoneno",
                //   prefixIcon: 'assets/icons/phone.png',
                //   keyboardType: TextInputType.phone,
                //   // formSubmitted: isFormSubmitted,
                //   // validationMsg: 'Please enter password',
                // ),
                buildtitletext("EMAIL"),
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
                Row(
                  children: [
                    SizedBox(
                      width: Platform.isIOS ? Get.width / 2.3 : Get.width - 45,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(25),
                        onPressed: _onEditProfile,
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              color: kWhiteColor,
                              letterSpacing: 1,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Platform.isIOS ? const SizedBox(width: 6) : Container(),
                    Platform.isIOS
                        ? SizedBox(
                            width: Get.width / 2.3,
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              color: kButtonColor,
                              borderRadius: BorderRadius.circular(25),
                              onPressed: userAccountDelete,
                              child: const Text(
                                'Delete Account',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    letterSpacing: 1,
                                    fontSize: 15),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  userAccountDelete() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert !"),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: const Text("Are you sure want to Delete \nAccount?"),
        contentPadding: const EdgeInsets.only(left: 25, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              LoaderX.show(context, 70.0);
              await userService.userAccountDelete().then(
                (value) {
                  if (value["success"]) {
                    _googleSignIn.disconnect();
                    Navigator.of(context).pop();
                    box.remove('user');
                    box.remove('authToken');
                    Get.offAll(() => const TabPage());
                  } else {
                    LoaderX.hide();
                    SnackbarUtils.showErrorSnackbar(
                        "Failed to userDelete", value["message"]);
                  }
                },
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'No',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  _onEditProfile() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (updateUserFormKey.currentState!.validate()) {
        LoaderX.show(context, 70.0);
        await userService
            .updateUserProfile(
                userId,
                firstnameController.text,
                lastnameController.text,
                emailController.text,
                usernameController.text,
                imageFile)
            .then(
          (value) async {
            if (value.success == true) {
              LoaderX.hide();
              Get.offAll(() => const ProfilePage());
              return 1;
            } else {
              LoaderX.hide();
              SnackbarUtils.showErrorSnackbar(
                  "Failed to Update Profile", value.message.toString());
            }
            return null;
          },
        );
      }
    });
  }

  buildtitletext(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: kButtonSecondaryColor),
      ),
    );
  }

  Future pickImage() async {
    await PickerUtils.pickImageFromGallery().then((pickedFile) async {
      if (pickedFile == null) return;

      await PickerUtils.cropSelectedImage(pickedFile.path).then((croppedFile) {
        if (croppedFile == null) return;

        setState(() {
          imageFile = File(croppedFile.path);
        });
      });
    });
  }
}
