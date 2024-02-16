import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';

class ShareWidget extends StatelessWidget {
  final String text;
  final String title;
  final String imageUrl;
  const ShareWidget(
      {Key? key, required this.title, required this.text, this.imageUrl = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        // String url = Platform.isIOS ? appStoreUrl : playStoreUrl;
        final String textdata;
        final String titledata;
        const String extradata = "*Click on link for further reading*";
        final textlength = text.length;
        titledata = "*$title*";

        if (textlength > 200 && imageUrl != '') {
          textdata = text.substring(0, 200);
          final uri = Uri.parse(imageUrl);
          final response = await http.get(uri);
          final bytes = response.bodyBytes;
          final temp = await getTemporaryDirectory();
          final path = '${temp.path}/image.jpg';
          File(path).writeAsBytesSync(bytes);
          // ignore: deprecated_member_use
          Share.shareFiles([path],
              text: '$titledata\n$textdata...\n\n$extradata\n');

          LoaderX.hide();
        } else {
          // DynamicLinkProvider().createLink("dkfkdfkd33444").then((value) =>
          //     Share.share('$titledata\n$text\n\n$extradata\n$value'));
          Share.share('$titledata\n$text\n\n$extradata\n');
          LoaderX.hide();
        }

        LoaderX.hide();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width > 500 ? 33 : 25.0,
            vertical: size.width > 500 ? 10 : 8),
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
              width: size.width > 500 ? 23 : 18,
              height: size.width > 500 ? 22 : 17,
              child: Image.asset(
                "assets/icons/Share.png",
                scale: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
