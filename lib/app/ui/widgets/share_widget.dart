// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constant/constant.dart';
import '../../../config/constant/color_constant.dart';

class ShareWidget extends StatelessWidget {
  final String text;
  final String title;
  final String imageUrl;
  const ShareWidget(
      {Key? key, required this.title, required this.text, this.imageUrl = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: share,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: kButtonSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xFF121330),
            boxShadow: const [
              BoxShadow(
                color: kBlack38Color,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 17,
              child: Image.asset(
                "assets/icons/Share.png",
                scale: 1.5,
              ),
            ),
            // const SizedBox(width: 5),
            // const Text(
            //   "625",
            //   style: TextStyle(fontSize: 14, color: kButtonSecondaryColor),
            // )
          ],
        ),
      ),
    );
  }

  share() async {
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';

    String appUrl = Platform.isIOS ? appStoreUrl : playStoreUrl;
    const titleText = "test..";
    final appLink = "Get the free app at $appUrl";

    Share.share('$titleText\n$text\n\n$appLink');
  }
}
