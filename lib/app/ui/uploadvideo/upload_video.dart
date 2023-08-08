import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/imagepicker_provider.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  File? imageFile, videoFile;
  double uploadProgress = 0.0;
  bool isUploading = false, processingValue = false;
  String videostatus = "", fileSize = '';
  TextEditingController descriptionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController tagcontroller = TextEditingController();
  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: kButtonSecondaryColor,
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              "assets/icons/back.png",
              scale: 9,
            ),
          ),
        ),
        title: const Text(
          "Video property",
          style: TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    videoFile == null
                        ? DottedBorder(
                            strokeWidth: 1.3,
                            borderType: BorderType.Rect,
                            color: kButtonSecondaryColor,
                            child: SizedBox(
                              width: 150,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/upload.png",
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Upload video",
                                    style: TextStyle(
                                        color: kTextsecondarytopColor,
                                        fontSize: 15,
                                        fontFamily: kFuturaPTBook),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                color: kAuthBackGraundColor,
                                width: 150,
                                height: 100,
                                child: VideoPlayer(_controller),
                              ),
                              Positioned(
                                child: isUploading
                                    ? Container(
                                        color: kAuthBackGraundColor,
                                        width: 150,
                                        height: 100,
                                        child: CircularPercentIndicator(
                                          radius: 20.0,
                                          percent: uploadProgress,
                                          center: Text(
                                              '${(uploadProgress * 100).toInt()}%',
                                              style: const TextStyle(
                                                  color: kTextsecondarytopColor,
                                                  fontSize: 13,
                                                  fontFamily: kFuturaPTBook)),
                                          progressColor: kButtonColor,
                                          backgroundColor: kWhiteColor,
                                        ),
                                      )
                                    : videostatus == "cancel"
                                        ? Container(
                                            color: kAuthBackGraundColor,
                                            width: 150,
                                            height: 100,
                                            child: const Icon(
                                              Icons.check_circle_outline,
                                              color: kButtonColor,
                                              size: 45,
                                            ),
                                          )
                                        : Container(),
                              )
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: processingValue
                                ? isUploading
                                    ? const Text(
                                        "Video Uploading…",
                                        style: TextStyle(
                                            color: kTextsecondarytopColor,
                                            fontSize: 15,
                                            fontFamily: kFuturaPTBook),
                                      )
                                    : const Text(
                                        "UPLOADED",
                                        style: TextStyle(
                                            color: kTextsecondarytopColor,
                                            fontSize: 15,
                                            fontFamily: kFuturaPTBook),
                                      )
                                : const Text(
                                    "Upload video from your library",
                                    style: TextStyle(
                                        color: kTextsecondarytopColor,
                                        fontSize: 15,
                                        fontFamily: kFuturaPTBook),
                                  ),
                          ),
                          const SizedBox(height: 5),
                          processingValue
                              ? isUploading
                                  ? const Text(
                                      "Lorem Ipsum is simply dummy",
                                      style: TextStyle(
                                        color: kTextsecondarybottomColor,
                                        fontSize: 11,
                                      ),
                                    )
                                  : Text(
                                      fileSize,
                                      style: TextStyle(
                                        color: kTextsecondarybottomColor,
                                        fontSize: 11,
                                      ),
                                    )
                              : const Text(
                                  "Lorem Ipsum is simply dummy",
                                  style: TextStyle(
                                    color: kTextsecondarybottomColor,
                                    fontSize: 11,
                                  ),
                                ),
                          // const Text(
                          //   "Lorem Ipsum is simply dummy ",
                          //   style: TextStyle(
                          //     color: kTextsecondarybottomColor,
                          //     fontSize: 11,
                          //   ),
                          // ),
                          const SizedBox(height: 5),
                          processingValue
                              ? isUploading
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          videoFile = null;
                                          processingValue = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 8,
                                              bottom: 8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kButtonColor, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "CANCEL",
                                            style: TextStyle(
                                                fontFamily: kFuturaPTBook,
                                                fontSize: 15,
                                                color: kWhiteColor),
                                          )),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          videoFile = null;
                                          processingValue = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 8,
                                              bottom: 8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kButtonSecondaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "DELETE",
                                            style: TextStyle(
                                                fontFamily: kFuturaPTBook,
                                                fontSize: 15,
                                                color: kButtonSecondaryColor),
                                          )),
                                        ),
                                      ),
                                    )
                              : GestureDetector(
                                  onTap: pickVideo,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kButtonColor, width: 1),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Upload",
                                          style: TextStyle(
                                              fontFamily: kFuturaPTBook,
                                              fontSize: 15,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Details",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing",
                      style: TextStyle(
                        color: kTextsecondarybottomColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'Add a title that describe your video',
                  maxLines: 1,
                  ctrl: descriptionController,
                  name: "describe",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Tell viewers about video',
                  maxLines: 1,
                  ctrl: aboutController,
                  name: "viewersaboutvideo",
                  // formSubmitted: isFormSubmitted,
                  // validationMsg: 'Please enter email',
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Thumbnail",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Select or upload a picture that shows what’s in your video.",
                      style: TextStyle(
                        color: kTextsecondarybottomColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: pickImage,
                  child: imageFile == null
                      ? DottedBorder(
                          strokeWidth: 1.3,
                          borderType: BorderType.Rect,
                          color: kButtonSecondaryColor,
                          child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/upload.png",
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Upload image",
                                  style: TextStyle(
                                      color: kTextsecondarytopColor,
                                      fontSize: 15,
                                      fontFamily: kFuturaPTBook),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 150,
                          height: 100,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hashtags",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Select or upload a picture that shows in your video",
                      style: TextStyle(
                        color: kTextsecondarybottomColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: tagcontroller,
                  style: const TextStyle(color: kWhiteColor),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 17, 17, 17),
                    fillColor: kWhiteColor,
                    hintText: "Create your #tags",
                    labelStyle: TextStyle(color: kWhiteColor),
                    hintStyle:
                        TextStyle(color: kButtonSecondaryColor, fontSize: 13),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.2, //<-- SEE HERE
                        color: kButtonSecondaryColor,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.2, //<-- SEE HERE
                        color: kButtonSecondaryColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.2, //<-- SEE HERE
                        color: kButtonSecondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    buildDonationAmountList("HOLLYWOOD", 0),
                    buildDonationAmountList("BOLLYWOOD", 1),
                    buildDonationAmountList("COMEDY", 2),
                  ],
                ),
                Row(
                  children: [
                    buildDonationAmountList("LOVE", 3),
                    buildDonationAmountList("MOVIES", 4),
                    buildDonationAmountList("#ENTERTAINMENT", 5),
                  ],
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: Get.width,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: kButtonColor, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "Draft",
                        style: TextStyle(
                            color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: Get.width,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: () {
                      Get.toNamed(Routes.videoUploadedPage);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 2, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
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

  Future pickVideo() async {
    await PickerUtils.pickVideoFromGallery().then(
      (pickedFile) async {
        if (pickedFile == null) return;
        setState(
          () {
            isUploading = true;
            processingValue = true;
            videostatus = "cancel";
            uploadProgress = 0.0;
            videoFile = File(pickedFile.path);
          },
        );
        _controller = VideoPlayerController.file(File(pickedFile.path));
        await _controller.initialize();
        await _simulateUpload();
        double bytes = videoFile!.lengthSync().toDouble();
        double megabytes = bytes / (1024 * 1024);
        setState(() {
          fileSize = '${megabytes.toStringAsFixed(2)} MB';
        });
      },
    );
  }

  Future<void> _simulateUpload() async {
    for (var i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        uploadProgress = i / 100.0;
        if (uploadProgress == 1.0) {
          setState(() {
            isUploading = false;
          });
        }
      });
    }
  }

  Widget buildDonationAmountList(
    String name,
    int value,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        name == "HOLLYWOOD"
            ? setState(
                () {
                  var tag1 = "HOLLYWOOD";
                  tagcontroller.text = tag1;
                },
              )
            : name == "BOLLYWOOD"
                ? setState(
                    () {
                      var tag1 = "BOLLYWOOD";
                      tagcontroller.text = tag1;
                    },
                  )
                : name == "COMEDY"
                    ? setState(
                        () {
                          var tag1 = "COMEDY";
                          tagcontroller.text = tag1;
                        },
                      )
                    : name == "LOVE"
                        ? setState(
                            () {
                              var tag1 = "LOVE";
                              tagcontroller.text = tag1;
                            },
                          )
                        : name == "MOVIES"
                            ? setState(
                                () {
                                  var tag1 = "MOVIES";
                                  tagcontroller.text = tag1;
                                },
                              )
                            : name == "#ENTERTAINMENT"
                                ? setState(
                                    () {
                                      var tag1 = "#ENTERTAINMENT";
                                      tagcontroller.text = tag1;
                                    },
                                  )
                                : Container();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 6),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: kButtonColor, width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  fontFamily: kFuturaPTBook, fontSize: 15, color: kButtonColor),
            ),
          ),
        ),
      ),
    );
  }
}
