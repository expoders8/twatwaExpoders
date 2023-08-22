import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../services/playlist_service.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/constant/font_constant.dart';

class CreateAndEditPlaylistPage extends StatefulWidget {
  const CreateAndEditPlaylistPage({super.key});

  @override
  State<CreateAndEditPlaylistPage> createState() =>
      _CreateAndEditPlaylistPageState();
}

class _CreateAndEditPlaylistPageState extends State<CreateAndEditPlaylistPage> {
  int selectValue = 0;
  String topHeaderName = "";
  bool isFormSubmitted = false;
  final _playlistFormKey = GlobalKey<FormState>();
  TextEditingController playlistNameController = TextEditingController();
  PlaylistService playlistService = PlaylistService();
  @override
  void initState() {
    super.initState();
    var getname = Get.parameters['headerName'];
    setState(() {
      topHeaderName = getname.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        // leading: Image.asset(
        //   "assets/icons/back.png",
        //   scale: 7,
        // ),
        title: Text(
          "$topHeaderName Playlist",
          style: const TextStyle(color: kWhiteColor, fontSize: 19),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Form(
            key: _playlistFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "PLAYLIST NAME",
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
                  hintText: 'Enter Playlist Name',
                  maxLines: 1,
                  ctrl: playlistNameController,
                  name: "playlistname",
                  formSubmitted: isFormSubmitted,
                  validationMsg: 'Please enter Playlist Name',
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "SHARE WITH",
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    buildSelectFunction("PUBLIC", 0),
                    buildSelectFunction("FRIENDS", 1),
                    buildSelectFunction("ONLY ME", 2),
                  ],
                ),
                const SizedBox(height: 290),
                SizedBox(
                  width: Get.width,
                  child: CupertinoButton(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: createPlaylist,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: kWhiteColor, letterSpacing: 2, fontSize: 15),
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

  createPlaylist() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_playlistFormKey.currentState!.validate()) {
        // LoaderX.show(context, 70.0);
        // await playlistService
        //     .createPlaylist(
        //   userId,
        //   playlistNameController.text,

        // )
        //     .then(
        //   (value) async {
        //     if (value['success'] == true) {
        //       LoaderX.hide();
        //       // Get.offAll(() => const TabPage());
        //     } else {
        //       LoaderX.hide();
        //       SnackbarUtils.showErrorSnackbar(
        //           "Failed to SignUp", value.message.toString());
        //     }
        //     return null;
        //   },
        // );
      }
    });
  }

  Widget buildSelectFunction(
    String name,
    int value,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          selectValue = value;
          selectValue == 0
              ? 0
              : selectValue == 1
                  ? 1
                  : selectValue == 2
                      ? 2
                      : Container();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 95,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    selectValue == value ? kButtonColor : kButtonSecondaryColor,
                width: 1),
            borderRadius: BorderRadius.circular(25),
            color: selectValue == value ? kButtonColor : kBackGroundColor,
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  fontFamily: kFuturaPTBook,
                  fontSize: 15,
                  color: selectValue == value
                      ? kWhiteColor
                      : kButtonSecondaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
