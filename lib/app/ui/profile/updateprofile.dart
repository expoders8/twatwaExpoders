import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/provider/imagepicker_provider.dart';
import '../widgets/custom_textfield.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                            child: Image.asset(
                              "assets/images/authBackground.png",
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
              buildtitletext("NAME"),
              const CustomTextFormField(
                hintText: 'Username',
                maxLines: 1,
                // ctrl: usernameController,
                name: "name",
                prefixIcon: 'assets/icons/user.png',
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter username',
              ),
              buildtitletext("CONTACT"),
              const CustomTextFormField(
                hintText: 'Mobile',
                maxLines: 1,
                // ctrl: phoneController,
                name: "phoneno",
                prefixIcon: 'assets/icons/phone.png',
                keyboardType: TextInputType.phone,
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter password',
              ),
              buildtitletext("EMAIL"),
              const CustomTextFormField(
                hintText: 'Email',
                maxLines: 1,
                // ctrl: emailController,
                name: "email",
                prefixIcon: 'assets/icons/email.png',
                // formSubmitted: isFormSubmitted,
                // validationMsg: 'Please enter email',
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: Get.width,
                child: CupertinoButton(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(25),
                  onPressed: () {},
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
